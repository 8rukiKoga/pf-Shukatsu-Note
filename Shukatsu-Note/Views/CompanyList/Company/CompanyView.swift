//
//  CompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct CompanyView: View {
    
    var company: Company
    
    var body: some View {
        Text(company.name)
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView(company: .init(name: "A社"))
    }
}
