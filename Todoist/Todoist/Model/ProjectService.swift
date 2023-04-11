//
//  ProjectService.swift
//  Todoist
//
//  Created by Millie Kembe on 4/9/23.
//

import Foundation

class ProjectService: ObservableObject{
    @Published var projectLibrary: [Project] = []
    @Published var sectionLibrary: [pSection] = []
    @Published var taskLibrary: [Task] = []
}
