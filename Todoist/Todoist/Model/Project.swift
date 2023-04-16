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
    var sections: [ProjectSection] = []
}
