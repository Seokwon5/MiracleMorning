//
//  AddAlarmViewController.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/06/16.
//

import UIKit

class AddAlarmViewController : UIViewController {
    //클로저로 전달
    var pickedDate:((_ date: Date) -> Void)?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func tapDismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)

    }
}
