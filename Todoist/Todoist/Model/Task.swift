//
//  Task.swift
//  Todoist
//
//  Created by Millie Kembe on 4/9/23.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted: Bool
    var description: String?
    var dueDate: Date 
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
