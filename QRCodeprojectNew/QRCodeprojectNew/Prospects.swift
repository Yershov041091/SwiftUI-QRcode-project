//
//  SwiftUIView.swift
//  QRCodeprojectNew
//
//  Created by Artem Yershov on 30.04.2023.
//

import SwiftUI

struct Prospects: View {
    //create a filter that'll filter our ProspectView
    enum FilterType{
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    var body: some View {
        NavigationView{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle(title)
        }
    }
    var title: String{
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contected"
        case .uncontacted:
            return "Uncontacted"
        }
    }
}

struct Prospects_Preview: PreviewProvider {
    static var previews: some View {
        Prospects(filter: .none)
    }
}
