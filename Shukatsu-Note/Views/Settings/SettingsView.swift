//
//  SettingsView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @ObservedObject var companyVm: CompanyViewModel
    @ObservedObject var noteVm: NoteViewModel
    
    @State private var showSheet: Bool = false
    @State private var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    @State var url: String = "https://8rukikoga.github.io/Portfolio/"
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    Section(header: Text("アプリの設定")) {
                        NavigationLink("テーマカラーを変更する", destination: ColorSettingView())
                        
                        Button {
                            showAlert.toggle()
                            
                        } label: {
                            Text("ノートを全て削除する")
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("警告"),
                                  message: Text("登録されたノート・企業がすべて削除されますが、よろしいですか？"),
                                  primaryButton: .default(Text("戻る"), action: {
                                return
                            }),
                                  secondaryButton: .destructive(Text("削除"), action: {
                                companyVm.companyList.removeAll()
                                
                            })
                            )}
                    }
                    Section(header: Text("サポート")) {
                        Button {
                            // AppStoreレビュー画面遷移
                            // リリース後にリンクを取得できるので、リリース後に実装
                        } label: {
                            Text("就活ノート を評価する")
                        }
                        Button {
                            // スグフォームまたは自分で実装
//                            url = ""
//                            showSheet.toggle()
                        } label: {
                            Text("不具合・リクエストを送信する")
                        }
//                        .sheet(isPresented: $showSheet) {
//                            WebView(url: $url)
//                        }
                    }
                    
                    Section(header: Text("開発者の他のアプリ")) {
                        Button {
                            // AppStoreに遷移
//                            seeApp(url: "")
                        } label: {
                            HStack {
                                Image("25minsLogo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(12)
                                    .padding(5)
                                
                                VStack(alignment: .leading) {
                                    Text("25mins.")
                                    Text("作業を記録できるポロモードタイマーアプリ")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 10))
                                }
                                .padding(.leading, 2)
                            }
                        }
                    }
                    
                    Section(header: Text("このアプリについて")) {
                        NavigationLink("アプリの使い方", destination: HowToUseView())
                        
                        Button {
                            url = "https://8rukikoga.github.io/Portfolio/"
                            showSheet.toggle()
                        } label: {
                            Text("開発者はどんな人？")
                        }
                        .sheet(isPresented: $showSheet) {
                            WebView(url: $url)
                        }
                        
                        HStack {
                            Text("バージョン")
                            Spacer()
                            Text("1.0")
                        }
                        Button {
                            // リリース直前にPFサイトにアプリを掲載→そのリンクをここに記載する
//                            url = ""
//                            showSheet.toggle()
                        } label: {
                            Text("プライバシーポリシー")
                        }
                        .sheet(isPresented: $showSheet) {
                            WebView(url: $url)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Settings")
    }
    
    // レビューアラート表示
    func reviewApp(){
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    // appstoreを開く
    func seeApp(url: String){
        let productURL:URL = URL(string: url)!
        UIApplication.shared.open(productURL)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(companyVm: CompanyViewModel(), noteVm: NoteViewModel())
    }
}
