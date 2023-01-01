//
//  SettingsView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct SettingsView: View, UrlOpener {
    
    @AppStorage(wrappedValue: "ThemeColor1", "theme_color") var themeColor
    @AppStorage(wrappedValue: 0, "appearanceMode") var appearanceMode
    
    @State private var url: String = ""
    
    @State var showingWalkthrough: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    
                    Section(header: Text(NSLocalizedString("アプリの設定", comment: "")).foregroundColor(Color(themeColor))) {
                        HStack {
                            Image(systemName: "paintpalette")
                                .font(.caption)
                            NavigationLink(NSLocalizedString("テーマカラーを変更する", comment: ""), destination: ColorSettingView())
                        }
                        
                        HStack {
                            Image(systemName: "rectangle.on.rectangle.angled")
                                .font(.caption)
                            Picker(NSLocalizedString("テーマを変更する", comment: ""), selection: $appearanceMode) {
                                Text(NSLocalizedString("端末のテーマ", comment: ""))
                                    .tag(0)
                                Text(NSLocalizedString("ダークモード", comment: ""))
                                    .tag(1)
                                Text(NSLocalizedString("ライトモード", comment: ""))
                                    .tag(2)
                            }
                        }
                    }
                    
                    Section(header: Text(NSLocalizedString("サポート", comment: "")).foregroundColor(Color(themeColor))) {
                        Button {
                            openUrl(url: "https://apps.apple.com/app/id1645528668")
                        } label: {
                            HStack {
                                Image(systemName: "star")
                                    .font(.caption)
                                Text(NSLocalizedString("就活ノート を評価する", comment: ""))
                            }
                        }
                        
                        Button {
                            openUrl(url: "https://docs.google.com/forms/d/e/1FAIpQLSdWUjv9hDJB4TMZ-e2Mxx37jgR2qenCR2LS8AJQ1jbuqryS4Q/viewform?usp=sf_link")
                        } label: {
                            HStack {
                                Image(systemName: "bubble.right")
                                    .font(.caption)
                                Text(NSLocalizedString("お問い合わせをする\n(不具合・機能のリクエストなど)", comment: ""))
                                    .font(.system(size: 15))
                            }
                        }
                    }
                    
                    Section(header: Text(NSLocalizedString("開発者の他のアプリ", comment: "")).foregroundColor(Color(themeColor))) {
                        Button {
                            openUrl(url: "https://apps.apple.com/us/app/%E3%81%95%E3%81%B6%E3%81%99%E3%81%8F%E7%AE%A1%E7%90%86/id1617774926?itsct=apps_box_link&itscg=30200")
                        } label: {
                            HStack {
                                Image("SabusukuKanriLogo")
                                    .resizable()
                                    .modifier(AppLogoMod())
                                
                                VStack(alignment: .leading) {
                                    Text(NSLocalizedString("さぶすく管理", comment: ""))
                                        .font(.body)
                                    
                                    Text(NSLocalizedString("登録しているサブスクを見える化するアプリ", comment: ""))
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                .padding(.leading, 2)
                            }
                        }
                    }
                    
                    Section(header: Text(NSLocalizedString("このアプリについて", comment: "")).foregroundColor(Color(themeColor))) {
                        
                        Button {
                            showingWalkthrough = true
                        } label: {
                            HStack {
                                Image(systemName: "book")
                                    .font(.caption)
                                Text(NSLocalizedString("使い方を見る", comment: ""))
                            }
                        }
                        .fullScreenCover(isPresented: $showingWalkthrough) {
                            WalkthroughView(showingWalkthrough: $showingWalkthrough)
                        }
                        
                        Button {
                            openUrl(url: "https://8rukikoga.github.io/pf-Portfolio/ShukatsuNote.html")
                        } label: {
                            HStack {
                                Image(systemName: "person")
                                    .font(.caption)
                                Text(NSLocalizedString("プライバシーポリシーを読む", comment: ""))
                            }
                        }
                        
                        HStack {
                            Image(systemName: "timelapse")
                                .font(.caption)
                            Text(NSLocalizedString("バージョン", comment: ""))
                            
                            Spacer()
                            
                            Text("2.0.2")
                        }
                    }
                }
                .foregroundColor(Color(.label))
                .listStyle(.plain)
            }
            .navigationTitle("Settings")
        }
    }
    
}
