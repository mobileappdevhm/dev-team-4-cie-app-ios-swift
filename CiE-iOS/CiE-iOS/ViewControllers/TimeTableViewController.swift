//
//  TimeTableViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit
import Foundation

class TimeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateField: UIButton!
    @IBOutlet weak var timetableTableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    private var currentDate: Date? {
        didSet{
            dateField.setTitle(dateFormatter.string(from: picker.date), for: .normal)
            updateLecturesFiltered()
            timetableTableView.reloadData()
        }
    }
    
    let picker = UIDatePicker()
    private var lectures: [Lecture]? {
        didSet{
            updateLecturesFiltered()
        }
    }
    private var filteredLectures: [(Lecture,LectureDate)] = []
    
    //MARK - protocol functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLectures.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableCell") as! TimetableCell
        return cell.map(to: filteredLectures[indexPath.row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
        setUpBinding()
        currentDate = Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lectures = UserStatsService.getCurrentLectures()
        timetableTableView.reloadData()
    }
    
    private func setUpStyling() {
        dayLabel.text = "Timetable"
        timetableTableView.allowsSelection = false
    }
    //date selection feature
    private func setUpBinding() {
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        dateField.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        lectures = FavouriteService.currentFavourites()
    }
    
    @objc
    func showDatePicker() {
        let setDate: (UIAlertAction) -> Void = {
            alert in
                self.currentDate = self.picker.date
        }
        // setting properties of the datePicker
        picker.datePickerMode = .date
        picker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(picker)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: setDate)
        okAction.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(okAction)
        present(alertController, animated: true, completion:{})
    }
    
    private func updateLecturesFiltered() {
        var orderedFilteredAppointments: [(Lecture,LectureDate)] = []
        var filteredDictionary: Dictionary<Date,(Lecture,LectureDate)> = [:]
        _ = lectures?.filter({ (lecture) -> Bool in
            lecture.lectureDates.contains(where: { (date) -> Bool in
                let components = Calendar.current.dateComponents([.day], from: date.date, to: self.picker.date)
                let sameDay = components.day ?? 1 == 0
                if sameDay { filteredDictionary[date.date] = (lecture,date) }
                return sameDay
            })
        })
        let orderedKeys = filteredDictionary.keys.sorted(by: { (first, second) -> Bool in
            let get: (Calendar.Component, Date) -> Int = { targetField,date in
                return Calendar.current.component(targetField, from: date)
            }
            switch (get(.hour, first),get(.hour, second)) {
            case (let x,let y) where x == y :
                return get(.minute, first) < get(.minute, second)
            case (let x,let y):
                return x < y
            }
        })
        for key in orderedKeys {
            if let appointment = filteredDictionary[key] {
                orderedFilteredAppointments.append(appointment)
            }
        }
        filteredLectures = orderedFilteredAppointments
    }
    //check date entered
    func isWeekday(today: String){
        if today.range(of: "Monday") != nil {
            print("exist!")
        }
    }

}
