//
//  Method.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation

struct Method {
    
    let flags : UInt16
    let name : String
    let typeDescriptor : String
    let attributes : [Attribute]
    let code : MethodCode?
    let deprecated : Bool
    let thrownExceptions : [String]
    
}

struct MethodCode {
    let maxStack : UInt16
    let maxLocals : UInt16
    let code : [UInt8]
    let attributes : [Attribute]
    let exceptionTable : ExceptionTable
    let lineNumberTable : LineNumberTable
    
    
}
