//
//  Home View.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI



struct Home_View: View {
    
    init() {
      let coloredAppearance = UINavigationBarAppearance()
      coloredAppearance.configureWithOpaqueBackground()
      coloredAppearance.backgroundColor = .systemCyan
      coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      
      UINavigationBar.appearance().standardAppearance = coloredAppearance
      UINavigationBar.appearance().compactAppearance = coloredAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      
      UINavigationBar.appearance().tintColor = .white
    }
    
    @StateObject var vm = HomeViewViewModel()
    @StateObject var ts = TodoistService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        HStack {
                            Image(systemName: "tray.fill")
                                .foregroundColor(.blue)
                            NavigationLink {
                                InboxView(ts: ts, vm: vm)
                            } label: {
                                Text("Inbox")
                        }
                        }
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(.green)
                                .frame(width: 20, height: 20)
                            NavigationLink {
                                TodayView(ts: ts)
                            } label: {
                                Text("Today")
                            }
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.purple)
                            NavigationLink {
                                UpcomingView(ts: ts)
                            } label: {
                                Text("Upcoming")
                            }
                        }
                    }
                    Section {
                        ForEach($ts.projects) { $project in
                            NavigationLink {
                                ProjectView(ts: ts, project: $project)
                            } label: {
                                Text("\(project.name)")
                            }
                        }
                        Button() {
                            vm.manageProjectsShowingSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "pencil")
                                    .foregroundColor(.gray)
                                Text("Manage Projects")
                                    .foregroundColor(.black)
                            }
                        }
                        .sheet(isPresented: $vm.manageProjectsShowingSheet) {
                            
                            ManageProjectsView(ts: ts, hvvm: vm)

                        }
                    } header: {
                        HStack {
                            Text("**Projects**").font(.headline).foregroundColor(.black)
                            Spacer()
                            Button() {
                                vm.showingSheet.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray)
                                    .frame(width: 15, height: 15)
                            }
                            .sheet(isPresented: $vm.showingSheet) {
                                AddProjectView(ts: ts, hvvm: vm)
                                
                            }
                        }
                    }
                    .textCase(nil)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem{
                        HStack() {
                            Image(systemName: "chart.pie")
                                .foregroundColor(.white)
                            Text("4/5")
                                .fixedSize(horizontal: true, vertical: true)
                                .foregroundColor(.white)
                                .padding(.trailing, 185)

                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            Image(systemName: "bell.badge")
                                .foregroundColor(.white)
                            Image(systemName: "gearshape")
                                .foregroundColor(.white)
                            
                        }
                    }
                }
                VStack {
                    Spacer()
                    Button() {
                        vm.inboxAdd.toggle()
                    }  label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.cyan)
                            .scaledToFill()
                            .frame(width: 40, height: 40)

                    }
                    
                    .padding(.leading, 300)
                    .sheet(isPresented: $vm.inboxAdd) {
                        AddTaskToInboxView(vm: vm, ts: ts)
                            .presentationDetents([.fraction(0.25)])

                    }
                }
            }
        }
    }
}

struct Home_View_Previews: PreviewProvider {
    static var previews: some View {
        Home_View()
    }
}
