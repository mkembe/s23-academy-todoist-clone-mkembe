//
//  InboxView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct InboxView: View {
    
    @ObservedObject var ts: TodoistService
    @ObservedObject var vm: HomeViewViewModel
    @StateObject var tvvm = TaskViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($ts.inboxTasks) { task in
                        
                        TaskView(task: task, vm: tvvm)

                    }
                }
            }
            .listStyle(GroupedListStyle())
            VStack {
                Spacer()
                Button() {
                    vm.inboxAdd.toggle()
                }  label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .scaledToFill()
                        .frame(width: 40, height: 40)

                }
                
                .padding(.leading, 300)
                .sheet(isPresented: $vm.inboxAdd) {
                    AddTaskToInboxView(vm: vm, ts: ts)
                }
            }
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Text("**Inbox**").font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(ts: TodoistService(), vm: HomeViewViewModel())
    }
}
