//
//  AddTodoView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.star, ascending: false)],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    // 新規タスク追加シートの表示・非表示
    @Binding var showingSheet: Bool
    
    @State private var showingAlert: Bool = false
    
    @State private var taskName: String = ""
    // 日付を指定しているか判断
    @State private var dateIsSet: Bool = true
    @State private var date = Date()
    // 企業を指定しているか判断
    @State private var companyIsSet: Bool = false
    @State private var company: Company?
    // スクリーン幅を取得
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            Color(CustomColor.customBrown)
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                HStack {
                    Text("Add Todo")
                        .font(.title).bold()
                        .padding(.bottom, -60)
                    
                    Spacer()
                    
                    Button {
                        showingSheet = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .font(.largeTitle)
                    }
                    .padding(6)
                }
                .padding()
                
                ZStack {
                    Color(.systemGray4)
                        .opacity(0.7)
                    
                    VStack(alignment: .center) {
                        HStack {
                            Text("タスク名").font(.footnote)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        TextField("タスク名を入力", text: $taskName)
                            .padding(10)
                            .frame(width: screenWidth - 36)
                            .background(Color(.systemGray5))
                            .cornerRadius(7)
                        
                        Text("\(taskName.count) / 25")
                            .font(.caption2)
                            .foregroundColor(TextCountValidation.shared.isTextCountValid(text: taskName, max: 25) ? .gray : .red)
                            .padding(.bottom)
                        
                        HStack {
                            Text("日時").font(.footnote)
                            
                            Toggle("", isOn: $dateIsSet)
                                .animation(.easeInOut, value: dateIsSet)
                            
                            if dateIsSet {
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .cornerRadius(7)
                                    .transition(.slide)
                            } else {
                                Text("日時未指定")
                                    .foregroundColor(.gray)
                                    .transition(.slide)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("企業")
                                .font(.footnote)
                                .padding(.trailing, 3)
                            
                            ZStack {
                                Color(.systemGray5)
                                    .cornerRadius(7)
                                
                                Picker("企業", selection: $company) {
                                    Text("未選択")
                                    ForEach(companies) { company in
                                        // もともとopt型で宣言しているので、ピッカーのtagの方でもopt型に変換しないと適用されない(xcode上ではエラーにならないけど)
                                        Text(company.name ?? "").tag(company as Company?)
                                    }
                                }
                                .pickerStyle(.menu)
                                .transition(.slide)
                            }
                            .frame(height: 40)
                            
                        }
                        .padding(.horizontal, 18)
                    }
                    .frame(height: 270)
                }
                .frame(width: screenWidth-10, height: 270)
                .cornerRadius(7)
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        if TextCountValidation.shared.isTextCountValid(text: taskName, max: 25) {
                            // 企業を選択しているか判断
                            companyIsSet = company != nil
                            // todoリストに追加
                            if companyIsSet && dateIsSet {
                                Task.create(in: context, name: taskName, date: date, companyId: company!.id, companyName: company!.name)
                            }
                            
                            if companyIsSet && !dateIsSet{
                                Task.create(in: context, name: taskName, date: nil, companyId: company!.id, companyName: company!.name)
                            }
                            
                            if !companyIsSet && dateIsSet {
                                Task.create(in: context, name: taskName, date: date, companyId: nil, companyName: nil)
                            }
                            
                            if !companyIsSet && !dateIsSet {
                                Task.create(in: context, name: taskName, date: nil, companyId: nil, companyName: nil)
                            }
                            
                            // モーダルシートを閉じる
                            showingSheet = false
                            // バイブレーション
                            VibrationGenerator.vibGenerator.notificationOccurred(.success)
                        } else {
                            showingAlert = true
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "plus")
                                .modifier(FloatingBtnMod())
                                .padding(.bottom, -30)
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("タスク名は1文字以上25文字以内で入力してください。"))
                    }
                }
            }
        }
        
    }
}
