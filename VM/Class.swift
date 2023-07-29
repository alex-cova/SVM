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
    
}
