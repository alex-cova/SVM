//
//  ClassEntry.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation

struct ClassEntry : Identifiable, Hashable {
    
    let id : URL
    let package : String
    let name : String
    let url : URL
    let icon : String
    var cannonicalName : String {
        get {
            
            if name.hasSuffix(".class") {
                return package + "." + name
            }
            
            return name
        }
    }
    
    init(_ url : URL,_ parentUrl : URL) {
        
        self.name = url.lastPathComponent
        
        if name.hasSuffix(".class") {
            var pack : [String] = []
            
            for path in url.pathComponents.reversed() {
                
                if path == parentUrl.lastPathComponent {
                    break
                }
                
                if path == url.lastPathComponent {
                    continue
                }
                
                pack.append(path)
            }
            
            pack.reverse()
            
            self.package = pack.joined(separator: ".")
        }else{
            self.package = ""
        }
            
        
        
        self.url = url
        self.id = url
        
        
        if name.hasSuffix(".class") {
            icon = "cup.and.saucer.fill"
        } else {
            icon = "doc.fill"
        }
    }
    
}
