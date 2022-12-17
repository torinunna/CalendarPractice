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
    
    var selectedDate = Date()
    var totalSquare = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

    @IBAction func previousMonth(_ sender: Any) {
    }
    
    @IBAction func nextMonth(_ sender: Any) {
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquare.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        cell.monthLabel.text = totalSquare[indexPath.item]
        
        return cell
    }
    
    
}

