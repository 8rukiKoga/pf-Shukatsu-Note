//
//  AddTodoView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct AddTodoView: View {
    
    @ObservedObject var todoVm: TodoViewModel
    @ObservedObject var companyVm: CompanyViewModel
    
    @Binding var showSheet: Bool
    
    @State var taskName: String = ""
    @State var date = Date()
    // 日付を指定しているか判断
    @State var dateIsSet: Bool = true
    @State var company: CompanyModel = CompanyModel(name: "未選択")
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
            Color(.systemBrown)
                .ignoresSafeArea()
            VStack(spacing: 28) {
                HStack {
                    Text("Add Todo")
                        .font(.title).bold()
                        .padding(.bottom, -60)
                    Spacer()
                    Button {
                        showSheet = false
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
                                    Text("未選択").tag(CompanyModel(name: "未選択"))
                                    ForEach(companyVm.companyList) { company in
                                        Text(company.name).tag(company)
                                    }
                                }
                                .pickerStyle(.menu)
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
                        // todoリストに追加
                        if let companyID = $company.id {
                            todoVm.addTodo(todo: TodoModel(companyID: companyID, companyName: company.name, name: self.taskName, date: self.date, dateIsSet: self.dateIsSet, done: false))
                            
                        } else {
                            todoVm.addTodo(todo: TodoModel(companyID: nil, companyName: nil, name: self.taskName, date: self.date, dateIsSet: self.dateIsSet, done: false))
                        }
                        // モーダルシートを閉じる
                        showSheet = false
                    } label: {
                        ZStack {
                            Image(systemName: "plus")
                                .modifier(FloatingBtnMod())
                                .padding(.bottom, -30)
                        }
                    }
                }
            }
        }
    }
}


struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(todoVm: TodoViewModel(), companyVm: CompanyViewModel(), showSheet: .constant(true))
    }
}
