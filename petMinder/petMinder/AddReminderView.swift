import SwiftUI
import CoreData

struct AddReminderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    @ObservedObject var pet: Pet

    @State private var reminderTitle: String = ""
    @State private var reminderDetails: String = ""
    @State private var reminderDate: Date = Date()
    @State private var reminderIsCompleted: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminder Title")) {
                    TextField("Enter Title", text: $reminderTitle)
                }

                Section(header: Text("Reminder Details")) {
                    TextField("Enter Details", text: $reminderDetails)
                }

                Section(header: Text("Reminder Date")) {
                    DatePicker("Select Date", selection: $reminderDate)
                }

                Section(header: Text("Is Completed?")) {
                    Toggle("Completed", isOn: $reminderIsCompleted)
                }

                Section {
                    Button("Save Reminder") {
                        let newReminder = Reminder(context: viewContext)
                        newReminder.title = reminderTitle
                        newReminder.details = reminderDetails
                        newReminder.date = reminderDate
                        newReminder.isCompleted = reminderIsCompleted
                        pet.addToReminders(newReminder)
                        do {
                            try viewContext.save()
                            self.presentationMode.wrappedValue.dismiss() // Dismiss the view
                        } catch {
                            // Handle error
                            print("Error saving reminder: \(error)")
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .navigationBarTitle("Add Reminder")
            .navigationBarItems(leading:
                Button("Back") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
