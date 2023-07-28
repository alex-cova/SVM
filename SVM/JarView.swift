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
        List(loader.entries, id: \.self) { entry in
            Label(entry.cannonicalName, systemImage: entry.icon )
            .frame(height: 35)
        }.navigationTitle(loader.jarName)
    }
}



struct JarView_Previews: PreviewProvider {
    static var previews: some View {
        JarView()
            .environmentObject(JarLoader())
    }
}
