//
//  CoursesViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var lectures: [Lecture]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        updateLectureCatalog()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLectureCatalog()
    }
    
    private func updateLectureCatalog() {
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
    
}

