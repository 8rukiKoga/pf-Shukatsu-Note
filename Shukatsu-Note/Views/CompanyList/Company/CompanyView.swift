//
//  CompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct CompanyView: View {
    
    var company: CompanyModel
    @State var memoText: String = "すぐに見たい情報をここに記載します。\n選考フローやマイページのID・パスワードなど"
    @FocusState private var inputFocus: Bool
    
    var body: some View {
        
        List {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 120, height: 120)
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                                .foregroundColor(Color(.systemBackground))
                                .font(.system(size: 60))
                        }
                        Spacer()
                    }
                    HStack {
                        Text("志望度 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("★★★★☆")
                            .foregroundColor(Color(.systemYellow))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 10)
                    .padding(1)
                    HStack {
                        Text("業界・業種 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("エンジニア")
                            .font(.system(size: 15))
                    }
                    .padding(1)
                    HStack {
                        Text("所在地 : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("東京都港区")
                            .font(.system(size: 15))
                    }
                    .padding(1)
                    HStack {
                        Text("URL : ")
                            .font(.system(size: 15))
                        Spacer()
                        Text("https://apps.apple.com/us/app/%E3%81%95%E3%81%B6%E3%81%99%E3%81%8F%E7%AE%A1%E7%90%86/id1617774926?itsct=apps_box_link&itscg=30200")
                            .font(.system(size: 6))
                    }
                    .padding(1)
                    
                    TextEditor(text: $memoText)
                        .padding(.horizontal, 2)
                        .frame(height: 100)
                        .background(Color(.systemGray5))
                        .cornerRadius(3)
                        .focused($inputFocus)
                        .padding(.top, 10)
                        .font(.caption)
                }
                .padding()
            } header: {
                HStack {
                    Text("企業情報")
                    Spacer()
                    Button {
                        // 編集画面を開く
                        print("編集")
                    } label: {
                        Text("編集")
                            .font(.system(size: 12))
                    }
                    
                }
            }
            .textCase(nil)
            
            Section {
                Text("インターンシップで学んだこと")
                Text("説明会で聞いたこと")
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

                }
            }
            .textCase(nil)
            
        }
        .listStyle(InsetGroupedListStyle())
        .onTapGesture {
            inputFocus = false
        }
        
        .navigationTitle(company.name)
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompanyView(company: .init(name: "A社"))
        }
        NavigationView {
            CompanyView(company: .init(name: "A社"))
                .preferredColorScheme(.dark)
        }
    }
}
