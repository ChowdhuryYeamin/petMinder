//
//  PetDetailView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import SwiftUI
import CoreData

struct PetDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var pet: Pet
    @State private var showingAddTaskModal: Bool = false
    @State private var showingAddReminderModal: Bool = false
    @State private var selectedDate: Date = Date() // Selected date
    
    var filteredReminders: [Reminder] {
        return pet.remindersArray.filter { reminder in
            let reminderDate = reminder.date ?? Date()
            return reminderDate.formattedDate == selectedDate.formattedDate
        }
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) { // Spacing between sections
                sectionCard {
                    VStack {
                        Text("Meet \(pet.name ?? "Unknown")!").font(.largeTitle)
                        Image(systemName: "heart.fill").foregroundColor(.pink) // Example icon
                    }
                }
                
                // Pet Age and Notes
                sectionCard {
                    VStack(alignment: .leading) {
                        customSubheader(text: "About")
                        HStack {
                            Image(systemName: "calendar")
                            Text("Age: \(pet.age ?? "N/A")")
                        }
                        HStack {
                            Image(systemName: "pencil")
                            Text("Notes: \(pet.notes ?? "N/A")")
                        }
                        .padding(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligns content to the leading edge with a fixed width
                }



                
                sectionCard {
                    VStack(alignment: .leading) {
                        customSubheader(text: "Daily Task")
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green) // Example icon for tasks
                        ForEach(pet.tasksArray, id: \.self) { task in
                            HStack {
                                Image(systemName: "checkmark.circle") // Placeholder for task icon, you can replace with actual icons
                                    .foregroundColor(Color.green)
                                    .font(.title)
                                VStack(alignment: .leading) {
                                    Text(task.title ?? "")
                                        .font(.headline)
                                    Text(task.details ?? "")
                                    Text("Time: \(task.formattedTime)") // Assuming you have a formattedTime computed property
                                }
                                Spacer() // Pushes the content to the left
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button("Add Task") {
                            showingAddTaskModal = true
                        }
                        .sheet(isPresented: $showingAddTaskModal) {
                            AddTaskView(pet: pet)
                        }
                    }
                }
                
                sectionCard {
                    VStack(alignment: .leading) {
                        customSubheader(text: "Upcoming Reminders")
                        Image(systemName: "bell.fill").foregroundColor(.yellow) // Example icon for reminders
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle()) // Modern calendar style
                        ForEach(filteredReminders, id: \.self) { reminder in
                            HStack {
                                Toggle("", isOn: Binding<Bool>(
                                    get: { reminder.isCompleted },
                                    set: { newValue in
                                        reminder.isCompleted = newValue
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            // Handle error
                                            print("Error updating reminder: \(error)")
                                        }
                                    })
                                )
                                .toggleStyle(CheckboxToggleStyle())
                                VStack(alignment: .leading) {
                                    Text(reminder.title ?? "")
                                        .font(.headline)
                                    Text(reminder.details ?? "")
                                    Text("Date: \(reminder.dateFormatted)")
                                }
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                        }
                        Button("Add Reminder") {
                            showingAddReminderModal = true
                        }
                        .sheet(isPresented: $showingAddReminderModal) {
                            AddReminderView(pet: pet)
                        }
                    }
                }
            }
            .padding() // Padding around the entire content
        }
    }
    
    // Custom subheader view
    private func customSubheader(text: String) -> some View {
        Text(text)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .padding([.top, .leading])
            .background(Color.clear)
    }
    
    // Card view for sections
    private func sectionCard<Content: View>(content: @escaping () -> Content) -> some View {
        VStack {
            content()
        }
        .padding() // Padding around the entire section
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1))) // Card appearance
        .shadow(radius: 5) // Shadow effect
    }
}


struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Creating a preview with a sample Pet entity
        let samplePet = Pet(context: PersistenceController.preview.container.viewContext)
        samplePet.name = "Fido"
        samplePet.age = "3"
        samplePet.notes = "Friendly dog"

        return PetDetailView(pet: samplePet)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            .foregroundColor(configuration.isOn ? .green : .gray)
            .onTapGesture {
                configuration.isOn.toggle()
            }
    }
}



//struct AddTaskView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @ObservedObject var pet: Pet
//
//    @State private var taskTitle: String = ""
//    @State private var taskDetails: String = ""
//    @State private var taskTime: Date = Date()
//
//    var body: some View {
//        VStack {
//            TextField("Task Title", text: $taskTitle)
//            TextField("Task Details", text: $taskDetails)
//            DatePicker("Time", selection: $taskTime, displayedComponents: .hourAndMinute)
//            Button("Save Task") {
//                let newTask = Task(context: viewContext)
//                newTask.title = taskTitle
//                newTask.details = taskDetails
//                newTask.time = taskTime
//                pet.addToTasks(newTask) // Make sure that this method is available in the Pet class
//                do {
//                    try viewContext.save()
//                } catch {
//                    // Handle error
//                    print("Error saving task: \(error)")
//                }
//            }
//        }
//    }
//}
