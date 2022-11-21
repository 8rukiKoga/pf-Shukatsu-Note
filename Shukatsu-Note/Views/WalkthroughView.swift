//
//  WalkthroughView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/11/18.
//

import SwiftUI

struct WalkthroughView: View {
    
    @Binding var showingWalkthrough: Bool
    
    let screens = 5
    @State var currentScreen: Int = 1
    
    @State var title: String = NSLocalizedString("就活管理をスマホ1つで", comment: "")
    @State var description: String = NSLocalizedString("紙で管理していた就活・企業の管理をスマホ1つでおこなうことができます。", comment: "")
    @State var bgColor: String = "ThemeColor1"
    @State var img: String = "WalkThroughImage1"
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text("Walkthrough")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                    Spacer()
                    Button(
                        action:{
                            showingWalkthrough = false
                        },
                        label: {
                            Text("Skip")
                                .foregroundColor(Color.white)
                        }
                    )
                }.padding()
                Spacer()
                VStack(alignment: .leading){
                    
                    Image(img)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(5)
                        .padding()
                        .shadow(color: Color(.label), radius: 2, x: 3, y: 3)
                    
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding(.top)
                    
                    
                    Text(description)
                        .padding(.top, 5.0)
                        .foregroundColor(Color.white)
                    Spacer(minLength: 0)
                }
                .padding()
                .overlay(
                    // 進捗度バー
                    HStack{
                        
                        if currentScreen == 1 {
                            ContainerRelativeShape()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        if currentScreen == 2 {
                            ContainerRelativeShape()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        if currentScreen == 3 {
                            ContainerRelativeShape()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        if currentScreen == 4 {
                            ContainerRelativeShape()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        if currentScreen == 5 {
                            ContainerRelativeShape()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 5)
                        } else {
                            ContainerRelativeShape()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: 25, height: 5)
                        }
                        
                        Spacer()
                        Button(
                            action:{
                                withAnimation(.easeInOut) {
                                    // 次のスクリーンに移動
                                    currentScreen += 1
                                    
                                    if currentScreen == 2 {
                                        title = NSLocalizedString("ノート機能", comment: "")
                                        description = NSLocalizedString("就活でメモしておきたいことを記録できます。\nノートは企業に紐づけることもできます。", comment: "")
                                        bgColor = "ThemeColor5"
                                        img = "WalkThroughImage2"
                                    } else if currentScreen == 3 {
                                        title = NSLocalizedString("TODO機能", comment: "")
                                        description = NSLocalizedString("企業の説明会・面接などのタスクをTODOリストに保存できます。\n登録したタスクはiPhoneのカレンダーに保存することもできます。", comment: "")
                                        bgColor = "ThemeColor2"
                                        img = "WalkThroughImage3"
                                    } else if currentScreen == 4 {
                                        title = NSLocalizedString("リマインダー機能", comment: "")
                                        description = NSLocalizedString("タスクのリマインダーをオンにすれば、設定した時間に通知が届きます。", comment: "")
                                        bgColor = "ThemeColor4"
                                        img = "WalkThroughImage4"
                                    } else if currentScreen == 5 {
                                        title = NSLocalizedString("さあ、はじめよう", comment: "")
                                        description = NSLocalizedString("就職活動を賢く管理し、あなたの志望する企業の内定を勝ち取りましょう。", comment: "")
                                        bgColor = "ThemeColor1"
                                        img = "WalkThroughImage5"
                                    } else if currentScreen > 5 {
                                        showingWalkthrough = false
                                    }
                                }
                            },
                            label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 35.0, weight: .semibold))
                                    .frame(width: 55, height: 55)
                                    .background(Color(.purple).opacity(0.5))
                                    .clipShape(Circle())
                                    .padding(17)
                                    .overlay(
                                        ZStack{
                                            Circle()
                                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
                                                .padding()
                                                .foregroundColor(Color.white)
                                        }
                                    )
                            }
                        )
                    }
                        .padding()
                    ,alignment: .bottomTrailing
                )
            }
        }
        .background(
            LinearGradient(colors: [
                Color(bgColor),Color(.systemPurple)]
                           ,startPoint: .top, endPoint: .bottom)
        )
    }
}

struct WalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView(showingWalkthrough: .constant(true), title: "これはタイトルです", description: "テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト", bgColor: "ThemeColor1", img: "WalkThroughImage1")
    }
}
