//
//  HomeViewViewModel.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import Foundation

class HomeViewViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var manageProjectsShowingSheet = false
    @Published var inboxAdd = false
    @Published var name = ""
}
