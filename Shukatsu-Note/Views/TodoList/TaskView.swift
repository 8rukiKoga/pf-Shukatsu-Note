//
//  TaskView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/12.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var showingEditSheet: Bool
    
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var customColor: CustomColor
    @FetchRequest(
        entity: Company.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Company.star, ascending: false),
            NSSortDescriptor(keyPath: \Company.createdAt, ascending: true)
        ],
        predicate: nil
    ) private var companies: FetchedResults<Company>
    
    // ボタンの活性・非活性
    @State private var isBtnEnabled: Bool = true
    // 文字数アラート表示・非表示
    @State private var showingValidationAlert: Bool = false
    
    let task: Task!
    
    @State var taskName: String
    @State var date: Date = Date()
    @State var dateIsSet: Bool = true
    @State var remindDate: Date = Date()
    @State var reminderIsSet: Bool = false
    @State var company: Company?
    
    var body: some View {
        ZStack {
            List {
                Section(NSLocalizedString("タスク名", comment: "")) {
                    VStack {
                        TextField(NSLocalizedString("タスク名を入力", comment: ""), text: $taskName)
                            .padding(10)
                            .background(Color(.systemGray5))
                            .cornerRadius(7)
                        
                        Text("\(taskName.count) / \(ValidationCounts.comAndTaskText.rawValue)")
                            .font(.caption)
                            .foregroundColor(TextCountValidation.shared.isTextCountValid(text: taskName, type: .comAndTaskText) ? .gray : .red)
                    }
                }
                
                
                Section(NSLocalizedString("日付", comment: "")) {
                    HStack {
                        Text(NSLocalizedString("日付", comment: ""))
                        
                        Toggle("", isOn: $dateIsSet)
                            .animation(.easeInOut, value: dateIsSet)
                        if dateIsSet {
                            DatePicker("", selection: $date)
                                .transition(.slide)
                        } else {
                            Text(NSLocalizedString("日付未指定", comment: ""))
                                .foregroundColor(.gray)
                                .transition(.slide)
                        }
                    }
                }
                
                if dateIsSet {
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
                            Text(NSLocalizedString("タスク当日の設定した時刻に通知が届きます。\niPhoneの設定から「就活ノート」の通知をオンにしておいてください。", comment: ""))
                                .font(.caption)
                        }
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
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        // 通知を1つのみ登録するため、一度押したらボタンを非活性にする
                        isBtnEnabled = false
                        // もしタスク文字数が許容量を超えていたら
                        if !TextCountValidation.shared.isTextCountValid(text: taskName, type: .comAndTaskText) {
                            // アラート表示
                            showingValidationAlert = true
                            // ボタンを活性化
                            isBtnEnabled = true
                        } else {
                            // db保存
                            Task.updateTask(in: context, task: task, companyId: company?.id, name: taskName, date: date, remindAt: remindDate)
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
                                showingEditSheet = false
                            }
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "checkmark.circle.fill")
                                .modifier(FloatingBtnMod())
                        }
                    }
                    .disabled(!isBtnEnabled)
                    .alert(isPresented: $showingValidationAlert) {
                        Alert(title: Text(String(format: NSLocalizedString("タスク名は1文字以上%d文字以内で入力してください。", comment: ""), ValidationCounts.comAndTaskText.rawValue)))
                    }
                }
            }
            
        }
    }
}
