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
    var diaryText: String = ""
    
    init(timestamp: Date, diaryText: String) {
        self.timestamp = timestamp
        self.diaryText = diaryText
    }
}
