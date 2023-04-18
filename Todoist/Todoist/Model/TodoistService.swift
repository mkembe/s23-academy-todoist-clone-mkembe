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
        var exampleProj = Project(name: "School", sections: [ProjectSection(name: "Math"), ProjectSection(name: "Science")])
        exampleProj.sections[0].tasks.append(Task(name: "Homework Assignment 1", isCompleted: false, dueDate: Date()))
        exampleProj.sections[0].tasks.append(Task(name: "Homework Assignment 3", isCompleted: false, dueDate: Date()))
        exampleProj.sections[0].tasks.append(Task(name: "Study for Exam", isCompleted: false, dueDate: Date()))
        exampleProj.sections[1].tasks.append(Task(name: "Finish Lab Report", isCompleted: false, dueDate: Date()))
        projects = [exampleProj]

    }
}
