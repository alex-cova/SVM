//
//  Modifiers.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation

class Modifier {
    
    public static let PUBLIC           = 0x00000001
    public static let PRIVATE          = 0x00000002
    public static let PROTECTED        = 0x00000004
    public static let STATIC           = 0x00000008
    public static let FINAL            = 0x00000010
    public static let SYNCHRONIZED     = 0x00000020
    public static let VOLATILE         = 0x00000040
    public static let TRANSIENT        = 0x00000080
    public static let NATIVE           = 0x00000100
    public static let INTERFACE        = 0x00000200
    public static let ABSTRACT         = 0x00000400
    public static let STRICT           = 0x00000800
    
    public static let BRIDGE    = 0x00000040
    public static let VARARGS   = 0x00000080
    public static let SYNTHETIC = 0x00001000
    public static let ANNOTATION  = 0x00002000
    public static let ENUM      = 0x00004000
    public static let MANDATED  = 0x00008000
    
    public static let RECORD = 0x10000
    
    public static let OPEN = 0x0020
    public static let MODULE = 0x8000
    public static let STATIC_PHASE = 0x0040
    
    
    public static let  CLASS_MODIFIERS =
    Modifier.PUBLIC         | Modifier.PROTECTED    | Modifier.PRIVATE |
    Modifier.ABSTRACT       | Modifier.STATIC       | Modifier.FINAL   |
    Modifier.STRICT
    
    public static let INTERFACE_MODIFIERS =
    Modifier.PUBLIC         | Modifier.PROTECTED    | Modifier.PRIVATE |
    Modifier.ABSTRACT       | Modifier.STATIC       | Modifier.STRICT
    
    public static let CONSTRUCTOR_MODIFIERS =
    Modifier.PUBLIC         | Modifier.PROTECTED    | Modifier.PRIVATE
    
    
    public static let METHOD_MODIFIERS =
    Modifier.PUBLIC         | Modifier.PROTECTED    | Modifier.PRIVATE |
    Modifier.ABSTRACT       | Modifier.STATIC       | Modifier.FINAL   |
    Modifier.SYNCHRONIZED   | Modifier.NATIVE       | Modifier.STRICT
    
    public static let FIELD_MODIFIERS =
    Modifier.PUBLIC         | Modifier.PROTECTED    | Modifier.PRIVATE |
    Modifier.STATIC         | Modifier.FINAL        | Modifier.TRANSIENT |
    Modifier.VOLATILE
    
    public static let PARAMETER_MODIFIERS =
    Modifier.FINAL
    
    public static let ACCESS_MODIFIERS =
    Modifier.PUBLIC | Modifier.PROTECTED | Modifier.PRIVATE
    
    public static func isFinal(mod : Int) -> Bool {
        return (mod & FINAL) != 0
    }
    
    public static func isPublic(mod : Int) -> Bool {
        return (mod & PUBLIC) != 0
    }
    
    public static func isPrivate(mod : Int) -> Bool {
        return (mod & PRIVATE) != 0
    }
    
    public static func isProtected(mod : Int) -> Bool {
        return (mod & PROTECTED) != 0
    }
    
    public static func isAbstract(mod : Int) -> Bool {
        return (mod & ABSTRACT) != 0
    }
}
