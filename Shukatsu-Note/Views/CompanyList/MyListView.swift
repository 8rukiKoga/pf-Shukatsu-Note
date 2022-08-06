//
//  MyListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI


struct Company: Identifiable {
    let id = UUID()
    let name: String
}

struct MyListView: View {
    
    private var companies = [
        Company(name: "A社"),
        Company(name: "B社"),
        Company(name: "C社")
    ]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color.init(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    
                    List {
                        ForEach(companies) { company in
                            NavigationLink(destination: CompanyView(company: company)) {
                                MainListRowView(company: company)
                                    .padding(10)
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    
                }
                
            }
            
            .navigationTitle("MyList")
        }
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView()
        
        MyListView()
            .preferredColorScheme(.dark)
    }
}
