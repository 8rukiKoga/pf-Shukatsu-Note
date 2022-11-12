//
//  NotificationManager.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/12.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() // singleton
    
    // 通知の承認をリクエスト
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error {
                print("ERROR: \(error)")
            }
        }
    }
    
    // 通知作成
    func scheduleNotification(id: String, date: Date, taskName: String) {
        // 通知の内容
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("本日のタスク", comment: "")
        content.subtitle = taskName
        content.sound = .default
        content.badge = 1
        
        // 通知の発生条件
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.hour = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 通知を登録
        let request = UNNotificationRequest(identifier: id,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    // 登録された通知を削除
    func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
