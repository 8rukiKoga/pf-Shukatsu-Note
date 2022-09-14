//
//  AddNewPopupView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import SwiftUI

struct AddCompanyPopupView: View {
    @Environment(\.managedObjectContext) var context
    // ポップアップを表示するか
    @Binding var showingPopup: Bool
    // 登録する企業名
    @State private var newCompanyName: String = ""
    // スマホのスクリーン幅
    private let popupWidth: CGFloat = UIScreen.main.bounds.width - 60
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color(.systemGray5))
                .frame(width: popupWidth, height: 180, alignment: .center)
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
                    .frame(width: popupWidth / 1.3, height: 25)
                    .background(Color(.systemBackground))
                    .cornerRadius(7)
                Spacer()
                
                Divider()
                
                HStack {
                    Button {
                        showingPopup = false
                    } label: {
                        Text("キャンセル")
                            .frame(width: popupWidth / 2)
                    }
                    
                    Button {
                        // 登録企業が15個以下の場合
                        Company.create(in: context, name: newCompanyName)
                        showingPopup = false
                        VibrationGenerator.vibGenerator.notificationOccurred(.success)
                    } label: {
                        Text("保存")
                            .fontWeight(.bold)
                            .frame(width: popupWidth / 2)
                    }
                }
                .padding(3)
                
            }
            .frame(width: popupWidth, height: 160)
        }
        .frame(width: popupWidth, height: 180, alignment: .center)
    }
}

//struct AddCompanyPopupView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let testCompany = CompanyViewModel()
//        testCompany.companyList = sampleCompanies
//
//        return AddCompanyPopupView(companyVm: testCompany, showingPopup: .constant(false), showingAlert: true)
//    }
//}
