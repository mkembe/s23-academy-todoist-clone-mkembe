//
//  AddSectionViewViewModel.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import Foundation

class AddSectionViewViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var name = ""
}
