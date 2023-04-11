//
//  Section.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import Foundation

struct pSection: Identifiable {
    var id = UUID()
    var name: String
    var project: Project
}
