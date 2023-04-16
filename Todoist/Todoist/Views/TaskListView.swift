//
//  TaskListView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var ts: TodoistService
    @Binding var section: ProjectSection
    @StateObject var vm = TaskViewViewModel()
    
    var body: some View {
        VStack {
            ForEach($section.tasks) { $task in
                TaskView(task: $task, vm: vm)
                }
            

            }
        }
    }

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(ts: TodoistService(), section: .constant(ProjectSection(name: "")))
    }
}
