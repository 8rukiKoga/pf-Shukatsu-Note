//
//  Shukatsu_NoteApp.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

@main
struct Shukatsu_NoteApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var customColor = CustomColor()
    @AppStorage(wrappedValue: 0, "appearanceMode") var appearanceMode
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .applyAppearenceSetting(AppearanceMode(rawValue: appearanceMode) ?? .followSystem)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(customColor)
        }
    }
}
