//
//  TaskInfoView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/15/23.
//

import SwiftUI

struct InboxTaskInfoView: View {
    
    @Binding var task: Task
    @State var isShowing = false
    @ObservedObject var vm: InboxVM
    @State var changeDateShowing = false
    @State var date: Date? = nil
    @State var update = Date()

    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        vm.showingSheet.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                            .frame(width: 23, height: 23)
                    }


                }
                .padding(.top, 15)
                .padding(.trailing, 16)
                .padding(.bottom, 10)
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
                                Button {
                                    isShowing.toggle()
                                } label:
                                {
                                    Text("Cancel")
                                        .foregroundColor(.blue)
                                        .padding(.leading, 8)
                                }


                                Spacer()
                                Text("Edit Task").bold()
                                Spacer()
                                Button {
                                    isShowing.toggle()
                                } label: {
                                    Text("Save").bold()
                                        .foregroundColor(.blue)
                                        .padding(.trailing, 8)
                                }

                

                            }
                            .padding(.bottom, 10)
                            HStack {
                                Image(systemName: "circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                TextField("\(task.name)", text: $task.name)
                                    .font(.title)
                            }
                            .padding(.leading, 15)
    
                            
                            HStack {
                                Image(systemName: "text.alignleft")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 14, height: 14)
                            
                                TextField("\(task.description ?? "Description")", text: $task.description.toUnwrapped(defaultValue: ""))

                            }
                            .padding(.leading, 15)
                            Spacer()
                        }
                        .presentationDetents([.fraction(0.75)])
                        .padding(.top, 30)

                    }
                    .presentationDetents([.fraction(0.25)])
                    Spacer()
                    
                }
                .padding(.leading, 10)
                .padding(.bottom, 15)
                
                Button {
                    changeDateShowing.toggle()
                } label: {
                    HStack {
                        Image(systemName: "sidebar.squares.left")
                            .foregroundColor(.green)
                        if(task.dueDate != nil) {
                            Text("\(task.dueDate ?? Date())")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                        } else {
                            Text("Select a Date")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                        }

                        Spacer()
                    }
                }
                .sheet(isPresented: $changeDateShowing) {
                    VStack {
                        HStack{
                            Button() {
                                changeDateShowing.toggle()
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
                                task.dueDate = date
                                changeDateShowing.toggle()
                            } label: {
                                Text("Save")
                                    .foregroundColor(.blue)
                            }
                            .padding(.trailing, 15)
                        }
                        .padding(.top, 30)
                        
                        DatePicker("Date", selection: $update, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                        Text("\(update)")
                        
                        Spacer()
                        
                        
                        
                    }



                }
                .padding(.leading, 10)

            }

            Spacer()
        }
    }
    

}

struct InboxTaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        InboxTaskInfoView(task: .constant(Task(name: "", isCompleted: false)), vm: InboxVM())
    }
}
