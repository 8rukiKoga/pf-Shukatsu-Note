//
//  ContentView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.star, ascending: false)],
        predicate: nil
    ) var companies: FetchedResults<Company>
    
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        predicate: nil
    ) var notes: FetchedResults<Note>
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)],
        predicate: nil
    ) var tasks: FetchedResults<Task>
    @AppStorage("is_initial_launch") var isInitialLaunch: Bool = true
    
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
        // デフォルトデータを設置
        .onAppear() {
            if isInitialLaunch {
                Company.createDefaultTask(in: context)
                Note.createDefaultNote(in: context)
                Note.createDefaultCompanyNote(in: context)
                Task.createDefaultTask(in: context)
                Task.createDefaultCompanyTask(in: context)
            }
            isInitialLaunch = false
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
