//
//  EditCompanyView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/10.
//

import SwiftUI

struct EditCompanyView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    // デバイスの言語取得
    private let language = NSLocale.current.languageCode
    
    // 編集シートの表示・非表示
    @Binding var showingSheet: Bool
    // 写真ピッカーの表示・非表示
    @State var showingPhotoPicker: Bool = false
    
    var company: Company
    
    @State var companyImage = UIImage(named: "default-companyImage")!
    @State var name: String
    @State var star: Int
    @State var category: String
    // ピッカーで選択するのは国内か海外か判断
    @State var areaInputMethod: Int = 1
    @State var location: String
    @State var url: String
    
    // 文字数バリデーションのアラートの表示・非表示
    @State private var showingAlert: Bool = false
    private let validTextCount: Int = 50
    
    // https://1-notes.com/datas-prefectures/
    private let domesticRegions = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県", "海外"]
    // https://css-tricks.com/snippets/javascript/array-of-country-names/
    private let foreignRegions = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]
    
    var body: some View {
        
        ZStack {
            Form {
                
                Section(NSLocalizedString("企業アイコン", comment: "")) {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Image(uiImage: companyImage)
                                .resizable()
                                .modifier(CompanyImageMod())
                                .onTapGesture {
                                    showingPhotoPicker = true
                                }
                            
                            Spacer()
                        }
                        
                        Text(NSLocalizedString("画像をタップして変更", comment: ""))
                            .font(.caption2)
                    }
                    .padding(5)
                }
                
                Section(NSLocalizedString("企業名", comment: "")) {
                    TextField(NSLocalizedString("例) さんぷる株式会社", comment: ""), text: $name)
                        .foregroundColor(TextCountValidation.shared.isTextCountValid(text: name, max: validTextCount) ? Color(.label) : .red)
                        .listRowBackground(name.count > 0 ? Color("DefaultCellColor") : Color.red.opacity(0.2))
                }
                Section(NSLocalizedString("志望度", comment: "")) {
                    Picker("", selection: $star) {
                        Text("★☆☆☆☆").tag(1)
                        Text("★★☆☆☆").tag(2)
                        Text("★★★☆☆").tag(3)
                        Text("★★★★☆").tag(4)
                        Text("★★★★★").tag(5)
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                Section(NSLocalizedString("業界", comment: "")) {
                    TextField(NSLocalizedString("例) 旅行", comment: ""), text: $category)
                        .foregroundColor(TextCountValidation.shared.isTextCountValid(text: category, max: validTextCount) ? Color(.label) : .red)
                }
                Section(NSLocalizedString("所在地", comment: "")) {
                    if language == "ja" { // 日本語
                        Picker("", selection: $areaInputMethod) {
                            Text("国内").tag(1)
                            Text("国外").tag(2)
                            Text("入力").tag(3)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if areaInputMethod == 3 {
                            ZStack {
                                TextField("企業所在地を入力してください", text: $location)
                                    .foregroundColor(TextCountValidation.shared.isTextCountValid(text: location, max: validTextCount) ? Color(.label) : .red)
                                    .padding()
                                    .background(Color(.white).opacity(0.2).cornerRadius(12))
                                    .padding(.vertical, 3)
                            }
                        } else {
                            Picker("", selection: $location) {
                                
                                Text(NSLocalizedString("未選択", comment: "")).tag("未選択")
                                if areaInputMethod == 1 {
                                    ForEach(domesticRegions, id: \.self) { item in
                                        Text(item).tag(item)
                                    }
                                } else if areaInputMethod == 2 {
                                    ForEach(foreignRegions, id: \.self) { item in
                                        Text(item).tag(item)
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.vertical, 3)
                        }
                    } else {
                        Picker("", selection: $areaInputMethod) {
                            Text("Select").tag(1)
                            Text("Input").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if areaInputMethod == 2 {
                            ZStack {
                                TextField("Input location", text: $location)
                                    .foregroundColor(TextCountValidation.shared.isTextCountValid(text: location, max: validTextCount) ? Color(.label) : .red)
                                    .padding()
                                    .background(Color(.label).opacity(0.1).cornerRadius(12))
                                    .padding(.vertical, 3)
                            }
                        } else {
                            Picker("", selection: $location) {
                                Text(NSLocalizedString("Not set", comment: "")).tag("Not set")
                                
                                if areaInputMethod == 1 {
                                    ForEach(foreignRegions, id: \.self) { item in
                                        Text(item).tag(item)
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding(.vertical, 3)
                        }
                    }
                }
                Section(NSLocalizedString("関連URL", comment: "")) {
                    TextField("https://sample.co.jp", text: $url)
                        .foregroundColor(VerifyUrl.shared.verifyUrl(urlString: url) ? .green : .red)
                }
            }
            
            // 完了ボタン
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        if name.count > 0 && TextCountValidation.shared.isTextCountValid(text: name, max: validTextCount) && TextCountValidation.shared.isTextCountValid(text: category, max: validTextCount) && TextCountValidation.shared.isTextCountValid(text: location, max: validTextCount) && TextCountValidation.shared.isTextCountValid(text: url, max: validTextCount) {
                            // UIImageをData型に変換
                            guard let data = companyImage.jpegData(compressionQuality: 0.1) else { return }
                            print(data)
                            Company.updateInfo(in: context, currentCompany: company, image: data, name: name, star: star, category: category, location: location, url: url)
                            // 編集シートを閉じる
                            showingSheet = false
                            // バイブレーション
                            VibrationGenerator.vibGenerator.notificationOccurred(.success)
                        } else {
                            showingAlert = true
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "checkmark.circle.fill")
                                .modifier(FloatingBtnMod())
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(NSLocalizedString("テキストは100文字以下である必要があります。", comment: "")))
                    }
                }
            }
            
        }
        // 写真ピッカー
        .sheet(isPresented: $showingPhotoPicker) {
            PhotoPicker(companyImage:$companyImage)
        }
        
    }
}
