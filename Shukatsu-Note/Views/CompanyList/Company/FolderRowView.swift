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
            Image(systemName: "folder")
                .foregroundColor(Color(.systemBrown))
                .font(.system(size: 20))
            Text(company.name)
                .font(.system(size: 15))
            Spacer()
            // ＊ 志望度 後々動的に変更
            Text("★★★★☆")
                .foregroundColor(Color(.systemYellow))
                .font(.system(size: 10))
                .fontWeight(.bold)
        }
    }
}

struct FolderRowView_Previews: PreviewProvider {
    static var previews: some View {
        FolderRowView(company: .init(name: "JR九州"))
            .previewLayout(.sizeThatFits)
    }
}
