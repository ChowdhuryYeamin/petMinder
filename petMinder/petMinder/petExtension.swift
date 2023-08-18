//
//  taskExtension.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/16/23.
//

import CoreData

extension Pet {
    var tasksArray: [Task] {
        let set = task as? Set<Task> ?? []
        return set.sorted {
            $0.title ?? "" < $1.title ?? ""
        }
    }

    public func addToTasks(_ task: Task) {
        self.willChangeValue(forKey: "task")
        let mutable = self.mutableSetValue(forKey: "task")
        mutable.add(task)
        self.didChangeValue(forKey: "task")
    }

    var remindersArray: [Reminder] {
        let set = reminder as? Set<Reminder> ?? []
        return set.sorted {
            $0.date ?? Date() < $1.date ?? Date()
        }
    }

    public func addToReminders(_ reminder: Reminder) {
        self.willChangeValue(forKey: "reminder")
        let mutable = self.mutableSetValue(forKey: "reminder")
        mutable.add(reminder)
        self.didChangeValue(forKey: "reminder")
    }
}
