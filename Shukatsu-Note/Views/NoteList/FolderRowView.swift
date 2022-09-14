//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct FolderRowView: View {
    
    @EnvironmentObject private var customColor: CustomColor
    @EnvironmentObject private var companyIcon: CompanyIcon
    
    var companyImage: Data?
    var name: String
    var star: Int
    
    var body: some View {
        HStack {
            if companyIcon.isCompanyImage {
                if let companyImage = companyImage {
                    Image(uiImage: UIImage(data: companyImage)!)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                } else {
                    // ユーザーがまだ画像を設定していない場合
                    Image(uiImage: UIImage(named: "default-companyImage2")!)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                }
            } else {
                Image(systemName: "building.2")
                    .foregroundColor(Color(customColor.themeColor))
                    .font(.system(size: 18))
            }
            
            Text(name)
                .font(.system(size: 15))
            
            Spacer()
            
            Text(StarConvertor.shared.convertIntToStars(count: star))
                .foregroundColor(star != 0 ? Color(.systemYellow) : Color(.gray))
                .font(star != 0 ? .system(size: 10) : .system(size: 7))
                .fontWeight(star != 0 ? .bold : .none)
        }
        .frame(height: 25)
    }
}
