//
//  ProjectSection.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import Foundation

struct ProjectSection: Identifiable {
    var id = UUID()
    var name: String
    var tasks: [Task] = []
}
