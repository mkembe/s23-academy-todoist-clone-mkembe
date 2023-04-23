//
//  AddTaskToInboxView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/11/23.
//

import SwiftUI

struct AddTaskToInboxView: View {
    
    @ObservedObject var vm: HomeViewViewModel
    @ObservedObject var ts: TodoistService
    @State var dateShowingSheet = false
    @State var date: Date? = nil
    @State var update = Date()
    
    var body: some View {
        VStack {
            TextField("Task Name", text: $vm.name)
                .font(.title2)
                .bold()
                .padding(.leading, 12)
                .padding(.top, 30)
            TextField("Description", text: $vm.description)
                .padding(.leading, 12)
                .padding(.bottom, 40)

            HStack {
                Button {
                    dateShowingSheet.toggle()
                    
                } label: {
                    HStack {
                        Image(systemName: "sidebar.squares.left")
                        //update to show the current due date (after adding no date functionality this should have an if statement to show if there is a date or not)
                        if(date == nil) {
                            Text("**No date**")
                        } else {
                            Text("\(date!)")

                        }                    }
                }
                .sheet(isPresented: $dateShowingSheet) {
                    VStack {
                        HStack{
                            Button() {
                                dateShowingSheet.toggle()
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            }
                            .padding(.leading, 15)
                            Spacer()
                            Text("**Schedule**")
                                .padding(.trailing, 15)
                            Spacer()
                            Button() {
                                date = update
                                dateShowingSheet.toggle()
                            } label: {
                                Text("Save")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 15)
                        }
                        .padding(.top, 30)
                        
                        
                        
                    }
                    
                    DatePicker("Date", selection: $update, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Text("\(update)")
                    Spacer()
                    
                    


                    
                }
                .foregroundColor(.black)
                .padding(.leading, 12)
                Spacer()
  
            }
            .padding(.bottom, 10)

            HStack {
                Spacer()
                Button () {
                    
                    if(date == nil) {
                        ts.inboxTasks.append(Task(name: vm.name, isCompleted: false, description: vm.description))
                        print("thing with empty date was added")
                    } else {
                        ts.inboxTasks.append(Task(name: vm.name, isCompleted: false, description: vm.description, dueDate: date))
                        print("thing with nonempty date was dded")
                    }
 


                    vm.showingSheet.toggle()
                    vm.name = ""
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing, 15)

            }
            
            Spacer()
            
        }

    }
}

struct AddTaskToInboxView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskToInboxView(vm: HomeViewViewModel(), ts: TodoistService())
    }
}
