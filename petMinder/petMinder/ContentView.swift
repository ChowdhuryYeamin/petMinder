//
//  ContentView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import SwiftUI

struct PetCell: View {
    let pet: Pet
    var isSelected: Bool

    var body: some View {
        HStack {
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }

            // Rounded image
            Image(systemName: "photo")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            Divider()
            Divider()

            // Separated name
            Text(pet.name ?? "Unnamed Pet")
                .font(.system(size: 16))
                .padding(.trailing, 10)
                .background(Color.clear)
        }
        .background(Color.clear)
        .padding(10)
    }
}


struct ContentView: View {
    @State private var selectedPets: Set<Pet> = []
    @FetchRequest(
        entity: Pet.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Pet.name, ascending: true)]
    ) private var pets: FetchedResults<Pet>
    @State private var showingAddPetModal = false // To show the add pet modal
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Pet Reminder") // Welcome Note
                List {
                    ForEach(pets, id: \.self) { pet in
                        HStack {
                            Button(action: {
                                if selectedPets.contains(pet) {
                                    selectedPets.remove(pet)
                                } else {
                                    selectedPets.insert(pet)
                                }
                            }) {
                                Image(systemName: selectedPets.contains(pet) ? "checkmark.circle.fill" : "circle")
                            }

                            NavigationLink(destination: PetDetailView(pet: pet)) {
                                PetCell(pet: pet, isSelected: selectedPets.contains(pet))
                            }
                        }
                    }
                    .onDelete(perform: deletePet) // Swipe-to-delete functionality
                }
                HStack {
                    Button("Add Pet") {
                        showingAddPetModal = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .sheet(isPresented: $showingAddPetModal) {
                        AddPetView()
                    }
                    
                    Button("Delete Selected Pets") {
                        withAnimation {
                            let context = PersistenceController.shared.container.viewContext
                            selectedPets.forEach { pet in
                                context.delete(pet)
                            }
                            do {
                                try context.save() // Save the context
                            } catch {
                                // Handle the error appropriately
                            }
                            selectedPets.removeAll() // Clear the selection
                        }
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
    
    private func deletePet(at offsets: IndexSet) {
        for index in offsets {
            let pet = pets[index]
            let context = PersistenceController.shared.container.viewContext
            context.delete(pet)
        }
        do {
            try PersistenceController.shared.container.viewContext.save() // Save the context
        } catch {
            // Handle the error appropriately
        }
    }
}
