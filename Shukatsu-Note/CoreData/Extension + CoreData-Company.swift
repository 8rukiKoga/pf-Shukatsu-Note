//
//  Extension + CoreData-Company.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/06.
//

import CoreData
import SwiftUI

extension Company {
        
    static func create(in context: NSManagedObjectContext, name: String) {
        let newData = Company(context: context)
        newData.id = UUID().uuidString
        newData.name = name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
//    static func update(currentCompany: Company,
//                imageData: Data,
//                name: String,
//                star: Star,
//                industry: String,
//                location: Location,
//                url: String,
//                memo: String) {
//
//        currentCompany.imageData = imageData
//        currentCompany.name = name
//        currentCompany.star = star.rawValue
//        currentCompany.industry = industry
//        currentCompany.location = location.rawValue
//        currentCompany.url = url
//        currentCompany.memo = memo
//
//    }
    
}


enum Star: Int16 {
    case zero
    case one
    case two
    case three
    case four
    case five
    
    var string: String {
        switch self {
        case .zero:
            return "未設定"
        case .one:
            return "★☆☆☆☆"
        case .two:
            return "★★☆☆☆"
        case .three:
            return "★★★☆☆"
        case .four:
            return "★★★★☆"
        case .five:
            return "★★★★★"
        }
    }
    
    var isZero: Bool {
        self == .zero
    }
    
    var foregroundColor: Color {
        self == .zero ? .gray : .yellow
    }
    
    var font: Font {
        self == .zero ? .system(size: 7) : .system(size: 10)
    }
    
    var fontWeight: Font.Weight {
        self == .zero ? .regular : .bold
    }
    
}


enum Location: Int16 {
    case none
    case tokyo
    case kyoto
    
    var string: String {
        switch self {
        case .none:
            return ""
        case .tokyo:
            return "東京"
        case .kyoto:
            return "京都"
        }
    }
}
