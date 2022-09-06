//
//  MainListRowView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

final class FolderRowViewModel {
    
    private var company: Company
    
    var name: String {
        company.name ?? ""
    }
    
    var star: Star {
        Star(rawValue: company.star) ?? .zero
    }
    
    init(company: Company) {
        self.company = company
    }
    
}

struct FolderRowView: View {
    
    var viewModel: FolderRowViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "building.2")
                .foregroundColor(Color("ThemeColor"))
                .font(.system(size: 18))
            Text(viewModel.name)
                .font(.system(size: 15))
            Spacer()
            Text(viewModel.star.string)
                .foregroundColor(viewModel.star.isZero ?  Color(.gray) : Color(.systemYellow))
                .font(viewModel.star.isZero ?  .system(size: 7) : .system(size: 10))
                .fontWeight(viewModel.star.isZero ? .none : .bold )
        }
        .frame(height: 25)
    }
}

//struct FolderRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderRowView(company: .init(name: "JR九州"))
//            .previewLayout(.sizeThatFits)
//    }
//}
