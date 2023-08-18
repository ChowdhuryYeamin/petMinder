//
//  taskView.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/18/23.
//

import Foundation

extension Task {
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self.time ?? Date())
    }
}
