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
    @State var company: CompanyModel?
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack {
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
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                    }
                    .padding(6)
                }
                .padding()
                
                TextField("タスク名を入力", text: $taskName)
                    .padding(10)
                    .frame(width: screenWidth - 36)
                    .background(Color(.systemGray6))
                    .cornerRadius(7)
                
                DatePicker("日時", selection: $date)
                    .padding(.horizontal)
                    .cornerRadius(7)
                
                HStack {
                    Text("企業")
                    Spacer()
                    ZStack {
                        Color(.systemGray6)
                            .cornerRadius(7)
                        Picker("企業", selection: $company) {
                            ForEach(companyVm.companyList) { company in
                                Text(company.name).tag(company.id)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .frame(height: 40)
                }
                .padding(.horizontal, 18)
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        todoVm.addTodo(name: taskName)
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
            .onAppear() {
                UIPickerView.appearance().tintColor = UIColor(Color("ThemeColor"))
            }
        }
    }
}


struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(todoVm: TodoViewModel(), companyVm: CompanyViewModel(), showSheet: .constant(true))
    }
}
