//
//  ClassDefinition.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation

class Class {
    
    var name : String = ""
    var package : String = ""
    var canonicalName : String {
        get {
            return package + "." + name
        }
    }
    var minorVersion : UInt16 = 0
    var mayorVersion : UInt16 = 0
    var constantPool = ConstantPool()
    var accessFlags : UInt16 = 0
    
    var methods : [Method] = []
    var interfaces : [String] = []
    var fields : [Field] = []
    
    func addConstant(value : Any) {
        constantPool.add(value: value)
    }
}
