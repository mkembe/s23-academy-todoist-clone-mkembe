//
//  AddProjectView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct AddProjectView: View {
    
    @StateObject var vm = AddProjectViewModel()
    @ObservedObject var ts: TodoistService
    @ObservedObject var hvvm: HomeViewViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Name your project", text: $vm.name)
                }
                Section {
                    HStack {
                        Text("Favorite")
                        Toggle("", isOn: $vm.favorite)
                    }
                }
                Section {
                    HStack {
                        Text("Board View")
                    }
                } header: {
                    Text("View")
                } footer: {
                    Text("This project will display tasks in a board view.")
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        ts.projects.append(Project(name: vm.name))
                        vm.name = ""
                        hvvm.showingSheet.toggle()
                    }
                }
            }
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(ts: TodoistService(), hvvm: HomeViewViewModel())
    }
}
