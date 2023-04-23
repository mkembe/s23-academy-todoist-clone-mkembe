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
    
    var month: String {
        let date = task.dueDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date!)
        return monthString
    }
    
    var day: Int {
        let date = task.dueDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date!)
        let dayOfMonth = components.day
        return dayOfMonth!
    }
    
    var dayOfWeek: String {
        let date = task.dueDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date!)
        return dayOfTheWeekString
    }
    
    var body: some View {
        
        
        
        if(task.dueDate == nil) {
            HStack {
                Button {
                    task.isCompleted.toggle()
                } label: {
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.gray)

                        .frame(width: 20, height: 20)
                }

                Button {
                    vm.showingSheet.toggle()
                } label: {
                    Text("\(task.name)").foregroundColor(.black)
                        .padding(.bottom, 15)
                    
                    
                }
                .sheet(isPresented: $vm.showingSheet) {
                    TaskInfoView(task: $task, vm: vm)
                        .presentationDetents([.fraction(0.75)])
                    
                }
                .padding(.top)
                
                
                Spacer()
            }
            .frame(width: 321, height: 18)
            .padding()
            .background(Color.white)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 8)
        } else {
            HStack {
                Button {
                    task.isCompleted.toggle()
                } label: {
                    Image(systemName: "circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.gray)
                        .frame(width: 20, height: 20)
                }

                Button {
                    vm.showingSheet.toggle()
                } label: {
                    VStack {
                        VStack {
                            HStack {
                                Text("\(task.name)").foregroundColor(.black)
                                Spacer()
                            }
                        }
                        HStack {
                            Image(systemName: "calendar.day.timeline.left")
                            Text("\(month) \(day)")
                            Spacer()

                        }
                    }
    
                }
                .sheet(isPresented: $vm.showingSheet) {
                    TaskInfoView(task: $task, vm: vm)
                        .presentationDetents([.fraction(0.75)])

                }
                .padding(.top)


                Spacer()
                
                
                

                
                
            }
            .frame(width: 321, height: 45)
            .padding()
            .background(Color.white)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 8)
        }
        




        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: .constant(Task(name: "New Task", isCompleted: false, dueDate: Date())), vm: TaskViewViewModel())
    }
}
