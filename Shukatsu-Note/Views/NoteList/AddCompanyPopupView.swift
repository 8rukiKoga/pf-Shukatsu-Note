//
//  AddNewPopupView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import SwiftUI

struct AddCompanyPopupView: View {
    @Environment(\.managedObjectContext) var context
    
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
                    Spacer()
                    TextField("例) さんぷる株式会社", text: $newCompanyName)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                        .frame(width: 230, height: 25)
                        .background(Color(.systemBackground))
                        .cornerRadius(7)
                    Spacer()
                    
                    Divider()
                    
                    HStack {
                        Button {
                            showingPopup = false
                        } label: {
                            Text("キャンセル")
                                .frame(width: screenWidth / 2)
                        }
                        
                        Button {
//                            companyVm.addCompany(name: newCompanyName)
                            Company.create(in: context, name: newCompanyName)
                            showingPopup = false
                        } label: {
                            Text("保存")
                                .fontWeight(.bold)
                                .frame(width: screenWidth / 2)
                        }
                    }
                    .padding(3)
                    
                }
                .frame(width: screenWidth, height: 160)
            }
            .frame(width: screenWidth, height: 180, alignment: .center)
    }
}

struct AddCompanyPopupView_Previews: PreviewProvider {
    static var previews: some View {
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        return AddCompanyPopupView(companyVm: testCompany, showingPopup: .constant(false))
    }
}
