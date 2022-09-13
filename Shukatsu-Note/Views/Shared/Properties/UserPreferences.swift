//
//  UserPreferences.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/09/13.
//

import Foundation
import SwiftUI

class CompanyIcon: ObservableObject {
    @AppStorage("company_icon") var isCompanyImage: Bool = false
}
