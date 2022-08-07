//
//  AddNewPopupView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import SwiftUI

struct AddNewCompanyPopupView: View {
    
    @ObservedObject var companyVm: CompanyViewModel
    @Binding var showingPopup: Bool
    
    @State var newCompanyName: String = ""
    
    private let screenWidth: CGFloat = 290
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray5))
                    .frame(width: screenWidth, height: 180, alignment: .center)
                VStack {
                    Spacer()
                    Text("Add Company")
                        .font(.headline)
                    Text("企業名を入力してください")
                        .font(.subheadline)
                    TextField("例) さんぷる株式会社", text: $newCompanyName)
                        .frame(width: 230, height: 25)
                        .background(Color(.white))
                        .padding()
                        .cornerRadius(7)
                    Spacer()
                    
                    Divider()
                    
                    HStack {
                        Button {
                            showingPopup = false
                        } label: {
                            Text("キャンセル")
                        }
                        .frame(width: 150)
                        
                        Spacer()
                        
                        Button {
                            companyVm.companyList.append(CompanyModel(name: newCompanyName))
                            showingPopup = false
                        } label: {
                            Text("保存")
                                .fontWeight(.bold)
                        }
                        .frame(width: 150)
                    }
                    .padding(3)
                    
                }
                .frame(width: screenWidth, height: 160)
            }
            .frame(width: screenWidth, height: 180, alignment: .center)
    }
}

struct AddNewCompanyPopupView_Previews: PreviewProvider {
    static var previews: some View {
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        return AddNewCompanyPopupView(companyVm: testCompany, showingPopup: .constant(false))
    }
}
