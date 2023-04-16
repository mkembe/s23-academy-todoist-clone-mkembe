//
//  ProjectAddTaskView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct ProjectAddTaskView: View {
    
    @ObservedObject var ts: TodoistService
    @ObservedObject var vm: ProjectAddTaskViewModel
    @Binding var section: ProjectSection
    @State var description = ""
    @State var date = Date()
    
    var body: some View {
        
        
        TextField("Task Name", text: $vm.name)
        TextField("Description", text: $vm.description)
        DatePicker(selection: $date, in: ...date, displayedComponents: .date) {
            Text("Due date")
        }
        Button ("Add") {
            section.tasks.append(Task(name: vm.name, isCompleted: false, description: vm.description, dueDate: date))
            vm.showingSheet.toggle()
            vm.name = ""
        }
    
    }
}

struct ProjectAddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectAddTaskView(ts: TodoistService(), vm: ProjectAddTaskViewModel(), section: .constant(ProjectSection(name: "")))
    }
}
