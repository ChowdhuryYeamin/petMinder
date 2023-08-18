//
//  reminderVIew.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/18/23.
//

import Foundation

extension Reminder {
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // You can change this to .short, .long, or .full as per your requirements
        formatter.timeStyle = .short
        return formatter.string(from: self.date ?? Date())
    }
}

