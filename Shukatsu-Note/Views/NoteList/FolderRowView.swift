//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct FolderRowView: View {
    
    var company: CompanyModel
    
    var body: some View {
        HStack {
            Image(systemName: "building.2")
                .foregroundColor(Color("ThemeColor"))
                .font(.system(size: 18))
            Text(company.name)
                .font(.system(size: 15))
            Spacer()
            Text("\(StarConvertor.shared.convertIntToStars(count: company.stars))")
                .foregroundColor(company.stars != 0 ? Color(.systemYellow) : Color(.gray))
                .font(company.stars != 0 ? .system(size: 10) : .system(size: 7))
                .fontWeight(company.stars != 0 ? .bold : .none)
        }
        .frame(height: 25)
    }
}

struct FolderRowView_Previews: PreviewProvider {
    static var previews: some View {
        FolderRowView(company: .init(name: "JR九州"))
            .previewLayout(.sizeThatFits)
    }
}
