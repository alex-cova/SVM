//
//  ClassReader.swift
//  SVM
//
//  Created by Alex on 29/07/23.
//

import Foundation

class ClassReader {
    
    var clazz : Class = Class()
    
    func read(file : ClassFile) -> Class {
        
        clazz.name = file.name
        clazz.package = file.package
        
        checkMagicNumber(file: file)
        readVersion(file: file)
        readConstants(file: file)
        readAccessFlags(file: file)
        let name = readClassReference(file: file)
        let superClass = readSuperClass(file: file)
        readInterfaces(file: file)
        readFields(file: file)
        readMethods(file: file)
        readClassAttributes(file: file)

        print("Class : \(name) SuperClass: \(superClass)")
        
        return clazz
    }
    
    private func checkMagicNumber(file : ClassFile) {
        
        let magic = file.read_UInt32()
        
        if magic != 0xCAFEBABE {
            print("Incorrect magic number: \(magic)")
        }
    }
    
    private func readVersion(file : ClassFile) {
        
        clazz.minorVersion = file.read_UInt16()
        clazz.mayorVersion = file.read_UInt16()
    }
    
    private func readAccessFlags(file : ClassFile){
        clazz.accessFlags = file.read_UInt16()
    }
    
    private func readClassReference(file : ClassFile) -> String {
        let constantIndex = file.read_UInt16()
        
        let reference = readStringReference(index: constantIndex)
        
        return reference
    }
    
    private func readSuperClass(file : ClassFile) -> String? {
        let constantIndex = file.read_UInt16()
        
        if constantIndex == 0 {
            return nil
        }
        
        let reference = readStringReference(index: constantIndex)
    
        return reference
    }
    
    private func readInterfaces(file : ClassFile) {
        let count = file.read_UInt16()
        
        for _ in 0..<count {
            clazz.interfaces.append(readClassReference(file: file))
        }
        
    }
    
    private func readFields(file : ClassFile) {
        
        let count = file.read_UInt16()
                
        for _ in 0..<count {
            clazz.fields.append(readField(file: file))
        }
    }
    
    private func readField(file : ClassFile) -> Field {
        let flags = file.read_UInt16()
        let nameIndex = file.read_UInt16()
        let name = readStringReference(index: nameIndex)
        let typeConstantIndex = file.read_UInt16()
        let typeDescriptor = readStringReference(index: typeConstantIndex)
        let rawAttributes = readRawAttributes(file: file)
        
        
        return Field(flags: flags, name: name, deprecated: isDeprecated(attributes: rawAttributes), attributes: rawAttributes, typeDescriptor: typeDescriptor)
        
    }
    
    private func isDeprecated(attributes : [Attribute]) -> Bool {
        attributes.contains {
            $0.name == "Deprecated"
        }
    }
    
    private func readRawAttributes(file : Buffer) -> [Attribute] {
        let count = file.read_UInt16()
        var list : [Attribute] = []
        
        for _ in 0..<count {
            list.append(readRawAttribute(file: file))
        }
        
        return list
    }
    
    private func readRawAttribute(file : Buffer) -> Attribute {
        let nameIndex = file.read_UInt16()
        let name = readStringReference(index: nameIndex)
        let len = file.read_UInt32()
        let bytes = file.readBytes(size: Int(len))
        
        return Attribute(name: name, bytes: Array(bytes))
    }
    
    private func readMethods(file : ClassFile) {
        let count = file.read_UInt16()
        
        for _ in 0..<count {
            clazz.methods.append(readMethod(file: file))
        }
    }
    
    private func readMethod(file : ClassFile) -> Method {
        let flags = file.read_UInt16()
        let nameIndex = file.read_UInt16()
        let name = readStringReference(index: nameIndex)
        let typeIndex = file.read_UInt16()
        let typeDescriptor = readStringReference(index: typeIndex)
        let attributes = readRawAttributes(file: file)
        let code = extractCode(attributes: attributes, name: name)
        let deprecated = isDeprecated(attributes: attributes)
        let thrownExceptions = extractThrownExceptions(attributes: attributes)
        
        
        return Method(flags: flags, name: name, typeDescriptor: typeDescriptor, attributes: attributes, code: code, deprecated: deprecated, thrownExceptions: thrownExceptions)
    }
    
