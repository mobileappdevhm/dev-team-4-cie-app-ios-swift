//
//  FavoritesViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var submitStackView: UIStackView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var detailsSwitch: UISwitch!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var ectsProgress: UIProgressView!
    @IBOutlet weak var ectsLabel: UILabel!
    @IBOutlet weak var cieLabel: UILabel!
    @IBOutlet weak var cieProgress: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    
    private var favourites:[Lecture]?
    private var model: FavoritesViewModelProtocol?
    private let warningText = "Time conflicts detected!"
    private let amountNeededForCertificate:Int = 7
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = FavoritesViewModel()
        setUpStyling()
        setUpBinding()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favourites = FavouriteService.currentFavourites()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = favourites?.count ?? 0
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.width))
        emptyLabel.text = "Currently you do not have any favourites."
        emptyLabel.textAlignment = NSTextAlignment.center
        tableView.backgroundView = emptyLabel
        emptyLabel.isHidden = count != 0
        tableView.separatorStyle = emptyLabel.isHidden ? .singleLine : .none
        return count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let favourites = favourites else { return }
            FavouriteService.remove(favourites[indexPath.row])
            self.favourites = FavouriteService.currentFavourites()
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let favourites = favourites else { return }
        let storyboard = UIStoryboard(name: "LectureDetail", bundle: Bundle.main)
        let detailView: LectureDetailViewController = (storyboard.instantiateViewController(withIdentifier: "detail")) as! LectureDetailViewController
        detailView.setLecture(to: favourites[indexPath.row])
        navigationController?.show(detailView,sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteLectureCell") as! FavouriteLectureCell
        guard let favourites = favourites else {
            return cell.map(to: Lecture(withTitle: "Dummy",
                                        withDescription: nil,
                                        heldBy: Professor(withName: "Dummy Prof")))
        }
        return cell.map(to: favourites[indexPath.row])
    }
    

    private func setUpStyling() {
        submitButton.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.lightGray.cgColor
        
        warningLabel.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        
        detailsSwitch.setOn(false, animated: false)
        detailsStackView.isHidden = true
        
        warningLabel.text = warningText
        warningLabel.isHidden = true
        
        pinBackground(backgroundView, to: submitStackView)
        updateUserStats()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        model?.update()
        setUpStyling()
    }
    
    private func setUpBinding() {
        submitButton.addTarget(self, action: #selector(confirmTapped), for: UIControlEvents.touchUpInside)
        detailsSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func updateUserStats() {
        guard let model = model else { return }
        let ects = model.impact.ects
        ectsLabel.text = "Your ECTS raise by \(ects)"
        ectsProgress.setProgress(Float(ects)/10, animated: (ects != 0))
        
        let cie = model.impact.cie
        cieLabel.text = "Your CiE raise by \(cie)"
        cieProgress.setProgress(Float(cie)/Float(amountNeededForCertificate), animated: (cie != 0))
        
    }
    
    @objc
    func switchChanged(sender: UISwitch!) {
        UIView.animate(withDuration: 0.2) {
            self.detailsStackView.isHidden = !sender.isOn
            self.warningLabel.isHidden = !sender.isOn
            if sender.isOn { self.updateUserStats() }
        }
    }
    
    @objc
    func confirmTapped() {
        addFavourtiesToSemesterWithAlert()
    }
    
    func showInfo(titled title: String, saying message: String) {
        let myAlertController = AlertService.showInfo(titled: title, message: message)
        self.present(myAlertController, animated: true, completion: nil)
    }
    
    func addFavourtiesToSemesterWithAlert() {
        guard let favourites = model?.favourites, !favourites.isEmpty else {
            showInfo(titled: "Nothing here.", saying: "You need to add some favourites first.")
            return
        }
        guard let needsAlert = model?.hasConflicts else { return }
        let submit: (UIAlertAction) -> Void = { UIAlertAction -> Void in
            self.confirmedSubmit()
        }
        let cancel: (UIAlertAction) -> Void = { UIAlertAction -> Void in
            self.showInfo(titled: "Aborted!", saying: "You did NOT submit your favourites.")
        }
        if needsAlert {
            let conflictDescription = model?.conflictForAlert?.alertDescription() ?? ConflictIndicator.generalDescription(.other)
            let myAlertController = AlertService.showConfirmAlert(
                titled: "Conflict!",
                withSubtitle: "\(conflictDescription) Are you sure you want to submit your selection?",
                onCancel: cancel,
                onConfirm: submit
            )
            self.present(myAlertController, animated: true, completion: nil)
        } else {
            let myAlertController = AlertService.showConfirmAlert(
                titled: "Confirm!",
                withSubtitle: "Please confirm that you want to enroll in these courses.",
                onCancel: cancel,
                onConfirm: submit
            )
            self.present(myAlertController, animated: true, completion: nil)
        }
    }
    
    func confirmedSubmit() {
        guard let model = self.model else { return }
        model.addFavourites()
        model.clearFavourites()
        model.update()
        updateUserStats()
        present(AlertService.showInfo(titled: "Success!", message: "Your favourites have been added."), animated: true, completion: nil)
        favourites = FavouriteService.currentFavourites()
        tableView.reloadData()
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        pin(view: stackView, to: view)
    }
    
    private func pin(view: UIView,to source: UIView) {
        NSLayoutConstraint.activate([
            source.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            source.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            source.topAnchor.constraint(equalTo: view.topAnchor),
            source.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

