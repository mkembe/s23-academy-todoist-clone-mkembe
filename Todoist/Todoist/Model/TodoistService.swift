//
//  TodoistService.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import Foundation

class TodoistService: ObservableObject{
    @Published var projects: [Project]
    @Published var inboxTasks: [Task] = []

    
    init() {
        let exampleProj = Project(name: "School", sections: [ProjectSection(name: "Math"), ProjectSection(name: "Science")])
        projects = [exampleProj]
    }
}
