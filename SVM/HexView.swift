//
//  HexView.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import SwiftUI
import Combine



struct HexView: View {
    
    @State private var hexCode: String = "Loading..."
    
    let entry : ClassFile
    
    var body: some View {
        VStack {
            Text(hexCode)
                .padding()
        }.navigationTitle("HexView \(entry.name)")
        .onAppear {
            readAndConvertToHex()
        }
    }
    
    private func readAndConvertToHex() {
        hexCode = entry.data.map { String(format: "%02X ", $0) }.joined()
    }
    
}



