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
                    ForEach(pets.indices, id: \.self) { index in
                        NavigationLink(destination: PetDetailView(pet: $pets[index])) {
                            Text(pets[index].name)
                        }
                    }
                }
                HStack {
                    Button("Add Pet") {
                        showingAddPetModal = true
                    }
                    .sheet(isPresented: $showingAddPetModal) {
                        AddPetView(pets: $pets)
                    }
                    Button("Delete Pet") {
                        // Add delete pet functionality if needed
                    }
                }
            }
        }
    }
}

struct Pet {
    var name: String
}
