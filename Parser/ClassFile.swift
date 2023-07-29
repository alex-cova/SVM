//
//  ClassEntry.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation


class ClassFile : Identifiable, Hashable {
    
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
    var data : [UInt8] = []
    var index: Int = 0
    
    func advance(amount: Int) {
        self.index = index + amount
    }
    
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
        
        do{
            let x = try Data(contentsOf: url)
            
            self.data = x.toUInt8Array()
        }catch {
            print(error)
        }
        
    }
    
}


extension ClassFile {
    
    func readBytes(size : Int) -> ArraySlice<UInt8> {
        let byteArray = self.data[self.index..<(self.index + size)]
        
        self.advance(amount: size)
        
        return byteArray
    }
    
    func read(size : Int) -> Data {
        let byteArray = self.data[self.index..<(self.index + size)]
        
        let data = Data(byteArray)
        
        self.advance(amount: size)
        
        return data
    }
    
    func read_UInt8() -> UInt8 {
        
        let data = read(size: MemoryLayout<UInt8>.size)
        
        return data.withUnsafeBytes { $0.load(as: UInt8.self) }
    }
    
    func read_UInt16() -> UInt16 {
        
        let data = read(size: MemoryLayout<UInt16>.size)
        
        return data.withUnsafeBytes { $0.load(as: UInt16.self) }
    }
    
    func read_UInt32() -> UInt32 {
        
        let data = read(size: MemoryLayout<UInt32>.size)
        
        return data.withUnsafeBytes { $0.load(as: UInt32.self) }
    }
    
    func read_UInt64() -> UInt64 {
        
        let data = read(size: MemoryLayout<UInt64>.size)
        
        return data.withUnsafeBytes { $0.load(as: UInt64.self) }
    }
    
    
    func read_Int8() -> Int8 {
        
        let data = read(size: MemoryLayout<Int8>.size)
        
        return data.withUnsafeBytes { $0.load(as: Int8.self) }
    }
    
    func read_Int16() -> Int16 {
        
        let data = read(size: MemoryLayout<Int16>.size)
        
        return data.withUnsafeBytes { $0.load(as: Int16.self) }
    }
    
    func read_Int32() -> Int32 {
        
        let data = read(size: MemoryLayout<Int32>.size)
        
        return data.withUnsafeBytes { $0.load(as: Int32.self) }
    }
    
    func read_Int64() -> Int64 {
        
        let data = read(size: MemoryLayout<Int64>.size)
        
        return data.withUnsafeBytes { $0.load(as: Int64.self) }
    }
    
    func read_Float32() -> Float32 {
        
        let data = read(size: MemoryLayout<Float32>.size)
        
        return data.withUnsafeBytes { $0.load(as: Float32.self) }
    }
    
    func read_Float64() -> Float64 {
        
        let data = read(size: MemoryLayout<Float64>.size)
        
        return data.withUnsafeBytes { $0.load(as: Float64.self) }
    }
    
    func read_Utf8(size : Int) -> String{
        let arraySlice = readBytes(size: size)
        
        let data = Data(arraySlice)

        
        return String(data: data, encoding: .utf8) ?? ""
    }
    
}
