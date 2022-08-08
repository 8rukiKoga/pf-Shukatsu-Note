//
//  ContentView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MainView: View {
    @StateObject private var companyVm = CompanyViewModel()
    @StateObject private var noteVm = NoteViewModel()
    
    var body: some View {
        TabView {
            
            MyListView(companyVm: companyVm, noteVm: noteVm)
                .tabItem {
                    Label("MyList", systemImage: "newspaper.circle.fill")
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
