//
//  JarView.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import SwiftUI

struct JarView: View {
    
    @EnvironmentObject var loader : JarLoader
    
    var body: some View {
        VStack {
            List(loader.entries, id: \.self) { entry in
                NavigationLink(entry.cannonicalName, destination: HexView(entry: entry)
                    .navigationBarBackButtonHidden(false))
                
            }
        }.navigationTitle(loader.jarName)
    }
}



struct JarView_Previews: PreviewProvider {
    static var previews: some View {
        JarView()
            .environmentObject(JarLoader())
    }
}
