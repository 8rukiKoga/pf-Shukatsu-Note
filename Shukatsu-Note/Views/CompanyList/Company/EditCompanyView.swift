//
//  EditCompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/10.
//

import SwiftUI

struct EditCompanyView: View {
    // シートの表示・非表示
    // 今のままだと、編集画面を閉じたときにMainListViewまでもどってしまう。修正するにはどうしたらいい？
    @Binding var showingSheet: Bool
    
    @ObservedObject var companyVm: CompanyViewModel
    var company: CompanyModel
    
    @State var name: String
    @State var stars: Int
    @State var category: String
    @State var location: String
    @State var url: String
    
    // https://1-notes.com/datas-prefectures/
    let prefectures = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"];
    
    var body: some View {
        ZStack {
            Form {
                Section("企業名") {
                    TextField("例) さんぷる株式会社", text: $name)
                }
                Section("志望度") {
                    Picker("", selection: $stars) {
                        Text("★☆☆☆☆").tag(1)
                        Text("★★☆☆☆").tag(2)
                        Text("★★★☆☆").tag(3)
                        Text("★★★★☆").tag(4)
                        Text("★★★★★").tag(5)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                Section("業界") {
                    TextField("例) サービス", text: $category)
                }
                Section("企業所在地") {
                    Picker("都道府県を選択", selection: $location) {
                        ForEach(prefectures, id: \.self) { item in
                            Text(item).tag(item)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                Section("関連URL") {
                    TextField("例) https://sample.co.jp", text: $url)
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        companyVm.updateCompany(currentData: self.company, updatingData: CompanyModel(name: self.name, stars: self.stars, category: self.category, location: self.location, url: self.url))
                        showingSheet = false
                    } label: {
                        ZStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 55, height: 55)
                                // うしろの青丸の設定
                                .background(Color.blue)
                                .cornerRadius(30.0)
                                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                                // Buttonの端からの距離
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 25))
                        }
                    }
                    
                }
            }
            
        }
    }
}

struct EditCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        EditCompanyView(showingSheet: .constant(true), companyVm: CompanyViewModel(), company: CompanyModel(name: "A社"), name: "company.name", stars: 3, category: "company.category", location: "company.location", url: "company.location")
    }
}
