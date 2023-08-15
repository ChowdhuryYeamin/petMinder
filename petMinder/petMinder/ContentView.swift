//
//  ContentView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var pets: [Pet] = [] // Array of pets
    @State private var showingAddPetModal = false // To show the add pet modal
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Pet Reminder") // Welcome Note
                List {
                    ForEach(pets, id: \.self) { pet in
                        NavigationLink(destination: PetDetailView(pet: pet)) {
                            Text(pet.name ?? "Unnamed Pet") // Provides a default value if the name is nil
                        }
                    }

                }
                HStack {
                    Button("Add Pet") {
                        showingAddPetModal = true
                    }
                    .sheet(isPresented: $showingAddPetModal) {
                        AddPetView()
                    }
                    Button("Delete Pet") {
                        // Add delete pet functionality if needed
                    }
                }
            }
        }
    }
}


