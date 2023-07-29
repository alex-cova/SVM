//
//  ClassReader.swift
//  SVM
//
//  Created by Alex on 29/07/23.
//

import Foundation

class ClassReader {
    
    func read(clazz : ClassFile) -> Class {
        
        try? checkMagicNumber(clazz: clazz)
        
        return Class()
    }
    
    private func checkMagicNumber(clazz : ClassFile) throws {
        
        if clazz.read_UInt32() != 0xCAFEBABE {
            throw ParsingException.badMagicNumber
        }
    }
    
}
