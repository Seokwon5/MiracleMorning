//
//  AlarmListCell.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/06/13.
//

import UIKit
import UserNotifications

class AlarmListCell: UITableViewCell {
    @IBOutlet weak var meridiumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func alarmSwitchValueChanged(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alarmList") as? Data,
              var alarmList = try? PropertyListDecoder().decode([Alarm].self, from: data) else {return}
        
        alarmList[sender.tag].isON = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alarmList), forKey: "alarmList")
        
        if sender.isOn {
            userNotificationCenter.addNotificationRequest(by: alarmList[sender.tag])
        } else {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alarmList[sender.tag].id])
        }
        
    }
    
}
