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
    
    //protocol functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetables.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableCell") as? TimetableCell else
        { return UITableViewCell() }
        cell.courseLabel.text = timetables[indexPath.row].course
        cell.timeLabel.text = timetables[indexPath.row].time
        cell.roomLabel.text = timetables[indexPath.row].room
        cell.campusLabel.text = timetables[indexPath.row].campus
        
        return cell
    }
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var timetableTableView: UITableView!
    
    let picker = UIDatePicker()
    final let url = URL(string: "https://api.myjson.com/bins/m1zpy")
    private var timetables = [Timetable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        downloadJSON()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //format date
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: picker.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    //sort date entered
  
    
    //download data from json
    func downloadJSON(){
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else
            {
                return
            }
            do{
                let decoder = JSONDecoder()
                let downloadtimetables = try decoder.decode(Timetables.self, from: data)
                self.timetables = downloadtimetables.timetables
                DispatchQueue.main.async {
                    self.timetableTableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
}

}