    private func  extractCode(attributes: [Attribute], name : String) -> MethodCode?{
        
        let codes = attributes.filter { $0.name == "Code"}
        
        if codes.count == 0 {
            return nil
        }
        
        let attribute = codes[0]
        
        let buffer = Buffer(data: attribute.bytes)
        
        let max_stack = buffer.read_UInt16()
        let max_locals = buffer.read_UInt16()
        let codeLength = buffer.read_UInt32()
        let code = Array(buffer.readBytes(size: Int(codeLength)))
        let exceptionTable = readExceptionTable(buffer: buffer)
        let attributes = readRawAttributes(file: buffer)
        let lineNumberTable = readLineNumberTable(attributes: attributes)
        
        return MethodCode(maxStack: max_stack, maxLocals: max_locals, code: code, attributes: attributes, exceptionTable: exceptionTable, lineNumberTable: lineNumberTable)
        
    }
    
    private func readLineNumberTable(attributes : [Attribute]) -> LineNumberTable {
        
        let filtered = attributes.filter { $0.name == "LineNumberTable" }
        
        var entries : [LineNumberTableEntry] = []
        
        for attribute in filtered {
            
            let buffer = Buffer(data: attribute.bytes)
            let count = buffer.read_UInt16()
           
            for _ in 0..<count {
                let programCounter = buffer.read_UInt16()
                let lineNumber = buffer.read_UInt16()
                
                entries.append(LineNumberTableEntry(programCounter: ProgramCounter(value: programCounter), lineNumber: LineNumber(value: lineNumber)))
            }
            
        }
        
        return LineNumberTable(entries: entries)
        
    }
    
    private func readExceptionTable(buffer : Buffer) -> ExceptionTable {
        
        let tableLength = buffer.read_UInt16()
        var entries : [ExceptionTableEntry] = []
        
        for _ in 0..<tableLength {
            
            let start = buffer.read_UInt16()
            let end = buffer.read_UInt16()
            let handler = buffer.read_UInt16()
            let catchClassIndex = buffer.read_UInt16()
            let catchClass = readStringReference(index: catchClassIndex)
            
            entries.append(ExceptionTableEntry(start: ProgramCounter(value: start) , end: ProgramCounter(value: end), handler: ProgramCounter(value: handler), catchClass: catchClass))
        }
        
        return ExceptionTable(entries: entries)
        
    }
    
    private func extractThrownExceptions(attributes : [Attribute]) -> [String] {
        
        let attribs = attributes.filter {
            $0.name == "Exceptions"
        }
        
        var exceptions : [String] = []
        
        for exception in attribs {
            let buffer = Buffer(data: exception.bytes)
            let numEntries = buffer.read_UInt16()
           
            
            for _ in 0..<numEntries {
                let classNameIndex = buffer.read_UInt16()
                let className = self.readStringReference(index: classNameIndex)
                
                exceptions.append(className)
            }
            
        }
        
        return exceptions
    }
    
    private func readClassAttributes(file : ClassFile){
        let attributes = readRawAttributes(file: file)
    }
    
    private func readConstants(file : ClassFile){
        
        let constantCount = file.read_UInt16()
        
        for i in 0..<constantCount {
            let tag = file.read_UInt8()
            
            switch(tag){
            case 1://Utf8
                clazz.addConstant(value: file.readUtf8Constant())
            case 3://Int
                clazz.constantPool.add(value: file.read_Int32())
            case 4://Float
                clazz.constantPool.add(value: file.read_Float32())
            case 5://Long
                clazz.constantPool.add(value: file.read_Long64())
            case 6://Double
                clazz.constantPool.add(value: file.read_Float64())
            case 7://Class reference
                clazz.addConstant(value: file.readClassReference())
            case 8://String reference
                clazz.addConstant(value: file.readStringReference())
            case 9://Field reference
                clazz.addConstant(value: file.readFieldReferenceConstant())
            case 10://Method reference
                clazz.addConstant(value: file.readMethodReferenceConstant())
            case 11://Interface method reference
                clazz.addConstant(value: file.readInterfaceMethodReferenceConstant())
            case 12://Name and type constant
                clazz.addConstant(value: file.readNameAndTypeConstant())
            default:
                print("Missing constant type: \(tag) at index: \(i)")
            }
            
        }
        
    }
    
    func readStringReference(index : UInt16) -> String {
        let value = clazz.constantPool.get(index: index)
        
        if let stringReference = value as? StringReference {
            return readStringReference(index: stringReference.index)
        }
        
        if let utf8 = value as? Utf8Constant {
            return utf8.value
        }
        
        return "failed"
    }
}
