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
    @StateObject var ivm = InboxVM()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        
                        ForEach(0...ts.inboxTasks.count - 1, id: \.self) { i in
                            if(ts.inboxTasks[i].isCompleted == false) {
                                
                                InboxTasks(ivm: ivm, i: .constant(i), ts: ts)
                                    
                                    
                                }
                        }
                        
                        

                    }
                }
                VStack {
                    Spacer()
                    Button() {
                        vm.inboxAdd.toggle()
                    }  label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.cyan)
                            .scaledToFill()
                            .frame(width: 40, height: 40)

                    }
                    
                    .padding(.leading, 300)
                    .sheet(isPresented: $vm.inboxAdd) {
                        AddTaskToInboxView(vm: vm, ts: ts)
                            .presentationDetents([.fraction(0.25)])

                    }
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


struct InboxTasks: View {
    
    @ObservedObject var ivm: InboxVM
    @Binding var i: Int
    @ObservedObject var ts: TodoistService
    
    var body: some View {
        NavigationStack {
            HStack {
                Button() {
                    ts.inboxTasks[i].isCompleted.toggle()
                } label: {
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)

                }
                .buttonStyle(.borderless)

                Button {
                    ivm.showingSheet.toggle()
                } label: {
                    Text("\(ts.inboxTasks[i].name)").foregroundColor(.black)
                        .padding(.bottom, 15)


                }
                .sheet(isPresented: $ivm.showingSheet) {
                    InboxTaskInfoView(task: $ts.inboxTasks[i], vm: ivm)
                        .presentationDetents([.fraction(0.75)])

                }
                .padding(.top)
                .buttonStyle(.borderless)

                Spacer()
                
                
                

                
                
            }
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(ts: TodoistService(), vm: HomeViewViewModel())
    }
}
