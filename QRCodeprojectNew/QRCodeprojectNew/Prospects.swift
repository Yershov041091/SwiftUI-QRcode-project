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
    
    @EnvironmentObject var prospectsData: ProspectsData
    
    let filter: FilterType
    
    var body: some View {
        NavigationView{
            List{
                ForEach(filterProspects){prospect in
                    VStack(alignment: .leading){
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        let prospect = Prospect()
                        prospect.name = "Artem Yershov"
                        prospect.email = "centr@altec.ua"
                        prospect.isContacted = true
                        prospectsData.people.append(prospect)
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
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
    var filterProspects: [Prospect]{
        switch filter {
        case .none:
            return prospectsData.people
        case .contacted:
            return prospectsData.people.filter {$0.isContacted}
        case .uncontacted:
            return prospectsData.people.filter {!$0.isContacted}
        }
    }
}

struct Prospects_Preview: PreviewProvider {
    static var previews: some View {
        Prospects(filter: .none)
            .environmentObject(ProspectsData())
    }
}
