//
//  SwiftUIView.swift
//  QRCodeprojectNew
//
//  Created by Artem Yershov on 30.04.2023.
//

import SwiftUI
import CodeScanner

struct Prospects: View {
    //create a filter that'll filter our ProspectView
    enum FilterType{
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospectsData: ProspectsData
    @State private var isShowingScaner = false
    
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
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospectsData.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospectsData.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        isShowingScaner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                .sheet(isPresented: $isShowingScaner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Yershov Artem \n altek.ua", completion: scanHandle)
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
    func scanHandle(result: Result<ScanResult, ScanError>){
        isShowingScaner = false
        
        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let people = Prospect()
            people.name = details[0]
            people.email = details[1]
            prospectsData.people.append(people)
            
        case .failure(let failure):
            print("Failed scan: \(failure.localizedDescription)")
        }
    }
}

struct Prospects_Preview: PreviewProvider {
    static var previews: some View {
        Prospects(filter: .none)
            .environmentObject(ProspectsData())
    }
}
