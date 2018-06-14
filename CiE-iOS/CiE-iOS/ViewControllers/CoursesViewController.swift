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

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = UISearchController(searchResultsController: nil)
       
        updateLectureCatalog()
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
        guard lectures == nil else { return }
        lectures = [
            Lecture(withTitle: "Mobile Anwendungen",
                    withDescription: nil,
                    heldBy: Professor(withName: "Socher")),
            Lecture(withTitle: "Funktionale Programmierung",
                    withDescription: nil,
                    heldBy: Professor(withName: "Heinz")),
            Lecture(withTitle: "Business English",
                    withDescription: nil,
                    heldBy: Professor(withName: "Becker")),
            Lecture(withTitle: "Politische Ereignisse der Vergangenheit",
                    withDescription: nil,
                    heldBy: Professor(withName: "Cho")),
            Lecture(withTitle: "CiE Super Lecture",
                    withDescription: nil,
                    heldBy: Professor(withName: "Kubayashi")),
            Lecture(withTitle: "German Economics 101",
                    withDescription: nil,
                    heldBy: Professor(withName: "Kunze"))
        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectures?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lectures = lectures else { return }
        let storyboard = UIStoryboard(name: "LectureDetail", bundle: Bundle.main)
        let detailView: LectureDetailViewController = (storyboard.instantiateViewController(withIdentifier: "detail")) as! LectureDetailViewController
        detailView.setLecture(to: lectures[indexPath.row])
        navigationController?.show(detailView,sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell") as! LectureTableViewCell
        guard let lectures = lectures else {
            return cell.map(to: Lecture(withTitle: "Dummy",
                                        withDescription: nil,
                                        heldBy: Professor(withName: "Dummy Prof")))
        }
        return cell.map(to: lectures[indexPath.row])
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredlectures = lectures!.filter({(lecture:LectureTableViewCell) -> Bool in
        return lecture.titleLabel.lowercased().contains(searchText.lowercased())
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
