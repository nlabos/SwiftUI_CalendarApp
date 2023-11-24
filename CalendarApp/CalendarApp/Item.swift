//
//  Item.swift
//  CalendarApp
//
//  Created by 高橋直希 on 2023/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
