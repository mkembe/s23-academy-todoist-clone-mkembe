//
//  ProjectView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct ProjectView: View {
    
    @ObservedObject var ps: ProjectService
    @Binding var project: Project
    @StateObject var asvvm = AddSectionViewViewModel()
    @StateObject var patsvm = ProjectAddTaskViewModel()
    
    var body: some View {
        NavigationStack {
            TabView() {
                    
                    ForEach(ps.sectionLibrary) { section in
                        if(section.project.id == project.id) {
                            VStack {
                                Text("\(section.name)")
                                TaskListView(ps: ps, section: $ps.sectionLibrary[ps.sectionLibrary.firstIndex(where: {$0.id == section.id} ) ?? 0])
                                AddTaskButton(ps: ps, patsvm: patsvm, section: $ps.sectionLibrary[ps.sectionLibrary.firstIndex(where: {$0.id == section.id} ) ?? 0])
                                
                            }
                        }
                    
                    
                }
                Button() {
                    asvvm.showingSheet.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 350, height: 40)
                            .cornerRadius(6)
                            .opacity(0.25)
                        HStack {
                            Image(systemName: "plus.rectangle")
                                .foregroundColor(.black)
                            Text("Add Section")
                                .foregroundColor(.black)
                        }
                            
                    }
                    
                }
                .sheet(isPresented: $asvvm.showingSheet) {
                    AddSectionView(project: $project, vm: asvvm, ps: ps)
                        .presentationDetents([.fraction(0.075)])
                    
                    
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))


        }
    }
    
    struct AddTaskButton: View {
        
        @ObservedObject var ps: ProjectService
        @ObservedObject var patsvm: ProjectAddTaskViewModel
        @Binding var section: pSection
        
        var body: some View {
            Button("Add Task") {
                patsvm.showingSheet.toggle()
            }
            .sheet (isPresented: $patsvm.showingSheet) {
                ProjectAddTaskView(ps: ps, vm: patsvm, section: $ps.sectionLibrary[ps.sectionLibrary.firstIndex(where: {$0.id == section.id} ) ?? 0])
                    .presentationDetents([.fraction(0.15)])
                
            }
        }
    }
    
    struct ProjectView_Previews: PreviewProvider {
        static var previews: some View {
            ProjectView(ps: ProjectService(), project: .constant(Project(name: "", favorite: false)))
        }
    }
}
