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
    // 会社自体を消す関数
    func deleteCompany(indexSet: IndexSet) {
        companyList.remove(atOffsets: indexSet)
    }
    
    func addCompany(name: String) {
        let newCompany = CompanyModel(id: UUID(), name: name)
        companyList.append(newCompany)
    }
    
    func updateCompany(currentData: CompanyModel, updatingData: CompanyModel) {
        // firstIndex特定→代入でいけそう
        if let companyIndex = companyList.firstIndex(of: currentData) {
            companyList[companyIndex] = updatingData
        }
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
