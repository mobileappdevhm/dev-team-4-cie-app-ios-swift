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
    public private(set) var maps: Set<UIImageView> = []
    
    @IBOutlet weak var lothstr: UIImageView!
    @IBOutlet weak var karlstr: UIImageView!
    @IBOutlet weak var pasing: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillMaps()
        setUpStyling()
        setUpBinding()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpStyling() {
        for image in maps {
            dropShadow(on: image)
        }
    }
    
    private func setUpBinding() {
        for image in maps {
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(imageTapped(tapGestureRecognizer:))
            ))
        }
    }
    
    private func fillMaps() {
        guard let lothstr = lothstr, let karlstr = karlstr, let pasing = pasing else { return }
        maps.update(with: lothstr)
        maps.update(with: karlstr)
        maps.update(with: pasing)
    }
    
    private func dropShadow(on picture: UIImageView) {
        picture.layer.shadowOffset = CGSize(width: 0, height: 3)
        picture.layer.shadowOpacity = 0.8
        picture.layer.shadowRadius = 3.0
        picture.layer.shadowColor = UIColor.black.cgColor
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        guard let viewTapped = tapGestureRecognizer.view else { return }
        guard let imageTapped = viewTapped as? UIImageView else { return }
        lastTappedImage = imageTapped
        print("Tapped on \(imageTapped).")
    }
    
}

