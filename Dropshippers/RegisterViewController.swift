//
//  RegisterViewViewController.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 29/08/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailConfirmTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Variable de class
    
    
    @IBOutlet weak var inscriptionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Users Action
    
    @IBAction func inscriptionButton(sender: AnyObject) {
    }
    
    @IBAction func exitButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func socialButton(sender: AnyObject) {
        displayError("Non disponible", text: "En cours de développement")
        
    }

    @IBAction func haveAlreadyAccountButton(sender: AnyObject) {
        displayError("Non disponible", text: "En cours de développement")
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        emailConfirmTextField.resignFirstResponder()
        passwordConfirmTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true;
    }
    
    // MARK: helper
    
    func displayError(titre: String, text: String) {
        let notDoneAlert = UIAlertController(title: titre, message: text, preferredStyle: .Alert)
        notDoneAlert.addAction(UIAlertAction(title: "OKAYYYY", style: .Cancel, handler: nil))
        presentViewController(notDoneAlert, animated: true, completion: nil)
    }

}
