//
//  TodoListView.swift
//  Shukatsu-Note
//
//  Created by 古賀遥貴 on 2022/08/06.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var todoVm: TodoViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                
                List {
                    HStack {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("task1")
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("task1")
                    }
                    .padding(.horizontal)
                }
                .listStyle(PlainListStyle())
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            ZStack {
                                Image(systemName: "plus")
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
            .navigationTitle("Todo")
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoVm: TodoViewModel())
    }
}
