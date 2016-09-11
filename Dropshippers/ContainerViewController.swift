//
//  ContainerViewController.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 02/09/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit

enum SlideOutState {
    case BothCollapsed
    case LeftMenu
    case RightMenu
}


class ContainerViewController: UIViewController {

    var mainNavigationController: UINavigationController!
    var mainViewController: MainViewController!
    
    // properties for sideMenu
    // property for sideMenu state Both a sideMenu is not activated so by default .BothCollapsed
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForViewController(shouldShowShadow)
        }
    }
    
    // sideMenu left and right
    var sideMenuController: SideMenuViewController?
    // bon le nom parle de lui meme ok
    let mainViewExpandedOffset: CGFloat = 60
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewController = UIStoryboard.mainViewController()
        mainViewController.delegate = self
        
        // wrap the mainViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        view.addSubview(mainNavigationController.view)
        addChildViewController(mainNavigationController)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture(_:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: Additional Helpers

extension ContainerViewController{
    func addChildSideMenuController(sideMenuController: SideMenuViewController) {
        
        view.insertSubview(sideMenuController.view, atIndex: 0)
        
        addChildViewController(sideMenuController)
        sideMenuController.didMoveToParentViewController(self)
    }
    
    func addMenuViewController(sideToShow: SlideOutState) {
        
        if (sideMenuController == nil) {
            sideMenuController = UIStoryboard.sideViewController(sideToShow)
            
            addChildSideMenuController(sideMenuController!)
        }
    }
    
    func animateMenu(shouldExpand: Bool, sideToShow: SlideOutState) {
        
        if (shouldExpand) {
            
            currentState = sideToShow
            
            let xPositionMainView = (sideToShow == .LeftMenu) ? CGRectGetWidth(self.mainNavigationController.view.frame) - self.mainViewExpandedOffset : -CGRectGetWidth(self.mainNavigationController.view.frame) + self.mainViewExpandedOffset
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.mainNavigationController.view.frame.origin.x = xPositionMainView
                }, completion: nil)
            
        } else {
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
                self.mainNavigationController.view.frame.origin.x = 0
                }, completion: { finished in
                    
                    self.currentState = .BothCollapsed
                    
                    self.sideMenuController!.view.removeFromSuperview()
                    self.sideMenuController = nil;
            })
        }
    }
    
    func showShadowForViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            mainNavigationController.view.layer.shadowOpacity = 1
        } else {
            mainNavigationController.view.layer.shadowOpacity = 0
        }
    }

}


// MARK: MainViewController delegate

extension ContainerViewController: MainViewControllerDelegate {
    
    func toggleMenu(sideMenuToShow: SlideOutState) {
        
        var notAlreadyExpanded: Bool?
        
        if (sideMenuToShow == .LeftMenu){
            notAlreadyExpanded = (currentState != .LeftMenu)
        }
        else if (sideMenuToShow == .RightMenu){
            notAlreadyExpanded = (currentState != .RightMenu)
        }
        
        if (notAlreadyExpanded != nil) || (notAlreadyExpanded)! {
            addMenuViewController(sideMenuToShow)
        }
        
        animateMenu(notAlreadyExpanded!, sideToShow: sideMenuToShow)
        
        
    }
    
    func  collapseSideMenus() {
        switch (currentState) {
        case .RightMenu:
            toggleMenu(.RightMenu)
        case .LeftMenu:
            toggleMenu(.LeftMenu)
        default:
            break
        }
    }
    
}

// MARK: Gesture recognizer

extension ContainerViewController: UIGestureRecognizerDelegate {
    
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case .Began:
            if (currentState == .BothCollapsed) {
                if (gestureIsDraggingFromLeftToRight) {
                    addMenuViewController(.LeftMenu)
                } else {
                    addMenuViewController(.RightMenu)
                }
                
                showShadowForViewController(true)
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if (sideMenuController != nil){
                if (gestureIsDraggingFromLeftToRight) {
                    let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                    animateMenu(hasMovedGreaterThanHalfway, sideToShow: .LeftMenu)
                } else {
                    let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
                    animateMenu(hasMovedGreaterThanHalfway, sideToShow: .RightMenu)
                }
                
            }
        default:
            break
        }
    }
    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func sideViewController(side: SlideOutState) -> SideMenuViewController? {
        return (side == .LeftMenu) ?mainStoryboard().instantiateViewControllerWithIdentifier("leftMenuViewController") as? SideMenuViewController : mainStoryboard().instantiateViewControllerWithIdentifier("rightMenuViewController") as? SideMenuViewController

    }
    
    class func mainViewController() -> MainViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController
    }
    
}
