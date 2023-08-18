//
//  dateExtension.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/18/23.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
