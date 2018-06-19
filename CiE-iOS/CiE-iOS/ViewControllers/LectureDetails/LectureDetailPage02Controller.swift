//
//  LectureDetailPage02Controller.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 19.06.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import Foundation

import UIKit

class LectureDetailPage02Controller: UIViewController{
    
    @IBOutlet weak var departmentLabl: UILabel!
    @IBOutlet weak var profLabl: UILabel!
    var model: LectureDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
    }
    
    private func setUpStyling() {
        guard let model = model else { return }
        profLabl.text = model.lecture.professor.name
        departmentLabl.text = model.lecture.connectedDepartments.isEmpty ? Department.Undefined.getString() : model.lecture.connectedDepartments[0].getString()
    }
}
