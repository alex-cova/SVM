//
//  ContantPool.swift
//  SVM
//
//  Created by Alex on 01/08/23.
//

import Foundation

class ConstantPool {
    private var entries : [Any] = []
    
    func add(value : Any){
        entries.append(ConstantPoolEntry(value: value))
    }
    
    func get(index : UInt16) -> Any {
        entries[Int(index)]
    }
}

struct ConstantPoolEntry {
    let value : Any
    
}

struct NameAndTypeDescriptor {
    let name : UInt16
    let type : UInt16
}

struct InterfaceMethodReference {
    let classReference : UInt16
    let nameAndType : UInt16
}

struct MethodReference {
    let classReference : UInt16
    let nameAndType : UInt16
}

struct FieldReference {
    let classReference : UInt16
    let nameAndType : UInt16
}

struct StringReference {
    let index : UInt16
}

struct ClassReference {
    let index : UInt16
}

struct Utf8Constant {
    let value : String
}
