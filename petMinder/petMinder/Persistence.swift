//  Persistence.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/15/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newPet = Pet(context: viewContext)
            newPet.name = "Pet \(i)"
            newPet.age = "2"
            newPet.notes = "Notes for pet \(i)."
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)") // Avoid fatalError in production
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "petMinder")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // You may want to replace fatalError with more user-friendly error handling.
                print("Unresolved error \(error), \(error.userInfo)") // Avoid fatalError in production
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
