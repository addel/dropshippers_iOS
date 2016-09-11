//
//  LoginViewController.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 15/08/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit
import SwiftyJSON
import Locksmith

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var monCompteLabel: UILabel!
    
    @IBOutlet weak var noAccountButton: UIButton!
    @IBOutlet weak var forgotPass: UIButton!
    
    @IBOutlet var socialButton: [UIButton]!
    
    var user: User!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // ici on deplace les element sur leur point de départ pour l'animation
        monCompteLabel.center.y -= view.bounds.width
        loginTextField.center.x -= view.bounds.width
        forgotPass.center.x -= view.bounds.width
        passwordTextField.center.x += view.bounds.width
        noAccountButton.center.x += view.bounds.width
        
        // on les fait apparaitres
        monCompteLabel.hidden = false
        loginTextField.hidden = false
        forgotPass.hidden = false
        passwordTextField.hidden = false
        noAccountButton.hidden = false
        connectionButton.hidden = false
        
        connectionButton.alpha = 0.0
        
        // show time !!!
        UIView.animateWithDuration(2.0, animations: {
            self.monCompteLabel.center.y += self.view.bounds.width
        })
        
        UIView.animateWithDuration(1.5, delay: 0.5,
                                   usingSpringWithDamping: 0.3,
                                   initialSpringVelocity: 0.5,
                                   options: [], animations: {
                                    
                                    self.loginTextField.center.x += self.view.bounds.width
                                    self.passwordTextField.center.x -= self.view.bounds.width
                                    self.noAccountButton.center.x -= self.view.bounds.width
                                    self.forgotPass.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 2.0,
                                   options: [],
                                   animations: {
                                    self.connectionButton.alpha = 1.0
                                    for item in self.socialButton{
                                        item.alpha = 1.0
                                    }
        }, completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: User Interaction
    
    @IBAction func closeViewButton(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func connectionButton(sender: AnyObject) {
        let username: String = loginTextField.text!
        let password: String = passwordTextField.text!
        
        if (username.isEmpty || password.isEmpty) {
            let alertView = UIAlertController(title: "Erreur de connexion",
                                              message: "Veuillez vérifier vos IDs." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Allez cette fois c'est la bonne !!!", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }else{
            
            postToSignin([username, password])
            
        }
        
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func socialButton(sender: AnyObject) {
        let notDoneAlert = UIAlertController(title: "Non disponible", message: "En cours de développement", preferredStyle: .Alert)
        notDoneAlert.addAction(UIAlertAction(title: "OKAYYYY", style: .Cancel, handler: nil))
        presentViewController(notDoneAlert, animated: true, completion: nil)
    }

    // MARK: Layout
    
    // MARK: Additional Helpers

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true;
    }
}

// MARK: route function

extension LoginViewController{
    
    
    func postToSignin(params: [String]) {
        RestApiManager.sharedInstance.postToSignin(params, onCompletion: { (json: JSON) in
            print(json)
            if json["code"] != 1000{
                
                let apiErrorAlert = UIAlertController(title: json["code"].stringValue, message: json["message"].stringValue, preferredStyle: .Alert)
                apiErrorAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(apiErrorAlert, animated: true, completion: nil)
                
            }else{
                
                do
                {
                    try Locksmith.saveData(["token": json["token"].stringValue], forUserAccount: "userAccount")
                    self.view.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)

                    
                }
                catch 
                {
                    print("probleme with fucking Locksminth: \(error)")
                }
            }
        
        })
    }
}
