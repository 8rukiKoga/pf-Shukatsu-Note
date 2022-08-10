//
//  Shukatsu_NoteApp.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

@main
struct Shukatsu_NoteApp: App {
    
    @StateObject private var companyVm = CompanyViewModel()
    @StateObject private var noteVm = NoteViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
