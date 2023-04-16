//
//  TodayView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import SwiftUI

struct TodayView: View {
    
    @ObservedObject var ts: TodoistService
    @StateObject var vm = TaskViewViewModel()
    
    var month: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        return monthString
    }
    
    var day: Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day
        return dayOfMonth!
    }
    
    var dayOfWeek: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        return dayOfTheWeekString
    }
    
    var body: some View {
        NavigationStack {

            List {
                Section {
                    ForEach($ts.inboxTasks) { task in
                        
                        let calendar = Calendar.current
                        let taskDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: task.dueDate.wrappedValue))
                        let currentDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date()))
                        
                        if (taskDate == currentDate) {
                            TaskView(task: task, vm: vm)
                        }

                    }
                    ForEach($ts.projects) { $project in
                        ForEach($project.sections) { $section in
                            ForEach($section.tasks) { task in
                                
                                let calendar = Calendar.current
                                let taskDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: task.dueDate.wrappedValue))
                                let currentDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date()))
                                                            
                                if(taskDate == currentDate) {
                                    TaskView(task: task, vm: vm)
                                }
                                
                            }
                        }
                    }
                    
                } header: {
                    
                    VStack {
                        Text("\(month) \(day) • Today • \(dayOfWeek)").font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                } .textCase(nil)
            }
            
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Text("**Inbox**").font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(ts: TodoistService())
    }
}
