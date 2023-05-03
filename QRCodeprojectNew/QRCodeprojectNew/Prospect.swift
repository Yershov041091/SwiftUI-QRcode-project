//
//  Prospect.swift
//  QRCodeprojectNew
//
//  Created by Artem Yershov on 30.04.2023.
//

import SwiftUI

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anonimous"
    var email = ""
    var isContacted = false
}

@MainActor class ProspectsData: ObservableObject{
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    func toggle(_ prospect: Prospect){
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
