//
//  PetDetailView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import SwiftUI

struct PetDetailView: View {
    @Binding var pet: Pet // Notice the use of @Binding here

    var body: some View {
        Text("Meet \(pet.name)!")
        // You can add more details here related to the pet.
    }
}

struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePet = Pet(name: "Fido")
        return PetDetailView(pet: .constant(samplePet)) // Using .constant for previewing with a binding
    }
}


