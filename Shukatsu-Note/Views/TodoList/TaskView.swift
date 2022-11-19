//
//  TaskView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/12.
//

import SwiftUI
import EventKit

struct TaskView: View {
    // シートの表示・非表示
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
    
    var eventStore = EKEventStore()
    
    @FocusState private var inputFocus: Bool
    
    
    // ボタンの活性・非活性
    @State private var isBtnEnabled: Bool = true
    // 文字数アラート表示・非表示
    @State private var showingValidationAlert: Bool = false
    // カレンダーアラート表示・非表示
    @State private var showingCalenderAlert: Bool = false
    @State private var calenderAlertText: String = NSLocalizedString("カレンダーに保存されました！", comment: "")
    
    let task: Task!
    
    @State var taskName: String
    @State var date: Date = Date()
    @State var endDate: Date = Date() + (60 * 30)
    @State var dateIsSet: Bool = true
    @State var endDateIsSet: Bool = false
    @State var remindDate: Date = Date()
    @State var reminderIsSet: Bool = false
    @State var company: Company?
    
    var body: some View {
        ZStack {
            List {
                Section(NSLocalizedString("タスク名", comment: "")) {
                    VStack {
                        TextField(NSLocalizedString("タスク名を入力", comment: ""), text: $taskName)
                            .focused($inputFocus)
                            .padding(10)
                            .background(Color(.systemGray5))
                            .cornerRadius(7)
                        
                        Text("\(taskName.count) / \(ValidationCounts.comAndTaskText.rawValue)")
                            .font(.caption)
                            .foregroundColor(TextCountValidation.shared.isTextCountValid(text: taskName, type: .comAndTaskText) ? .gray : .red)
                    }
                }
                
                
                Section(NSLocalizedString("日付", comment: "")) {
                    Toggle(NSLocalizedString("日付", comment: ""), isOn: $dateIsSet)
                        .animation(.easeInOut, value: dateIsSet)
                    
                    
                    if dateIsSet {
                        Toggle(NSLocalizedString("終了日時も設定する", comment: ""), isOn: $endDateIsSet)
                            .animation(.easeInOut, value: endDateIsSet)
                        
                        if !endDateIsSet {
                            DatePicker("日付", selection: $date, displayedComponents: .date)
                        } else {
                            DatePicker("開始", selection: $date)
                        }
                    }
                    
                    if !dateIsSet {
                        Text(NSLocalizedString("日付未指定", comment: ""))
                            .foregroundColor(.gray)
                            .transition(.slide)
                    }
                    
                    if endDateIsSet {
                        if endDateIsSet {
                            DatePicker("終了", selection: $endDate, in: date...)
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
                    
                    HStack {
                        if dateIsSet {
                            Button {
                                if EKEventStore.authorizationStatus(for: .event) == .notDetermined{
                                    eventStore.requestAccess(to: .event, completion: { (granted, error) in
                                        if granted && error == nil {
                                            print("granted")
                                        }
                                        else{
                                            print("not granted")
                                        }
                                    })
                                }
                                
                                if EKEventStore.authorizationStatus(for: .event) == .authorized {
                                    let event = EKEvent(eventStore: eventStore)
                                    
                                    if let companyName = companies.first(where: { $0.id == task.companyId })?.name {
                                        event.title = "【\(companyName)】\(taskName)"
                                    } else {
                                        event.title = taskName
                                    }
                                    
                                    if dateIsSet {
                                        
                                        if endDateIsSet {
                                            event.startDate = date
                                            event.endDate = endDate
                                        } else {
                                            event.startDate = date
                                            event.endDate = Calendar.current.date(byAdding: .minute, value: 1, to: date)! // 保存するために終了日が必須そうなので、終了日を書いておく
                                            event.isAllDay = true
                                        }
                                        
                                        event.calendar = eventStore.defaultCalendarForNewEvents
                                    }
                                    
                                    do {
                                        try eventStore.save(event, span: .thisEvent)
                                        calenderAlertText = NSLocalizedString("カレンダーに保存されました！", comment: "")
                                        showingCalenderAlert = true
                                    }
                                    catch {
                                        calenderAlertText = NSLocalizedString("保存に失敗しました。\n入力内容が誤っている可能性があります。", comment: "")
                                        showingCalenderAlert = true
                                    }
                                }
                                else{
                                    calenderAlertText = "カレンダーに保存するためには、\n設定>\nプライバシー>\nカレンダー\nでアクセスを許可して下さい。"
                                    showingCalenderAlert = true
                                }
                                
                            } label: {
                                ZStack {
                                    Image(systemName: "calendar.badge.plus")
                                        .modifier(FloatingBtnMod(size: 50))
                                }
                            }
                            .disabled(!isBtnEnabled)
                            .alert(isPresented: $showingCalenderAlert) {
                                Alert(title: Text(calenderAlertText))
                            }
                        }
                        
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
                                if !dateIsSet {
                                    reminderIsSet = false
                                    endDateIsSet = false
                                }
                                // db保存
                                Task.updateTask(in: context, task: task, companyId: company?.id, name: taskName, dateIsSet: dateIsSet, date: date, endDate: endDate, endDateIsSet: endDateIsSet, reminderIsSet: reminderIsSet, remindAt: remindDate)
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
                                            NotificationManager.instance.scheduleNotification(id: task.id!, date: date, time: remindDate, companyName: company?.name, taskName: task.name!)
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
}
