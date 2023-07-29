//
//  ClassLoader.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation

class ClassLoader {
    
    private var classes : [String : Class] = [:]
    
    func register(clazz : Class) {
        classes[clazz.name] = clazz
    }
    
    func findByName(name : String) -> Class? {
        self.classes[name]
    }
    
}
