//
//  ProjectView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct ProjectView: View {
    
    @ObservedObject var ts: TodoistService
    @Binding var project: Project
    @StateObject var asvvm = AddSectionViewViewModel()
    @StateObject var patsvm = ProjectAddTaskViewModel()
    
    var body: some View {
        NavigationStack {
            TabView() {
                    
                ForEach($project.sections) { $i in
                    VStack {
                        SectionView(ts: ts, section: $i, patsvm: patsvm, project: $project)
                    }
                    
                    
                }
                VStack {
                    Button() {
                        asvvm.showingSheet.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 350, height: 40)
                                .cornerRadius(6)
                                .opacity(0.15)
                            HStack {
                                Image(systemName: "plus.rectangle")
                                    .foregroundColor(.black)
                                Text("Add Section")
                                    .foregroundColor(.black)
                            }
                                
                        }
                        
                    }
                    .sheet(isPresented: $asvvm.showingSheet) {
                        AddSectionView(project: $project, vm: asvvm, ts: ts)
                            .presentationDetents([.fraction(0.075)])
                        
                        
                }
                    .padding(.top, 30)
                    Spacer()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))


        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Text("**\(project.name)**").font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
    }
 
    
    struct ProjectView_Previews: PreviewProvider {
        static var previews: some View {
            ProjectView(ts: TodoistService(), project: .constant(Project(name: "")))
        }
    }
}
