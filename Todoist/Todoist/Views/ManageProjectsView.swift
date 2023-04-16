//
//  ManageProjectsView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct ManageProjectsView: View {
    
    @ObservedObject var ts: TodoistService
    @ObservedObject var hvvm: HomeViewViewModel
    @State var selOption = "Active"
    @State var options = ["Active", "Archived"]
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    ForEach(ts.projects) { project in
                            NavigationLink {
                            } label: {
                                Text("\(project.name)")
                                
                        }
                                        }
                }
                
            }
            .toolbar {
                ToolbarItemGroup {
                    VStack {
                        HStack() {
                            Button("Cancel") {
                                hvvm.manageProjectsShowingSheet.toggle()
                            }
                            
                            Spacer(minLength: 100)
                            
                            Text("**Projects**")
                                .fixedSize(horizontal: true, vertical: true)
                            
                            Spacer(minLength: 130)
                            
                            
                            Button() {
                                hvvm.showingSheet.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.blue)
                                    .frame(width: 15, height: 15)
                            }
                            .sheet(isPresented: $hvvm.showingSheet) {
                                AddProjectView(ts: ts, hvvm: hvvm)
                            }
                            
                        }
                        .padding(.top, 30)
                        VStack {
                            Picker("Color Scheme", selection: $selOption) {
                                ForEach(options, id: \.self) {
                                    Text($0)
                                }

                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                }
            }
        }
    }
    
    struct ManageProjectsView_Previews: PreviewProvider {
        static var previews: some View {
            ManageProjectsView(ts: TodoistService(), hvvm: HomeViewViewModel())
        }
    }
}
