//
//  ContentView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MainView: View {
    @StateObject var companyVm = CompanyViewModel()
    @StateObject var noteVm = NoteViewModel()
    @StateObject var todoVm = TodoViewModel()
    
    // noteViewにてtabviewの背景上にテキストが浮かび上がらないようにするために背景色を塗る
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
    }
    
    var body: some View {
        TabView {
            
            MyNotesView(companyVm: companyVm, noteVm: noteVm)
                .tabItem {
                    Label("Notes", systemImage: "newspaper.circle.fill")
                }
            
            TodoListView(todoVm: todoVm, companyVm: companyVm)
                .tabItem {
                    Label("Todo", systemImage: "list.bullet.circle.fill")
                }
            
            SettingsView(companyVm: companyVm, noteVm: noteVm, todoVm: todoVm)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.circle.fill")
                }
            
        }
        // アプリのアクセントカラーを変更
        .accentColor(Color("ThemeColor"))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
