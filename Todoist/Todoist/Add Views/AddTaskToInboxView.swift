//
//  AddTaskToInboxView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/11/23.
//

import SwiftUI

struct AddTaskToInboxView: View {
    
    @ObservedObject var vm: HomeViewViewModel
    @ObservedObject var ts: TodoistService
    @State var addDate = true
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Task Name", text: $vm.name)
                Button ("Add") {
                    if(addDate) {
                        ts.inboxTasks.append(Task(name: vm.name, isCompleted: false, description: vm.description, dueDate: vm.date))
                    }
                    else {
                        ts.inboxTasks.append(Task(name: vm.name, isCompleted: false, description: vm.description, dueDate: vm.date))
                    }
                    vm.inboxAdd.toggle()
                }
            
            }
            TextField("Description", text: $vm.description)

            DatePicker(selection: $vm.date, in: ...Date.now, displayedComponents: .date) {
                Text("Due date")
            }
            Button("no date") {
                addDate = false
            }

        }    }
}

struct AddTaskToInboxView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskToInboxView(vm: HomeViewViewModel(), ts: TodoistService())
    }
}
