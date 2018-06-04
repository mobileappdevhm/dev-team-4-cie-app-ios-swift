//
//  LectureDetailPageViewController.swift
//  CiE-iOS
//
//  Created by Nikita Hans on 30.05.18.
//  Copyright © 2018 Nikita Hans. All rights reserved.
//

import UIKit

class LectureDetailPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "lectureDetailPage01")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "lectureDetailPage02")
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "lectureDetailPage03")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?  {
        let currentIndex = pages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }

    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
