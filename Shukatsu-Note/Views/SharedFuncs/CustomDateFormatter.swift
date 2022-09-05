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
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy.MM.dd"
    }
    
    func convertDateToString(from date: Date) -> String {
        return formatter.string(from: date)
    }
    
}
