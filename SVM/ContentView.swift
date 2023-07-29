//
//  ContentView.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var draggedFile: URL?
    @State private var isHovering: Bool = false
    @State private var showDestination : Bool = false
    @State private var errorMessage : String?
    
    @State private var backgroundColor = Color.clear
    
    private let loader = JarLoader()
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                
                VStack{
                    if draggedFile != nil {
                        Text("Dragged File: \(draggedFile!.absoluteString)")
                        Button("Run") {
                            if(loader.load(url: draggedFile!)){
                                showDestination = true
                            }else{
                                errorMessage = "Failed to load jar file"
                            }
                        }.buttonStyle(.borderedProminent)
                    } else {
                        Text("Drag and Drop a Jar file Here")
                            .foregroundColor(isHovering ? Color.white : Color.black)
                    }
                    
                    if(errorMessage != nil) {
                        Text(errorMessage!)
                    }
                }
                
            } .onHover { isHovering in
                self.isHovering = isHovering
                
                if isHovering {
                    self.backgroundColor = Color.blue.opacity(0.7)
                }else{
                    self.backgroundColor = Color.clear
                }
            }
            .animation(.easeInOut, value: isHovering)
            .navigationDestination(isPresented: $showDestination){
                JarView()
                    .environmentObject(loader)
                    .navigationBarBackButtonHidden(true)
            }
        }.navigationTitle("Drop & Load")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDrop(of: [.fileURL], isTargeted: $isHovering) { providers -> Bool in
            if let itemProvider = providers.first,
               itemProvider.canLoadObject(ofClass: URL.self) {
                _ = itemProvider.loadObject(ofClass: URL.self) { url, error in
                    if let url = url {
                        DispatchQueue.main.async {
                            self.draggedFile = url
                        }
                    }
                }
                return true
            }
            return false
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
