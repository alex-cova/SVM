//
//  Buffer.swift
//  SVM
//
//  Created by Alex on 01/08/23.
//

import Foundation

class Buffer {
    
    var data : [UInt8] = []
    var index: Int = 0
    
    init() {
        
    }
    
    init(data : [UInt8]){
        self.data = data
    }
    
    func advance(amount: Int) -> Int {
        self.index = index + amount
        
        return self.index - amount
    }
    
    
    func readBytes(size : Int) -> ArraySlice<UInt8> {
        let byteArray = self.data[self.index..<(self.index + size)]
        
        _ = self.advance(amount: size)
        
        return byteArray
    }
    
    func read(size : Int, _ order: ByteOrder) -> [UInt8] {
        let byteArray = self.data[self.index..<(self.index + size)]
        
       _=self.advance(amount: size)
        
        if order == .littleEndian {
            return Array(byteArray.reversed())
        }
 
       
        
        return Array(byteArray)
    }
    
    func read_UInt8(order : ByteOrder = .littleEndian) -> UInt8 {
        
        let data = read(size: MemoryLayout<UInt8>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: UInt8.self) }
    }
    
    func read_UInt16(order : ByteOrder = .littleEndian) -> UInt16 {
        
        let data = read(size: MemoryLayout<UInt16>.size, order)
    
        return data.withUnsafeBytes { $0.load(as: UInt16.self) }
    }
    
    func read_UInt32(order : ByteOrder = .littleEndian) -> UInt32 {
        
        let data = read(size: MemoryLayout<UInt32>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: UInt32.self) }
    }
    
    func read_UInt64(order : ByteOrder = .littleEndian) -> UInt64 {
        
        let data = read(size: MemoryLayout<UInt64>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: UInt64.self) }
    }
    
    
    func read_Int8(order : ByteOrder = .littleEndian) -> Int8 {
        
        let data = read(size: MemoryLayout<Int8>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Int8.self) }
    }
    
    func read_Int16(order : ByteOrder = .littleEndian) -> Int16 {
        
        let data = read(size: MemoryLayout<Int16>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Int16.self) }
    }
    
    func read_Int32(order : ByteOrder = .littleEndian) -> Int32 {
        
        let data = read(size: MemoryLayout<Int32>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Int32.self) }
    }
    
    func read_Int64(order : ByteOrder = .littleEndian) -> Int64 {
        
        let data = read(size: MemoryLayout<Int64>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Int64.self) }
    }
    
    func read_Float32(order : ByteOrder = .littleEndian) -> Float32 {
        
        let data = read(size: MemoryLayout<Float32>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Float32.self) }
    }
    
    func read_Float64(order : ByteOrder = .littleEndian) -> Float64 {
        
        let data = read(size: MemoryLayout<Float64>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Float64.self) }
    }
    
    func read_Long64(order : ByteOrder = .littleEndian) -> Int64 {
        
        let data = read(size: MemoryLayout<Int64>.size, order)
        
        return data.withUnsafeBytes { $0.load(as: Int64.self) }
    }
        
    func read_Utf8(size : Int) -> String{
        let arraySlice = readBytes(size: size)
        
        let data = Data(arraySlice)

        
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    func readUtf8Constant() -> String {
        let len = read_UInt16()
        return read_Utf8(size: Int(len))
    }
    
    func readClassReferenceConstant() -> UInt16 {
        return read_UInt16()
    }
    
    func readMethodReferenceConstant() -> MethodReference {
        return MethodReference(classReference: read_UInt16(), nameAndType: read_UInt16())
    }
    
    func readInterfaceMethodReferenceConstant() -> InterfaceMethodReference {
        return InterfaceMethodReference(classReference: read_UInt16(), nameAndType: read_UInt16())
    }
    
    func readFieldReferenceConstant() -> FieldReference {
        return FieldReference(classReference: read_UInt16(), nameAndType: read_UInt16())
    }
    
    func readNameAndTypeConstant() -> NameAndTypeDescriptor {
        return NameAndTypeDescriptor(name: read_UInt16(), type: read_UInt16())
    }
    
    func readStringReference() -> StringReference {
        return StringReference(index: read_UInt16())
    }
    
    func readClassReference() -> ClassReference {
        return ClassReference(index: read_UInt16())
    }
}
