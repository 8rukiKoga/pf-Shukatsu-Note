//
//  AddTodoView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct AddTodoView: View, TextCountValidation {
    
    @Environment(\.managedObjectContext) private var context
    @AppStorage(wrappedValue: "ThemeColor1", "theme_color") var themeColor
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Company.star, ascending: false),
            NSSortDescriptor(keyPath: \Company.createdAt, ascending: true)
        ],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    // 新規タスク追加シートの表示・非表示
    @Binding var showingSheet: Bool
    
    @FocusState private var inputFocus: Bool
    
    @State private var showingAlert: Bool = false
    
    @State private var taskName: String = ""
    // 日付を指定しているか判断
    @State private var dateIsSet: Bool = true
    @State private var date = Date()
    @State private var endDateIsSet: Bool = false
    @State private var endDate = Date() + (60 * 30)
    // リマインダーを指定しているか判断
    @State private var reminderIsSet: Bool = false
    @State private var remindDate: Date = Date()
    // 企業を指定しているか判断
    @State private var companyIsSet: Bool = false
    @State private var companyId: String?
    
    var body: some View {
        
        ZStack {
            Color(.systemGray4)
                .ignoresSafeArea()
            
            ScrollView() {
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
                .padding(.bottom, 10)
                
                ZStack {
                    Color(themeColor)
                        .opacity(0.5)
                    
                    VStack(alignment: .center, spacing: 10) {
                        VStack {
                            HStack {
                                Text(NSLocalizedString("タスク名", comment: "")).font(.footnote)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            TextField(NSLocalizedString("タスク名を入力", comment: ""), text: $taskName)
                                .focused($inputFocus)
                                .padding(10)
                                .background(Color(.systemGray5))
                                .cornerRadius(7)
                            
                            Text("\(taskName.count) / \(ValidationCounts.comAndTaskText.rawValue)")
                                .font(.caption2)
                                .foregroundColor(isTextCountValid(text: taskName, type: .comAndTaskText) ? .gray : .red)
                                .padding(.bottom)
                        }
                        
                        VStack {
                            HStack {
                                Text(NSLocalizedString("日付", comment: "")).font(.footnote)
                                Toggle("", isOn: $dateIsSet)
                                    .animation(.easeInOut, value: dateIsSet)
                                
                                if !dateIsSet {
                                    Text(NSLocalizedString("日付未指定", comment: ""))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                            
                            if dateIsSet {
                                HStack {
                                    Text(NSLocalizedString("終了日時も設定する", comment: "")).font(.footnote)
                                    Toggle("", isOn: $endDateIsSet)
                                        .animation(.easeInOut, value: endDateIsSet)
                                }
                                .padding(.horizontal)
                                
                                VStack {
                                    if endDateIsSet {
                                        HStack {
                                            Text("Start").font(.caption2)
                                            DatePicker("", selection: $date)
                                        }
                                        
                                        HStack {
                                            Text("End").font(.caption2)
                                            DatePicker("", selection: $endDate, in: date...)
                                        }
                                    } else {
                                        HStack {
                                            Text("日付").font(.caption2)
                                            DatePicker("", selection: $date, displayedComponents: .date)
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack {
                            if dateIsSet {
                                VStack {
                                    HStack {
                                        Text(NSLocalizedString("リマインダー", comment: "")).font(.footnote)
                                        
                                        Toggle("", isOn: $reminderIsSet)
                                            .animation(.easeInOut, value: reminderIsSet)
                                        if reminderIsSet {
                                            DatePicker("", selection: $remindDate, displayedComponents: .hourAndMinute)
                                                .transition(.slide)
                                        } else {
                                            Text(NSLocalizedString("未設定", comment: ""))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    if reminderIsSet {
                                        HStack {
                                            Spacer()
                                            Text(NSLocalizedString("タスク当日の設定した時刻に通知が届きます。", comment: ""))
                                                .font(.caption)
                                                .foregroundColor(Color(.systemGray6))
                                                .transition(.opacity)
                                        }
                                        .padding(.bottom, 5)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text(NSLocalizedString("企業", comment: ""))
                                    .font(.footnote)
                                    .padding(.trailing, 3)
                                
                                Spacer()
                                
                                ZStack {
                                    Color(.systemGray5)
                                    
                                    Picker("", selection: $companyId) {
                                        Text(NSLocalizedString("未選択", comment: "")).tag("")
                                        ForEach(companies) { company in
                                            Text(company.name ?? "").tag(company.id)
                                        }
                                    }
                                    .padding(.vertical, 2)
                                    .padding(.horizontal)
                                }
                                .frame(maxWidth: 230)
                                .cornerRadius(7)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                .cornerRadius(7)
                .padding()
                
                Spacer()
            }
            .gesture(
                // 下にドラッグした時に、キーボードを閉じる
                DragGesture().onChanged({ value in
                    if value.translation.height > 0 {
                        inputFocus = false
                    }
                })
            )
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        if taskName.count > 0 && isTextCountValid(text: taskName, type: .comAndTaskText) {
                            if !dateIsSet {
                                reminderIsSet = false
                                endDateIsSet = false
                            }
                            
                            if let company = companies.first(where: { $0.id == companyId }) {
                                Task.create(in: context, name: taskName, date: dateIsSet ? date : nil, endDate: endDateIsSet ? endDate : nil, remindDate: reminderIsSet ? remindDate : nil, companyId: company.id, companyName: company.name)
                            } else {
                                Task.create(in: context, name: taskName, date: dateIsSet ? date : nil, endDate: endDateIsSet ? endDate : nil, remindDate: reminderIsSet ? remindDate : nil, companyId: nil, companyName: nil)
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
                        Alert(title: Text(String(format: NSLocalizedString("タスク名は1文字以上%d文字以内で入力してください。", comment: ""), ValidationCounts.comAndTaskText.rawValue)))
                    }
                }
            }
        }
        
    }
}
