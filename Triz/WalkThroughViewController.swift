//
//  WalkthroughPageViewController.swift
//  ThinkPure1
//
//  Created by Udbhav Anand on 13/06/16.
//  Copyright © 2016 ThinkTankers. All rights reserved.
//

import UIKit

class WalkThroughViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    
    //var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["intro1", "intro2", "intro3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source to itself
        dataSource = self
        // Create the first walkthrough screen
        if let startingViewController = viewControllerAtIndex(index: 0) {
            setViewControllers([startingViewController], direction: .forward,
                               animated: true, completion: nil)
        }
    }
    
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerBefore viewController: UIViewController) ->
//        UIViewController? {
//            var index = (viewController as! FirstViewController).index
//            index += 1
//            return viewControllerAtIndex(index: index)
//    }
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerAfter viewController: UIViewController) ->
//        UIViewController? {
//            var index = (viewController as! FirstViewController).index
//            index -= 1
//            return viewControllerAtIndex(index: index)
//    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewControllerIndex = (viewController as! FirstViewController).index
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        if pageImages.count > previousIndex
        {
        
        }else {
            return nil
        }
        
        return viewControllerAtIndex(index : previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
       let viewControllerIndex = (viewController as! FirstViewController).index
    
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pageImages.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return viewControllerAtIndex(index : nextIndex)
    }
    func viewControllerAtIndex(index: Int) -> FirstViewController? {
        if index == NSNotFound || index < 0 || index >= pageImages.count {
            print("no use")
            
            return nil
        }
        // Create a new view controller and pass suitable data.
        else{
        if let pageContentViewController =
            storyboard?.instantiateViewController(withIdentifier: "FirstViewController")
                as? FirstViewController {
            pageContentViewController.imageFile = pageImages[index]
            //pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.index = index
            print("used")
            return pageContentViewController
            
            
        }
            print("no use")
            return nil
        }
       
    }
    func forward(index:Int) {
        if let nextViewController = viewControllerAtIndex(index: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated:
                true, completion: nil)
        }
    }
    /*  func presentationCountForPageViewController(pageViewController:
     UIPageViewController) -> Int {
     return pageHeadings.count
     }
     func presentationIndexForPageViewController(pageViewController:
     UIPageViewController) -> Int {
     if let pageContentViewController =
     storyboard?.instantiateViewControllerWithIdentifier("FirstViewController")
     as? FirstViewController {
     return pageContentViewController.index
     }
     return 0
     }*/
}
