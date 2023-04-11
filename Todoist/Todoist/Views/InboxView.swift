//
//  InboxView.swift
//  Todoist
//
//  Created by Millie Kembe on 4/10/23.
//

import SwiftUI

struct InboxView: View {
    
    @ObservedObject var ps: ProjectService
    @ObservedObject var vm: HomeViewViewModel
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical) {
                    ForEach(ps.taskLibrary) { task in
                        if(!task.existsInProject) {
                            Text("\(task.name)")
                        }
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
                        .scaledToFill()
                        .frame(width: 40, height: 40)

                }
                
                .padding(.leading, 300)
                .sheet(isPresented: $vm.inboxAdd) {
                    AddTaskToInboxView(vm: vm, ps: ps)
                }
            }
        }
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(ps: ProjectService(), vm: HomeViewViewModel())
    }
}
