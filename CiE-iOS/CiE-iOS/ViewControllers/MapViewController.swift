//
//  MapViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    public private(set) var lastTappedImage: UIImageView?
    
    @IBOutlet weak var lothstr: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        lothstr.isUserInteractionEnabled = true
        lothstr.addGestureRecognizer(tapGestureRecognizer)
        dropShadow(on: lothstr)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func dropShadow(on picture: UIImageView) {
        picture.layer.shadowOffset = CGSize(width: 0, height: 3)
        picture.layer.shadowOpacity = 0.8
        picture.layer.shadowRadius = 3.0
        picture.layer.shadowColor = UIColor.black.cgColor
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        lastTappedImage = tapGestureRecognizer.view as? UIImageView
        print("Tapped on Lothstr.")
    }
    
    
}

