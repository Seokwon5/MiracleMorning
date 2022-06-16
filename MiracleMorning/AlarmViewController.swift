//
//  AlarmViewController.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/06/13.
//

import UIKit

class AlarmViewController: UITableViewController{
    var alarmList: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlarmListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlarmListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alarmList = alarms()
    }
    
    @IBAction func addAlarmButton(_ sender: UIBarButtonItem) {
        guard let addAlarmVC = storyboard?.instantiateViewController(withIdentifier: "AddAlarmViewController") as? AddAlarmViewController else { return }
        
        addAlarmVC.pickedDate = {[weak self] date in
            guard let self = self else {return}

            var alarms = self.alarms()
            let newAlram = Alarm(date: date, isON: true)
            
            alarms.append(newAlram)
            alarms.sort{ $0.date < $1.date }
            
            self.alarmList = alarms
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alarmList), forKey: "alarmList")
            
            self.tableView.reloadData()
        }
        self.present(addAlarmVC, animated: true, completion: nil)
    }
    
    //앱을 껐다가 켜도 저장되어 있도록.
    func alarms() -> [Alarm] { //Alarm객체의 데이터를 내뱉음.
        //userDefaults에서 키가 alarmList인 객체를 내뱉음.
        guard let data = UserDefaults.standard.value(forKey: "alarmList") as? Data,
              let alarmList = try? PropertyListDecoder().decode([Alarm].self, from: data) else {return []}
        return alarmList
    }
    
}

//UITableView DataSource, Delegate
extension AlarmViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "기상 시간"
        default:
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmListCell", for: indexPath) as? AlarmListCell else { return UITableViewCell() }
        
        cell.alarmSwitch.isOn = alarmList[indexPath.row].isON
        cell.timeLabel.text = alarmList[indexPath.row].time
        cell.meridiumLabel.text = alarmList[indexPath.row].meridium
        
        cell.alarmSwitch.tag = indexPath.row
        
        return cell
    }
    
    //cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.alarmList.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alarmList), forKey: "alarmList")
            self.tableView.reloadData()
            return
        default:
            break
        }
    }
}
