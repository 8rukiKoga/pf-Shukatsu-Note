//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct MainListRowView: View {
    
    var company: Company
    
    var body: some View {
        HStack {
            Color.blue
                .frame(width: 50, height: 50)
            
            Spacer()
            
            Text(company.name)
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
