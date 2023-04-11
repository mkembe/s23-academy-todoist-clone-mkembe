//
//  ProjectAddTaskViewViewModel.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import Foundation

class ProjectAddTaskViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var name = ""
    @Published var completed = false
    @Published var section = pSection(name: "", project: Project(name: "", favorite: false))
}
