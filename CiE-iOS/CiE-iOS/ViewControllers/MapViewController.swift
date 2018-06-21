//
//  MapViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 12.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit
import MapKit

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
        
        
        
        let goToMap: (UIAlertAction) -> Void = {
            alert in
          
            if(self.lastTappedImage?.image == self.lothstr.image){
                let latitude: CLLocationDegrees = 48.154873
                let longitude: CLLocationDegrees = 11.556105
                
                let regionDistance: CLLocationDistance = 1000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                let placemark = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = "University Applied Sciences Munich - Lothstrasse"
                mapItem.openInMaps(launchOptions: options)
            }
            
            if(self.lastTappedImage?.image == self.karlstr.image){
                let latitude: CLLocationDegrees = 48.142714
                let longitude: CLLocationDegrees = 11.568329
                
                let regionDistance: CLLocationDistance = 1000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                let placemark = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = "University Applied Sciences Munich - Lothstrasse"
                mapItem.openInMaps(launchOptions: options)
            }
            
            if(self.lastTappedImage?.image == self.pasing.image){
                let latitude: CLLocationDegrees = 48.141586
                let longitude: CLLocationDegrees = 11.451114
                
                let regionDistance: CLLocationDistance = 1000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                let placemark = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = "University Applied Sciences Munich - Lothstrasse"
                mapItem.openInMaps(launchOptions: options)
            }
            
        
           
            
            
            print("NavigateWithMaps")
        }
        let fullscreen: (UIAlertAction) -> Void = {
            alert in
            
            let im = tapGestureRecognizer.view as! UIImageView
            let newImageView = UIImageView(image: self.lastTappedImage?.image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
            
            print("Tschau!")
        }

        //let weekdayLabel = UILabel()
        //weekdayLabel.frame = CGRect(x: 0, y: 15, width: 350, height: 350)
        //weekdayLabel.text = "Hier könnte ihr Bild stehen!"
        
        let picture = UIImageView(image: lastTappedImage?.image)
        picture.frame = CGRect(x: 15, y: 15, width: 240, height: 240)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        
        var height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.50)
        alertController.view.addConstraint(height);

        
        alertController.view.addSubview(picture)
        
        let okAction = UIAlertAction(title: "GoToMap", style: .default, handler: goToMap)
        let cancelAction = UIAlertAction(title: "no gresser", style: .default, handler: fullscreen)
        
        okAction.setValue(UIColor.green, forKey: "titleTextColor")
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion:{})
        
        
    }
    
   
    
    @objc
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer){
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}

