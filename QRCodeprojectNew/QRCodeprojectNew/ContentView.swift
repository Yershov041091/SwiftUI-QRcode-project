//
//  ContentView.swift
//  QRCodeprojectNew
//
//  Created by Artem Yershov on 30.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Prospects(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            Prospects(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            Prospects(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
