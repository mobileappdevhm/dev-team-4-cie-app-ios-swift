//
//  CoursesViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class CoursesViewController: UITableViewController, MyTableCellDelegate {

    struct MyData {
        var fLabel:String
        var tLabel:String
    }
    
    var tableData: [MyData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = [MyData(fLabel: "FK07", tLabel: "10:00")]
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a new cell with the reuse identifier of our prototype cell
        // as our custom table cell class
        let cell = tableView.dequeueReusableCell(withIdentifier: "myProtoCell", for: indexPath) as! MyTableCell
        // Set the first row text label to the firstRowLabel data in our current array item
        cell.facultyLabel.text = tableData[indexPath.row].fLabel
        // Set the second row text label to the secondRowLabel data in our current array item
        cell.timeLabel.text = tableData[indexPath.row].tLabel
        //cell.facultyLabel.text = "This is cell number \(indexPath.row)"
        
        //cell.detailsButton.addTarget(self, action: #selector(CoursesViewController.detailsTapped(_:)), for: .touchUpInside)
        //cell.favoritesButton.addTarget(self, action: #selector(CoursesViewController.favoritesTapped(_:)), for: .touchUpInside)
        cell.delegate = self
        // Return our new cell for display
        return cell
        
    }
    
    func MyTableCellDidTapDetails(_ sender: MyTableCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("Details", sender, tappedIndexPath)
        //items[tappedIndexPath.row].love()
    }
    
    func MyTableCellDidTapFavorites(_ sender: MyTableCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        print("Details", sender, tappedIndexPath)
        //items[tappedIndexPath.row].love()
    }
    
    @objc func detailsTapped(_ sender: Any?) {
        // We need to call the "love" method on the underlying object, but I don't know which row the user tapped!
        // The sender is the button itself, not the table view cell. One way to get the index path would be to ascend
        // the view hierarchy until we find the UITableviewCell instance.
        print("Details Tapped", sender!)
    }

    @objc func favoritesTapped(_ sender: Any?) {
        print("Favorites Tapped", sender!)
    }
    

    
    
    

}

