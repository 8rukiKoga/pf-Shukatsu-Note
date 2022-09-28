//
//  SettingsView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var customColor: CustomColor
    @EnvironmentObject private var companyIcon: CompanyIcon
    
    @State private var url: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    
                    Section(header: Text("アプリの設定").foregroundColor(Color(customColor.themeColor))) {
                        NavigationLink("テーマカラーを変更する", destination: ColorSettingView())
                        
                        Toggle(isOn: companyIcon.$isCompanyImage) {
                            Text("企業フォルダのアイコンを画像にする")
                        }
                    }
                    
                    Section(header: Text("サポート").foregroundColor(Color(customColor.themeColor))) {
                        Button {
                            openUrl(url: "https://apps.apple.com/app/id1645528668")
                        } label: {
                            Text("就活ノート を評価する")
                        }
                        
                        Button {
                            openUrl(url: "https://docs.google.com/forms/d/e/1FAIpQLSdWUjv9hDJB4TMZ-e2Mxx37jgR2qenCR2LS8AJQ1jbuqryS4Q/viewform?usp=sf_link")
                        } label: {
                            Text("お問い合わせをする\n(不具合・機能のリクエストなど)")
                                .font(.system(size: 15))
                        }
                    }
                    
                    Section(header: Text("開発者の他のアプリ").foregroundColor(Color(customColor.themeColor))) {
                        Button {
                            openUrl(url: "https://apps.apple.com/us/app/%E3%81%95%E3%81%B6%E3%81%99%E3%81%8F%E7%AE%A1%E7%90%86/id1617774926?itsct=apps_box_link&itscg=30200")
                        } label: {
                            HStack {
                                Image("SabusukuKanriLogo")
                                    .resizable()
                                    .modifier(AppLogoMod())
                                
                                VStack(alignment: .leading) {
                                    Text("さぶすく管理")
                                        .foregroundColor(Color(.label))
                                        .font(.body)
                                    
                                    Text("登録しているサブスクを見える化するアプリ")
                                }
                                .padding(.leading, 2)
                            }
                        }
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                    }
                    
                    Section(header: Text("このアプリについて").foregroundColor(Color(customColor.themeColor))) {
                        
                        HStack {
                            Text("バージョン")
                            
                            Spacer()
                            
                            Text("1.2.1")
                        }
                        Button {
                            openUrl(url: "https://8rukikoga.github.io/pf-Portfolio/ShukatsuNote.html")
                        } label: {
                            Text("プライバシーポリシー")
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Settings")
        }
    }
    
    // urlを開く
    private func openUrl(url: String){
        let productURL:URL = URL(string: url)!
        UIApplication.shared.open(productURL)
    }
    
}
