//
//  AddTaskToInboxView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/11/23.
//

import SwiftUI

struct AddTaskToInboxView: View {
    
    @ObservedObject var vm: HomeViewViewModel
    @ObservedObject var ps: ProjectService
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Task Name", text: $vm.name)
                Button ("Add") {
                    ps.taskLibrary.append(Task(name: vm.name, isCompleted: false, existsInProject: false))
                    vm.inboxAdd.toggle()
                }
            
            }
        }    }
}

struct AddTaskToInboxView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskToInboxView(vm: HomeViewViewModel(), ps: ProjectService())
    }
}
