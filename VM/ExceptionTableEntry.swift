//
//  ExceptionTableEntry.swift
//  SVM
//
//  Created by Alex on 01/08/23.
//

import Foundation

struct ExceptionTableEntry {
    let start : ProgramCounter
    let end : ProgramCounter
    let handler : ProgramCounter
    let catchClass : String?
}
