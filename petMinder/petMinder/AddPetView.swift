//
//  AddPetView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import SwiftUI

struct AddPetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var pets: [Pet]
    @State private var petName = ""
    
    var body: some View {
        VStack {
            TextField("Enter pet name", text: $petName)
                .padding()
            Button("Add Pet") {
                let newPet = Pet(name: petName)
                pets.append(newPet)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}
