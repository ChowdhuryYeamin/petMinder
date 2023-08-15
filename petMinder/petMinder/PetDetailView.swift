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
    @ObservedObject var pet: Pet // Using ObservedObject to work with Core Data

    var body: some View {
        VStack {
            Text("Meet \(pet.name ?? "Unknown")!") // Handling optional unwrapping
            Text("Age: \(pet.age ?? "N/A")")
            Text("Notes: \(pet.notes ?? "N/A")")
            // You can add more details here related to the pet.
        }
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



