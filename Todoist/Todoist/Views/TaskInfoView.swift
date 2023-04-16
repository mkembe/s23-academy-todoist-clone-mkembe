//
//  TaskInfoView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import SwiftUI

struct TaskInfoView: View {
    
    @Binding var task: Task
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "circle")
                    TextField("\(task.name)", text: $task.name)
                    
                }
                HStack {
                    Text("Due Date: ")
                }
                HStack {
                    TextField("\(task.description ?? "Description")", text: $task.description.toUnwrapped(defaultValue: ""))
                }
            }
        }
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(task: .constant(Task(name: "", isCompleted: false, dueDate: Date())))
    }
}
