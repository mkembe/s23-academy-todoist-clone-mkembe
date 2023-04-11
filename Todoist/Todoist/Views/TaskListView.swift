//
//  TaskListView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var ps: ProjectService
    @Binding var section: pSection
    
    var body: some View {
        VStack {
            ForEach(ps.taskLibrary) { task in
                
                if(task.section?.name == section.name) {
                    Text("\(task.name)")
                }

            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(ps: ProjectService(), section: .constant(pSection(name: "", project: Project(name: "", favorite: false))))
    }
}
