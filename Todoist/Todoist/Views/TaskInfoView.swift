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
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.gray)
                        .frame(width: 28, height: 28)
                }
                .padding(.top, 15)
                .padding(.trailing, 16)
                .padding(.bottom, 20)
                HStack {
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    Button {
                        isShowing.toggle()
                    } label: {
                        Text("\(task.name)")
                            .foregroundColor(.black).bold()
                            .font(.title)
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
                .padding(.bottom, 15)
                HStack {
                    Image(systemName: "sidebar.squares.left")
                        .foregroundColor(.green)
                    Text("Today at 10:00 PM")
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.leading, 10)

            }

            Spacer()
        }
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(task: .constant(Task(name: "", isCompleted: false, dueDate: Date())))
    }
}
