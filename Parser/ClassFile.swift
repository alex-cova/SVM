//
//  ClassEntry.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation


class ClassFile : Buffer, Identifiable, Hashable {
    
    static func == (lhs: ClassFile, rhs: ClassFile) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
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
    
    var annonClass : Bool {
        get {
            name.contains("$")
        }
    }
    
    init(_ url : URL,_ parentUrl : URL) {
        
        self.url = url
        self.id = url
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
        
       
        
        
        if name.hasSuffix(".class") {
            icon = "cup.and.saucer.fill"
        } else {
            icon = "doc.fill"
        }
        
        super.init()
        
        do{
            let x = try Data(contentsOf: url)
            
            self.data = x.toUInt8Array()
        }catch {
            print(error)
        }
     
        
        
    }
    
    func read() -> Class {
        
        if(package.isEmpty){ return Class() }
        
        return ClassReader()
            .read(file: self)
    }
    
}






enum ByteOrder {
    case littleEndian
    case bigEndian
}
