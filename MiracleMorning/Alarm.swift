//
//  Alarm.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/06/13.
//

import Foundation

struct Alarm: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isON: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridium: String {
        let meridiumFormatter = DateFormatter()
        meridiumFormatter.dateFormat = "a"
        meridiumFormatter.locale = Locale(identifier: "ko")
        return meridiumFormatter.string(from: date)
    }
}
