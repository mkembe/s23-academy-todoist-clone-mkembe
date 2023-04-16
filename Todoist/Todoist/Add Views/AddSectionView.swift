//
//  AddSectionView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct AddSectionView: View {
    
    @Binding var project: Project
    @ObservedObject var vm = AddSectionViewViewModel()
    @ObservedObject var ts: TodoistService
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("**Section name**", text: $vm.name)
                    .padding(.leading, 5)
                Button() {
                    project.sections.append(ProjectSection(name: vm.name))
                    vm.showingSheet.toggle()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing, 2)
            }
        }
    }
}

struct AddSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSectionView(project: .constant(Project(name: " ")), vm: AddSectionViewViewModel(), ts: TodoistService())
    }
}
