//
//  ContentView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var customColor: CustomColor
    
    // noteViewにてtabviewの背景上にテキストが浮かび上がらないようにするために背景色を塗る
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
    }
    
    var body: some View {
        TabView {
            
            MyNotesView()
                .tabItem {
                    Label("Notes", systemImage: "newspaper.circle.fill")
                }
            
            TodoListView()
                .tabItem {
                    Label("Todo", systemImage: "list.bullet.circle.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.circle.fill")
                }
            
        }
        // アプリのアクセントカラーを変更
        .accentColor(Color(customColor.themeColor))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
