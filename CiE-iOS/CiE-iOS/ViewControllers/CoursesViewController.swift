//
//  CoursesViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lectures: [Lecture]?
    var filteredlectures = [Lecture]()
    private var isFiltering:Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private var searchBarIsEmpty:Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = UISearchController(searchResultsController: nil)
       
        //updateLectureCatalog()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Courses"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLectureCatalog()
        tableView.reloadData()
    }
    
    
    private func updateLectureCatalog() {
        lectures = LectureCatalogService.getLectures(withUpdate: true) //Update manuell verfügbar?
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredlectures.count : lectures?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lectures = lectures else { return }
        let storyboard = UIStoryboard(name: "LectureDetail", bundle: Bundle.main)
        let detailView: LectureDetailViewController = (storyboard.instantiateViewController(withIdentifier: "detail")) as! LectureDetailViewController
        detailView.setLecture(to: isFiltering ? filteredlectures[indexPath.row] : lectures[indexPath.row] )
        navigationController?.show(detailView,sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell") as! LectureTableViewCell
        guard let lectures = lectures else {
            return cell.map(to: Lecture(withTitle: "Dummy",
                                        withDescription: nil,
                                        heldBy: Professor(withName: "Dummy Prof")))
        }
        
        cell.map(to: isFiltering ? filteredlectures[indexPath.row] : lectures[indexPath.row])
        return cell
        
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let contains: (String) -> Bool = { subject in
            return subject.lowercased().contains(searchText.lowercased())
        }
        filteredlectures = lectures!.filter({(lecture:Lecture) -> Bool in
            let titleMatch = contains(lecture.title)
            var departmentMatch: Bool = false
            for department in lecture.connectedDepartments {
                if contains(department.getString()) {
                    departmentMatch = true
                    break
                }
            }
            let professorMatch = contains(lecture.professor.name)
            var roomMatch: Bool = false
            for lectureDate in lecture.lectureDates {
                if contains(lectureDate.room.getNameRepresentation()) {
                    roomMatch = true
                    break
                }
            }
            return titleMatch || professorMatch || departmentMatch || roomMatch
        })
        tableView.reloadData()
    }
}

extension CoursesViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
