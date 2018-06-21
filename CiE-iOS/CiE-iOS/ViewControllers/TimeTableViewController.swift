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
    
    @IBOutlet weak var dateField: UITextField!
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
            dateField.text = dateFormatter.string(from: picker.date)
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
        createDatePicker()
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        lectures = FavouriteService.currentFavourites()
        picker.date = NSDate() as Date
        dayLabel.text = "Timetable"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lectures = UserStatsService.getCurrentLectures()
        timetableTableView.reloadData()
    }
    
    //date selection feature
    func createDatePicker(){
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
        
        //format picker for date
        picker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        currentDate = picker.date
        self.view.endEditing(true)
    }
    
    private func updateLecturesFiltered() {
        var filteredAppointments: [(Lecture,LectureDate)] = []
        _ = lectures?.filter({ (lecture) -> Bool in
            lecture.lectureDates.contains(where: { (date) -> Bool in
                let components = Calendar.current.dateComponents([.day], from: date.date, to: self.picker.date)
                let sameDay = components.day ?? 1 == 0
                if sameDay { filteredAppointments.append((lecture,date)) }
                return sameDay
            })
        })
        filteredLectures = filteredAppointments
    }
    //check date entered
    func isWeekday(today: String){
        if today.range(of: "Monday") != nil {
            print("exist!")
        }
    }

}
