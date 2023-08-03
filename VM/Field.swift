//
//  Field.swift
//  SVM
//
//  Created by Alex on 01/08/23.
//

import Foundation

struct Field {
    let flags : UInt16
    let name : String
    let deprecated : Bool
    let attributes : [Attribute]
    let typeDescriptor : String
}

