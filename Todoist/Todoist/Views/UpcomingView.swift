//
//  UpcomingView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/22/23.
//

import SwiftUI

struct UpcomingView: View {
    
    @ObservedObject var ts: TodoistService
    @StateObject var vm = TaskViewViewModel()
    @StateObject var vm2 = HomeViewViewModel()
    
    let calendar = Calendar.current
    let startDate = Date()
    let endDate = Date().addingTimeInterval(7 * 24 * 60 * 60)
    
    
    var body: some View {
        ZStack {
            TabView() {
                ForEach(getNextSevenDays(), id: \.self) { date in
                        
                    Lists(ts: ts, vm: vm, date: .constant(date))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Text("**Upcoming**").font(.title2)
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
    
    func getNextSevenDays() -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
}

struct Lists: View {
    
    @ObservedObject var ts: TodoistService
    @ObservedObject var vm: TaskViewViewModel
    @Binding var date: Date
    
    var month: String {
        let date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        return monthString
    }
    
    var day: Int {
        let date = date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day
        return dayOfMonth!
    }
    
    var dayOfWeek: String {
        let date = date
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
                        let taskDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: task.dueDate.wrappedValue ?? Date()))
                        let currentDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date))
                        if (taskDate == currentDate) {
                            
                            TV(vm: vm, task: task)
                            
                            
                        }
                        
                    }
                    ForEach($ts.projects) { $project in
                        ForEach($project.sections) { $section in
                            ForEach($section.tasks) { task in
                                
                                let calendar = Calendar.current
                                let taskDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: task.dueDate.wrappedValue ?? Date()))
                                let currentDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date))
                                
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
                        Text("\(month) \(day) • \(dayOfWeek)").font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                    }
                    .padding(.leading, -20)
                    .padding(.bottom, 15)
                    
                    
                } .textCase(nil)
            }
        }
    }
    
    
    
    struct UpcomingView_Previews: PreviewProvider {
        static var previews: some View {
            UpcomingView(ts: TodoistService())
        }
    }
}
