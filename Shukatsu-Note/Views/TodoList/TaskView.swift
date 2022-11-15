//
//  TaskView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/12.
//

import SwiftUI

struct TaskView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Company.star, ascending: false)],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    @EnvironmentObject private var customColor: CustomColor
    
    let task: Task!
    
    @State var status: Bool
    @State var taskName: String
    @State var date: Date = Date()
    @State var dateIsSet: Bool = true
    @State var reminderBtnText: String = NSLocalizedString("当日に通知する", comment: "")
    @State var remindDate: Date = Date()
    @State var reminderIsSet: Bool = false
    @State var company: Company?
    
    @State private var isBtnEnabled: Bool = true
    
    var body: some View {
        List {
            Section(NSLocalizedString("ステータス", comment: "")) {
                HStack {
                    Spacer()
                    Text(status ? "DONE" : "NOT DONE")
                        .foregroundColor(status ? .green.opacity(0.7) : .black.opacity(0.7))
                    Spacer()
                }
                .listRowBackground(status ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
                .padding(.vertical, 3)
            }
            
            Section(NSLocalizedString("タスク名", comment: "")) {
                VStack {
                    TextField(NSLocalizedString("タスク名を入力", comment: ""), text: $taskName)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(7)
                    
                    Text("\(taskName.count) / 50")
                        .font(.caption)
                        .foregroundColor(TextCountValidation.shared.isTextCountValid(text: taskName, max: 50) ? .gray : .red)
                }
            }
            
            
            Section(NSLocalizedString("日付", comment: "")) {
                HStack {
                    Text(NSLocalizedString("日付", comment: ""))
                    
                    Toggle("", isOn: $dateIsSet)
                        .animation(.easeInOut, value: dateIsSet)
                    if dateIsSet {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .transition(.slide)
                    } else {
                        Text(NSLocalizedString("日付未指定", comment: ""))
                            .foregroundColor(.gray)
                            .transition(.slide)
                    }
                }
            }
            
            Section(NSLocalizedString("リマインダー", comment: "")) {
                HStack {
                    Text(NSLocalizedString("時刻", comment: ""))
                    
                    Toggle("", isOn: $reminderIsSet)
                        .animation(.easeInOut, value: reminderIsSet)
                    if reminderIsSet {
                        DatePicker("", selection: $remindDate, displayedComponents: .hourAndMinute)
                            .transition(.slide)
                    } else {
                        Text(NSLocalizedString("未設定", comment: ""))
                            .foregroundColor(.gray)
                            .transition(.slide)
                    }
                }
                
                if reminderIsSet {
                    Text(NSLocalizedString("当日の設定した時刻に通知が届きます。\niPhoneの設定から「就活ノート」の通知をオンにしておいてください。", comment: ""))
                        .font(.caption)
                }
            }
            
            Section(NSLocalizedString("企業", comment: "")) {
                HStack {
                    Picker("", selection: $company) {
                        Text(NSLocalizedString("未選択", comment: ""))
                        ForEach(companies) { company in
                            // もともとopt型で宣言しているので、ピッカーのtagの方でもopt型に変換しないと適用されない(xcode上ではエラーにならないけど)
                            Text(company.name ?? "").tag(company as Company?)
                        }
                    }
                    .pickerStyle(.menu)
                    .transition(.slide)
                }
            }
            
            Section {
                HStack {
                    Spacer()
                    Button {
                        isBtnEnabled = false
                        // db保存
                        Task.updateTask(in: context, task: task, companyId: company?.id, companyName: company?.name, name: taskName, date: date, remindAt: remindDate)
                        // 既にある通知予定の通知を削除
                        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                            requests.forEach {
                                if $0.identifier == task.id {
                                    NotificationManager.instance.cancelNotification(id: task.id!)
                                }
                            }
                        }
                        // 削除した後に登録したいため、遅延させる
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // 通知リクエスト作成
                            if dateIsSet {
                                if reminderIsSet {
                                    NotificationManager.instance.scheduleNotification(id: task.id!, date: date, time: remindDate, taskName: task.name!)
                                }
                            }
                            // バイブレーション
                            VibrationGenerator.vibGenerator.notificationOccurred(.success)
                            // 前の画面に戻る
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        ZStack {
                            Color(customColor.themeColor)
                                .cornerRadius(10)
                            
                            Text("保存")
                                .font(.title3).bold()
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        }
                    }
                    .disabled(!isBtnEnabled)
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    Button {
                        // 前画面に戻る
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Color.gray
                                .cornerRadius(10)
                            
                            Text("キャンセル")
                                .font(.title3).bold()
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .padding(.vertical, 6)
                        }
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparatorTint(Color.clear)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
