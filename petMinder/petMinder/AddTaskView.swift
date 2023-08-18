//
//  AddTaskView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/18/23.
//

//  AddTaskView.swift

import SwiftUI
import CoreData

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    @ObservedObject var pet: Pet

    @State private var taskTitle: String = ""
    @State private var taskDetails: String = ""
    @State private var taskTime: Date = Date()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Task Title", text: $taskTitle)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                TextField("Task Details", text: $taskDetails)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                DatePicker("Time", selection: $taskTime, displayedComponents: .hourAndMinute)
                    .padding()

                Button("Save Task") {
                    let newTask = Task(context: viewContext)
                    newTask.title = taskTitle
                    newTask.details = taskDetails
                    newTask.time = taskTime
                    pet.addToTasks(newTask)
                    do {
                        try viewContext.save()
                    } catch {
                        print("Error saving task: \(error)")
                    }
                    self.presentationMode.wrappedValue.dismiss() // Dismiss the view
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationBarTitle("Add Task", displayMode: .inline)
            .navigationBarItems(leading:
                Button("Back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
