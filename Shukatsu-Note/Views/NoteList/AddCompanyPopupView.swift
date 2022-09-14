//
//  AddNewPopupView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/07.
//

import SwiftUI

struct AddCompanyPopupView: View {
    
    @Environment(\.managedObjectContext) private var context
    // ポップアップを表示するか
    @Binding var showingPopup: Bool
    
    @State private var showingAlert: Bool = false
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
                
                Text("\(newCompanyName.count) / 20")
                    .font(.caption2)
                    .foregroundColor(TextCountValidation.shared.isTextCountValid(text: newCompanyName, max: 20) ? .gray : .red)
                
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
                        if TextCountValidation.shared.isTextCountValid(text: newCompanyName, max: 20) {
                            Company.create(in: context, name: newCompanyName)
                            // ポップアップを閉じる
                            showingPopup = false
                            // バイブレーション
                            VibrationGenerator.vibGenerator.notificationOccurred(.success)
                        } else {
                            showingAlert = true
                        }
                    } label: {
                        Text("保存")
                            .fontWeight(.bold)
                            .frame(width: popupWidth / 2)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("企業名は1文字以上20文字以内で入力してください。"))
                    }
                }
                .padding(3)
            }
            .frame(width: popupWidth, height: 160)
        }
        .frame(width: popupWidth, height: 180, alignment: .center)
        
    }
}
