//
//  ProjectAddTaskView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct ProjectAddTaskView: View {
    
    @ObservedObject var ps: ProjectService
    @ObservedObject var vm: ProjectAddTaskViewModel
    @Binding var section: pSection
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Task Name", text: $vm.name)
                Button ("Add") {
                    ps.taskLibrary.append(Task(name: vm.name, isCompleted: vm.completed, section: section, existsInProject: true))
                    vm.showingSheet.toggle()
                }
            
            }
        }
    }
}

struct ProjectAddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectAddTaskView(ps: ProjectService(), vm: ProjectAddTaskViewModel(), section: .constant(pSection(name: "", project: Project(name: "", favorite: false))))
    }
}
