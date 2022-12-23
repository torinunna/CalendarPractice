//
//  DailyViewController.swift
//  CalendarPractice
//
//  Created by YUJIN KWON on 2022/12/21.
//

import UIKit

class DailyViewController: UIViewController {
 
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var hours = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTime()
        setDayView()
    }
    
    @IBAction func previousDay(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -1)
        setDayView()
    }
    
    @IBAction func nextDay(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 1)
        setDayView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDayView()
    }
    
    func initTime() {
        for hour in 0...23 {
            hours.append(hour)
        }
    }
    
    func setDayView() {
        dayLabel.text = CalendarHelper().monthDayString(date: selectedDate)
        dayOfWeekLabel.text = CalendarHelper().weekDayAsString(date: selectedDate)
        tableView.reloadData()
    }
    
    func formatHour(hour: Int) -> String {
        return String(format: "%02d:%02d", hour, 0)
    }
    
    func setEvents(_ cell: DailyCell, _ events: [Event]) {
        hideAll(cell)
        switch events.count {
        case 1:
            setEvent1(cell, events[0])
        case 2:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
        case 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setEvent3(cell, events[2])
        case let count where count > 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setMoreEvents(cell, events.count - 2)
        default:
            break
        }
    }
    
    func setEvent1(_ cell: DailyCell, _ event: Event) {
        cell.event1Label.isHidden = false
        cell.event1Label.text = event.name
    }
    
    func setEvent2(_ cell: DailyCell, _ event: Event) {
        cell.event2Label.isHidden = false
        cell.event2Label.text = event.name
    }
    
    func setEvent3(_ cell: DailyCell, _ event: Event) {
        cell.event3Label.isHidden = false
        cell.event3Label.text = event.name
    }
    
    func setMoreEvents(_ cell: DailyCell, _ count: Int) {
        cell.event3Label.isHidden = false
        cell.event3Label.text = String(count) + " More Events "
    }
    
    func hideAll(_ cell: DailyCell) {
        cell.event1Label.isHidden = true
        cell.event2Label.isHidden = true
        cell.event3Label.isHidden = true
    }
    
}

extension DailyViewController: UITableViewDelegate {
    
}

extension DailyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell") as! DailyCell
        let hour = hours[indexPath.row]
        cell.timeLabel.text = formatHour(hour: hour)
        let events = Event().eventsForDateAndtime(date: selectedDate, hour: hour)
        setEvents(cell, events)
        return cell
    }

    
    
}
