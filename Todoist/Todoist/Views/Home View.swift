//
//  Home View.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct Home_View: View {
    
    @StateObject var vm = HomeViewViewModel()
    @StateObject var ps = ProjectService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        HStack {
                            Image(systemName: "tray.fill")
                                .foregroundColor(.blue)
                            NavigationLink {
                                InboxView(ps: ps, vm: vm)
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
                            Text("Today")
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.purple)
                            Text("Upcoming")
                        }
                    }
                    Section {
                        ForEach(ps.projectLibrary) { project in
                            NavigationLink {
                                ProjectView(ps: ps, project: $ps.projectLibrary[ps.projectLibrary.firstIndex(where: {$0.id == project.id} ) ?? 0])
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
                            
                            ManageProjectsView(ps: ps, hvvm: vm)

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
                                AddProjectView(ps: ps, hvvm: vm)
                                
                            }
                        }
                    }
                    .textCase(nil)
                }
                VStack {
                    Spacer()
                    Button() {
                        vm.inboxAdd.toggle()
                    }  label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)

                    }
                    
                    .padding(.leading, 300)
                    .sheet(isPresented: $vm.inboxAdd) {
                        AddTaskToInboxView(vm: vm, ps: ps)
                            .presentationDetents([.fraction(0.15)])

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
