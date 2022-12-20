//
//  EventViewController.swift
//  CalendarPractice
//
//  Created by YUJIN KWON on 2022/12/19.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.date = selectedDate
    }
    
    @IBAction func save(_ sender: Any) {
        
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = nameTextField.text
        newEvent.date = datePicker.date
        
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
}
