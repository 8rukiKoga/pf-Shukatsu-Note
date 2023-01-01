//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct FolderRowView: View, StarConvertor {
    
    var companyImage: Data?
    var name: String
    var star: Int
    var note: Int
    var task: Int
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    if let companyImage = companyImage {
                        Image(uiImage: UIImage(data: companyImage)!)
                            .resizable()
                            .modifier(CompanyImageMod(size: 45))
                    } else {
                        // ユーザーがまだ画像を設定していない場合
                        Image(uiImage: UIImage(named: "default-companyImage")!)
                            .resizable()
                            .modifier(CompanyImageMod(size: 45))
                    }
                    
                    VStack(alignment: .center) {
                        Text(name)
                            .font(.headline).bold()
                    }
                    .padding(8)
                    // 文字が...で省略されないようにする
                    .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                
                Divider()
                
                HStack {
                    Spacer()
                    HStack {
                        Text(convertIntToStars(count: Int(star)))
                            .foregroundColor(star != 0 ? Color(.systemYellow) : Color(.gray))
                            .font(star != 0 ? .system(size: 15) : .system(size: 10))
                            .fontWeight(star != 0 ? .bold : .none)
                            .tracking(2)
                    }
                    Spacer()
                    HStack {
                        HStack {
                            Image(systemName: "book.circle")
                            Text("\(note)")
                        }
                        Divider()
                        HStack {
                            Image(systemName: "checkmark.circle")
                            Text("\(task)")
                        }
                    }
                    .font(.footnote)
                }
                .foregroundColor(.gray)
                .padding(.horizontal, 7)
            }
            .padding(.horizontal)
            .padding(.vertical, 13)
        }
        .cornerRadius(10)
//        .shadow(color: Color(.darkGray).opacity(0.6), radius: 4, x: 1, y: 1)
    }
}
