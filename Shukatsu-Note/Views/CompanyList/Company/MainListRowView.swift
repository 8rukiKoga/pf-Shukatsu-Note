//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MainListRowView: View {
    
    var company: CompanyModel
    
    var body: some View {
        HStack {
            Image(systemName: "folder")
                .foregroundColor(Color(.systemBrown))
                .font(.system(size: 20))
            Text(company.name)
                .padding(.leading)
            
            
            Spacer()
        }
    }
}

struct MainListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MainListRowView(company: .init(name: "JR九州"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
