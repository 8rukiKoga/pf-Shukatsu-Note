//
//  AddNewPopupView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import SwiftUI

struct AddCompanyPopupView: View {
    
    @ObservedObject var companyVm: CompanyViewModel
    // ポップアップを表示するか
    @Binding var showingPopup: Bool
    // 登録数限界のアラートを表示するか
    @State var showingAlert: Bool = false
    // 登録する企業名
    @State var newCompanyName: String = ""
    // スマホのスクリーン幅
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
                
                Text("登録数: \(companyVm.companyList.count)/15")
                    .font(.caption2)
                    .foregroundColor(companyVm.companyList.count == 15 ? .red : .gray)
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
                        if companyVm.companyList.count <= 15 {
                            // 登録企業が15個以下の場合
                            companyVm.addCompany(name: newCompanyName)
                            showingPopup = false
                        } else {
                            // 登録企業が15個(以上)の場合
                            showingAlert = true
                        }
                    } label: {
                        Text("保存")
                            .fontWeight(.bold)
                            .frame(width: screenWidth / 2)
                    }
                }
                .padding(3)
                
            }
            .frame(width: screenWidth, height: 160)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("企業の登録は15個までです🙇🏻‍♂️"))
            }
        }
        .frame(width: screenWidth, height: 180, alignment: .center)
    }
}

struct AddCompanyPopupView_Previews: PreviewProvider {
    static var previews: some View {
        
        let testCompany = CompanyViewModel()
        testCompany.companyList = sampleCompanies
        
        return AddCompanyPopupView(companyVm: testCompany, showingPopup: .constant(false), showingAlert: true)
    }
}
