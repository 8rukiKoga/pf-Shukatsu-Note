//
//  MyListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MyListView: View {
    
    @ObservedObject var companyVm: CompanyViewModel
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color.init(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    
                    List {
                        Section {
                            
                        } header: {
                            HStack {
                                Text("Memo")
                                Spacer()
                                Button {
                                    print("new memo")
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                        .font(.system(size: 15))
                                }
                                .padding(.trailing, 10)

                            }
                        }


                        
                        Section {
                            ForEach(companyVm.companyList) { company in
                                NavigationLink(destination: CompanyView(company: company)) {
                                    MainListRowView(company: company)
                                        .padding(10)
                                }
                            }
                        } header: {
                            HStack {
                                Text("企業リスト")
                                Spacer()
                                Button {
                                    print("new folder")
                                } label: {
                                    Image(systemName: "folder.badge.plus")
                                        .font(.system(size: 15))
                                }
                                .padding(.trailing, 10)

                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                }
                
            }
            
            .navigationTitle("Notes")
        }
    }
}

struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        return Group {
            MyListView(companyVm: testCompany)
            
            MyListView(companyVm: testCompany)
                .preferredColorScheme(.dark)
        }
    }
}
