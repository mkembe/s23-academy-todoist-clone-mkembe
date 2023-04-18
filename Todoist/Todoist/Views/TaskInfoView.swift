//
//  TaskInfoView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import SwiftUI

struct TaskInfoView: View {
    
    @Binding var task: Task
    @State var isShowing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "circle")
                    Button {
                        isShowing.toggle()
                    } label: {
                        Text("\(task.name)")
                            .foregroundColor(.black).bold()
                    }
                    .sheet(isPresented: $isShowing) {
                        VStack {
                            HStack {
                                Image(systemName: "circle")
                                TextField("\(task.name)", text: $task.name)
                            }
                            HStack {
                                Image(systemName: "text.alignleft")
                                TextField("\(task.description ?? "Description")", text: $task.description.toUnwrapped(defaultValue: ""))

                            }
                        }
                        .presentationDetents([.fraction(0.75)])

                    }
                    Spacer()
                    
                }
                .padding(.leading, 10)
                HStack {
                    Image(systemName: "sidebar.squares.left")
                        .foregroundColor(.green)
                    Text("April 15")
                    Spacer()
                }
                .padding(.leading, 10)
                HStack {
                    TextField("\(task.description ?? "Description")", text: $task.description.toUnwrapped(defaultValue: ""))
                }
            }
        }
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(task: .constant(Task(name: "", isCompleted: false, dueDate: Date())))
    }
}
