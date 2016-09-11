//
//  LoginViewController.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 12/08/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit

class HomeLoginViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    @IBOutlet weak var bird1: UIImageView!
    @IBOutlet weak var bird2: UIImageView!
    @IBOutlet weak var bird3: UIImageView!
    
    @IBOutlet weak var paraBox: UIImageView!
    @IBOutlet weak var droppingBox: UIImageView!

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidAppear(animated: Bool) {

        titleLabel.center.y -= view.bounds.width * 1.4
        subTitleLabel.center.y -= view.bounds.width * 1.4
        droppingBox.center.y -= view.bounds.width * 1.4
        paraBox.center.y -= view.bounds.width * 2
        paraBox.center.x -= view.bounds.height * 2
        
        self.bird1.image = UIImage(named: "beachBirdDown")
        
        UIView.animateWithDuration(5.0, animations: {
            
            // unhidde
            self.titleLabel.hidden = false
            self.subTitleLabel.hidden = false
            self.droppingBox.hidden = false
            self.paraBox.hidden = false
            
            // move
            self.titleLabel.center.y += self.view.bounds.width * 1.4
            self.subTitleLabel.center.y += self.view.bounds.width * 1.4
            self.droppingBox.center.y += self.view.bounds.width * 1.4
            self.paraBox.center.y += self.view.bounds.width * 2
            self.paraBox.center.x += self.view.bounds.height * 2
            
            
        })
    
        UIView.animateWithDuration(0.5, delay: 0.6, options: [], animations: {
            self.cloud1.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.8, options: [], animations: {
            self.cloud2.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations: {
            self.cloud3.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 1.2, options: [], animations: {
            self.cloud4.alpha = 1.0
            }, completion: nil)
        
        animateTheClouds(cloud1)
        animateTheClouds(cloud2)
        animateTheClouds(cloud3)
        animateTheClouds(cloud4)
        
        animateFuckingBird(bird1)
        animateFuckingBird(bird2)
        animateFuckingBird(bird3)
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
    
    // MARK: User Interaction
    
    @IBAction func loginButton(sender: UIButton) {

       

    }
    
    // MARK: Layout
    
    
    
    
}

// MARK: Additional Helpers
extension HomeLoginViewController{
    
    func animateTheClouds(cloud : UIImageView) {
        
        let cloudMovingSpeed = 60.0/view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudMovingSpeed
        
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
            }, completion: {_ in
                
                cloud.frame.origin.x = -cloud.frame.size.width
                self.animateTheClouds(cloud)
        })
    }
    
    func animateFuckingBird(bird: UIImageView){
        
        bird.animationImages = [
            UIImage(named: "beachBirdDown")!,
            UIImage(named: "beachBird")!
        ]
        
        bird.animationDuration = 0.5
        bird.animationRepeatCount = 0
        bird.startAnimating()
        
    }
}
