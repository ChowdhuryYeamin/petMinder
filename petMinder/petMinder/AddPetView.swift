import SwiftUI
import CoreData

struct AddPetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var age: String = ""
    @State private var notes: String = ""

    var body: some View {
        VStack {
            TextField("Enter pet name", text: $name)
                .padding()
            TextField("Enter pet age", text: $age)
                .padding()
            TextField("Enter pet notes", text: $notes)
                .padding()

            Button("Add Pet") {
                let newPet = Pet(context: viewContext)
                newPet.name = name
                newPet.age = age
                newPet.notes = notes

                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }

                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}
