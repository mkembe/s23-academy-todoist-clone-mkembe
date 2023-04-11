//
//  Task.swift
//  Todoist
//
//  Created by Millie Kembe on 4/9/23.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
    var section: pSection?
    var existsInProject: Bool

}
