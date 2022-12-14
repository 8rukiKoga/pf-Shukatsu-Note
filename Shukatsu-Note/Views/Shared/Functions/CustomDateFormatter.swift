//
//  CustomDateFormatter.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/05.
//

import Foundation

final class CustomDateFormatter {
    
    static let shared = CustomDateFormatter()
    private let formatter: DateFormatter
    
    private init(formatter: DateFormatter = .init()) {
        self.formatter = formatter
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .short
        formatter.timeStyle = .short
    }
    
    func convertDateToString(from date: Date, isAllDay: Bool) -> String {
        if isAllDay {
            formatter.dateFormat = "yyyy.MM.dd"
        } else {
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
        }
        return formatter.string(from: date)
    }
    
    func convertTimeToString(from time: Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }
    
}
