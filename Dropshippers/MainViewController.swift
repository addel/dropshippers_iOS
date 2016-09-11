//
//  MainViewController.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 02/09/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit
import Locksmith

protocol MainViewControllerDelegate {
    
    // side Menu
    func toggleMenu(sideMenuToShow: SlideOutState)
    func collapseSideMenus()
}


class MainViewController: UIViewController {
    
    // delegate properties
    var delegate: MainViewControllerDelegate?
    
    
    // MARK: CycleLife
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // probleme sur les color des images qui ne ressorte pas, on a du donc le faire en programmatique
        navigationItem.leftBarButtonItem?.image = UIImage(named: "userNavBar")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.rightBarButtonItem?.image = UIImage(named: "shopNavBar")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //let dictionary = Locksmith.loadDataForUserAccount("userAccount")
        
        //guard dictionary != nil else{
            return self.performSegueWithIdentifier("loginSegue", sender: self)
        //}
    }
    
    // MARK: User Action
 
    @IBAction func leftMenuAction(sender: AnyObject) {
        delegate?.toggleMenu(SlideOutState.LeftMenu)
    }
 
    @IBAction func rightMenuAction(sender: AnyObject) {
        delegate?.toggleMenu(SlideOutState.RightMenu)
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
