//
//  Extensions.swift
//  SVM
//
//  Created by Alex on 29/07/23.
//

import Foundation

extension Data {
    
    func toUInt8Array() -> [UInt8] {
        
        var uint8Array = [UInt8](repeating: 0, count: self.count)
        
        self.withUnsafeBytes { (rawBufferPointer) in
            let bufferPointer = rawBufferPointer.bindMemory(to: UInt8.self)
            uint8Array = Array(bufferPointer)
        }
        return uint8Array
    }
}
