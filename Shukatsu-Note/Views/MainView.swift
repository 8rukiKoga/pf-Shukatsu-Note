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
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Company.star, ascending: false),
            NSSortDescriptor(keyPath: \Company.createdAt, ascending: true)
        ],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    @FetchRequest(
        entity: Note.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.updatedAt, ascending: false)],
        predicate: nil
    ) private var notes: FetchedResults<Note>
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.doneAt, ascending: true),
            NSSortDescriptor(keyPath: \Task.date, ascending: true),
            NSSortDescriptor(keyPath: \Task.createdAt, ascending: false),
        ],
        predicate: nil
    ) private var tasks: FetchedResults<Task>
    // 初回起動かどうかを判断し、それを保存する変数
    @AppStorage("is_initial_launch") var isInitialLaunch: Bool = true
    // ウォークスルーを見たか判定
    @AppStorage("is_walkthrough_seen") var isWalkthroughSeen: Bool = false
    @State var showingWalkthrough: Bool = false
    // テーマカラーの呼び出し
    @AppStorage(wrappedValue: "ThemeColor1", "theme_color") var themeColor
    // tabviewの背景色の設定
    init() {
        // タブバーの色
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
        // DatePickerの時間を10分間隔に設定できるようにする
        UIDatePicker.appearance().minuteInterval = 10
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
        .accentColor(Color(themeColor))
        // iPadのときにもプッシュ遷移する
        .navigationViewStyle(StackNavigationViewStyle())
        // 初回起動時のデフォルトデータを設置
        .onAppear() {
            if isInitialLaunch {
                Company.createDefaultTask(in: context)
                Note.createDefaultNote(in: context)
                Note.createDefaultCompanyNote(in: context)
                Task.createDefaultTask(in: context)
                Task.createDefaultCompanyTask(in: context)
                isInitialLaunch = false
            }
            
            if !isWalkthroughSeen {
                showingWalkthrough = true
            }
            
            // バッジカウントを減らす
            UIApplication.shared.applicationIconBadgeNumber = 0
            // ロック画面にある通知を消す
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
        .fullScreenCover(isPresented: $showingWalkthrough) {
            WalkthroughView(showingWalkthrough: $showingWalkthrough)
                .onDisappear() {
                    // 通知リクエスト
                    NotificationManager.instance.requestAuth()
                    isWalkthroughSeen = true
                }
        }
        
    }
}
