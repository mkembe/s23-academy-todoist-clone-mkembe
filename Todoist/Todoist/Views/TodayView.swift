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
    @StateObject var vm2 = HomeViewViewModel()
    
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
            
            ZStack {
                List {
                    Section {
                        ForEach($ts.inboxTasks) { task in
                            
                            let calendar = Calendar.current
                            let taskDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: task.dueDate.wrappedValue ?? Date()))
                            let currentDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date()))
                            if (taskDate == currentDate) {
                                
                                TV(vm: vm, task: task)
                                
                                
                            }
                            
                        }
                        ForEach($ts.projects) { $project in
                            ForEach($project.sections) { $section in
                                ForEach($section.tasks) { task in
                                    
                                    let calendar = Calendar.current
                                    let taskDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: task.dueDate.wrappedValue ?? Date()))
                                    let currentDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date()))
                                    
                                    if(taskDate == currentDate) {
                                        
                                        
                                        HStack {
                                            
                                            TV(vm: vm, task: task)
                                            
                                            
                                        }
                                        
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
                            .padding(.leading, -20)
                            .padding(.bottom, 15)
                            
                        } .textCase(nil)
                        
                        
                    }
                    .toolbar {
                        ToolbarItem {
                            HStack {
                                Text("**Today**").font(.title2)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                }
                VStack {
                    Spacer()
                    Button() {
                        vm2.inboxAdd.toggle()
                    }  label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.cyan)
                            .scaledToFill()
                            .frame(width: 40, height: 40)

                    }
                    
                    .padding(.leading, 300)
                    .sheet(isPresented: $vm2.inboxAdd) {
                        AddTaskToInboxView(vm: vm2, ts: ts)
                            .presentationDetents([.fraction(0.25)])

                    }
                }
            }
            }
        }
    }
        
        struct TV: View {
            
            @ObservedObject var vm: TaskViewViewModel
            @Binding var task: Task
            
            var body: some View {
                if(task.isCompleted == false) {
                    HStack {
                        Button {
                            task.isCompleted.toggle()
                        } label: {
                            Image(systemName: "circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                        }
                        .buttonStyle(.borderless)

                        Button {
                            vm.showingSheet.toggle()
                        } label: {
                            Text("\(task.name)").foregroundColor(.black)
                                .padding(.bottom, 15)
                            
                            
                        }
                        .buttonStyle(.borderless)
                        .sheet(isPresented: $vm.showingSheet) {
                            TaskInfoView(task: $task, vm: vm)
                                .presentationDetents([.fraction(0.75)])
                            
                        }
                        .padding(.top)
                        
                        
                        Spacer()
                        
                        
                        
                        
                        
                        
                    }
                }
            }
            
        }
        
        struct TodayView_Previews: PreviewProvider {
            static var previews: some View {
                TodayView(ts: TodoistService())
            }
        }

