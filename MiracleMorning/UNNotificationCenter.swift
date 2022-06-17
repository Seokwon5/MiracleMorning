//
//  UNNotificationCenter.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/06/17.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequest(by alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "아침임."
        content.body = "일어나셈."
        content.sound = .default
        content.badge = 1
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: alarm.isON)
        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
