//
//  CompanyViewModel.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import Foundation

// CRUD actions

class CompanyViewModel: ObservableObject {
    
    @Published var companyList: [CompanyModel] = [] {
        didSet {
            saveCompanies()
        }
    }
    
    init() {
        getCompanies()
    }
    
    let companyListKey = "CompanyListKey"
    
    // データを読み込む
    func getCompanies() {
        guard
            let data = UserDefaults.standard.data(forKey: companyListKey),
            let savedCompanies = try? JSONDecoder().decode([CompanyModel].self, from: data)
        else { return }
        
        companyList = savedCompanies
    }
    
    func deleteCompany(indexSet: IndexSet) {
        companyList.remove(atOffsets: indexSet)
    }
    
    func addCompany(name: String) {
        let newCompany = CompanyModel(name: name)
        companyList.append(newCompany)
    }
    
    func saveCompanies() {
        if let encodedData = try? JSONEncoder().encode(companyList) {
            UserDefaults.standard.set(encodedData, forKey: companyListKey)
        }
    }
}

var sampleCompanies = [
    CompanyModel(name: "A社"),
    CompanyModel(name: "B社"),
    CompanyModel(name: "C社")
]
