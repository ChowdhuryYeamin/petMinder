import SwiftUI
import CoreData

struct AddPetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var age: String = ""
    @State private var notes: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter pet name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                TextField("Enter pet age", text: $age)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                TextField("Enter pet notes", text: $notes)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                Button("Add Pet") {
                    let newPet = Pet(context: viewContext)
                    newPet.name = name
                    newPet.age = age
                    newPet.notes = notes
                    // Saving logic
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationBarTitle("Add Pet", displayMode: .inline)
            .navigationBarItems(leading:
                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
