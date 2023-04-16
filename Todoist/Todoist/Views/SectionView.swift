//
//  SectionView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/14/23.
//

import SwiftUI

struct SectionView: View {
    
    @ObservedObject var ts: TodoistService
    @Binding var section: ProjectSection
    @ObservedObject var patsvm: ProjectAddTaskViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                Text("\(section.name)").font(.headline).bold()
                    .multilineTextAlignment(.trailing)

                Text("\(section.tasks.count)").foregroundColor(.gray)
                
            }
            .padding(.leading, -180)
            .padding(.top, 50)
            TaskListView(ts: ts, section: $section)
            Button {
                patsvm.showingSheet.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 350, height: 40)
                        .cornerRadius(6)
                        .shadow(color: .black, radius: 10, x: 0, y: 8)
                        .opacity(0.2)

                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.red)
                            .padding(.trailing, 8)
                        Text("Add Task")
                            .foregroundColor(.black)
                            .padding(.trailing, 220)

                    }
                        
                }
            }
            .sheet(isPresented: $patsvm.showingSheet) {
                ProjectAddTaskView(ts: ts, vm: patsvm, section: $section)
            }
            .padding(.top)
            Spacer()
            
        }

    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(ts: TodoistService(), section: .constant(ProjectSection(name: "")), patsvm: ProjectAddTaskViewModel())
    }
}
