//
//  TaskView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var task: Task
    @ObservedObject var vm: TaskViewViewModel
    
    var body: some View {
        

            HStack {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                Button {
                    vm.showingSheet.toggle()
                } label: {
                    Text("\(task.name)").foregroundColor(.black)


                }
                .sheet(isPresented: $vm.showingSheet) {
                    TaskInfoView(task: $task)
                }

                Spacer()
                
                
                

                
                
            }
            .frame(width: 321, height: 12)
            .padding()
            .background(Color.white)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 8)


        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: .constant(Task(name: "", isCompleted: false, dueDate: Date())), vm: TaskViewViewModel())
    }
}
