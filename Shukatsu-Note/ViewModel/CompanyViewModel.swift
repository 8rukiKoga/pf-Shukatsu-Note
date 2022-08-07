//
//  CompanyViewModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import Foundation

class CompanyViewModel: ObservableObject {
    @Published var companyList = [CompanyModel]()
}

var sampleCompanies = [
    CompanyModel(name: "A社"),
    CompanyModel(name: "B社"),
    CompanyModel(name: "C社")
]
