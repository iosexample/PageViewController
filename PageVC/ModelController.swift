//
//  ModelController.swift
//  PageVC
//
//  Created by dong on 2017/12/7.
//  Copyright © 2017年 dong. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

//    var pageData: [String] = []
    var pageViewControllers: [UIViewController] = []

    override init() {
        super.init()
        // Create the data model.
//        let dateFormatter = DateFormatter()
//        pageData = dateFormatter.monthSymbols
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> UIViewController? {
        // Return the data view controller for the given index.
        if (index >= 3) {
            return nil
        }

        var viewController: UIViewController?
        
        if index >= pageViewControllers.count {
            if index == 0 {
                // Create a new view controller and pass suitable data.
                viewController = storyboard.instantiateViewController(withIdentifier: "DataViewController")
//                viewController.dataObject = "First"//self.pageData[index]
            }
            else if index == 1 {
                viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
            }
            else if index == 2 {
                viewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
            }
        }
        else {
            return pageViewControllers[index]
        }
        
        pageViewControllers.append(viewController!)
        return viewController
    }

    func indexOfViewController(_ viewController: UIViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageViewControllers.index(of: viewController) ?? NSNotFound
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
    
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

