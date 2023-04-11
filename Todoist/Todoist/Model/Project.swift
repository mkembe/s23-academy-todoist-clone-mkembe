//
//  Project.swift
//  Todoist
//
//  Created by Millie Kembe on 4/9/23.
//

import Foundation

struct Project: Identifiable{
    var id = UUID()
    var name: String
    var favorite: Bool
    var isChild: Bool = false
    var active: Bool = true
}
