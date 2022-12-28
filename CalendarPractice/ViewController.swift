//
//  ViewController.swift
//  CalendarPractice
//
//  Created by YUJIN KWON on 2022/12/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    
    var totalSquares = [CalendarDay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 40
        addButton.clipsToBounds = true
        setCellsView()
        setMonthView()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        let previousMonth = CalendarHelper().minusMonth(date: selectedDate)
        let daysInPrevMonth = CalendarHelper().daysInMonth(date: previousMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            let calendarDay = CalendarDay()
            if count <= startingSpaces {
                let previousMonthDay = daysInPrevMonth - startingSpaces + count
                calendarDay.day = String(previousMonthDay)
                calendarDay.month = CalendarDay.Month.previous
            } else if count - startingSpaces > daysInMonth {
                calendarDay.day = String(count - daysInMonth - startingSpaces)
                calendarDay.month = CalendarDay.Month.next
            } else {
                calendarDay.day = String(count - startingSpaces)
                calendarDay.month = CalendarDay.Month.current
            }
            totalSquares.append(calendarDay)
            count += 1
        }
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        collectionView.reloadData()
    }

    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMonthView()
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        let calendarDay = totalSquares[indexPath.item]
        cell.dayOfMonth.text = calendarDay.day
        if calendarDay.month == CalendarDay.Month.current {
            cell.dayOfMonth.textColor = UIColor.black
        } else {
            cell.dayOfMonth.textColor = UIColor.gray
        }
        
        return cell
    }
    
    
}

