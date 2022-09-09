//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct FolderRowView: View {
    
    var company: Company
    
    var body: some View {
        HStack {
            Image(systemName: "building.2")
                .foregroundColor(Color("ThemeColor"))
                .font(.system(size: 18))
            Text(company.name ?? "")
                .font(.system(size: 15))
            Spacer()
            Text(StarConvertor.shared.convertIntToStars(count: Int(company.star)))
                .foregroundColor(company.star != 0 ? Color(.systemYellow) : Color(.gray))
                .font(company.star != 0 ? .system(size: 10) : .system(size: 7))
                .fontWeight(company.star != 0 ? .bold : .none)
        }
        .frame(height: 25)
    }
}

//struct FolderRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderRowView()
//            .previewLayout(.sizeThatFits)
//    }
//}
