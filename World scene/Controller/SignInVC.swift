//
//  SignInVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class SignInVC: UIViewController{
    
    
    //MARK:- variables
    
    //MARK:-  outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordSignIn: UITextField!
    @IBOutlet weak var emailSignIn: UITextField!
    @IBOutlet weak var errorMsgLbl: UILabel!
    
    
    //MARK:- Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        isLoggedIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }

    //MARK:-   Actions and functions
    
    func isLoggedIn() {
       if UserDefaults.standard.bool(forKey:"isSignedIn")==true  {
       let mainTab = self.storyboard?.instantiateViewController(identifier: "MainTabBar") as! MainTabBar
                      mainTab.modalPresentationStyle = .fullScreen
                      mainTab.modalTransitionStyle = .flipHorizontal
                      mainTab.selectedViewController = mainTab.viewControllers?[1]
                      self.present(mainTab,animated: false,completion: nil)
           }
       }
    
    func setupScene() {
        view.bindToKeyboard()
        hideKeyboardWhenTappedAround()
        emailSignIn.delegate = self
        passwordSignIn.delegate = self
        styleLogineScene(Email: emailSignIn, password: passwordSignIn, signInButton: signInButton, signUpButton: signUpButton)
        if UserDefaults.standard.bool(forKey:"isSignedIn")==true {
            let mainTab = self.storyboard?.instantiateViewController(identifier: "MainTabBar") as! MainTabBar
            mainTab.modalPresentationStyle = .fullScreen
            mainTab.modalTransitionStyle = .flipHorizontal
            mainTab.selectedViewController = mainTab.viewControllers?[1]
            self.present(mainTab,animated: false,completion: nil)
        }
    }
    func styleLogineScene(Email:UITextField,password:UITextField,signInButton:UIButton,signUpButton:UIButton) {
        Styles.styleFilledButton(button: signUpButton)
        Styles.styleFilledButton(button: signInButton)
        Styles.styleTextField(textField: Email)
        Styles.styleTextField(textField: password)
    }
    
    @IBAction func signInTapped(_ sender: Any)  {
        guard let email=emailSignIn.text, let password=passwordSignIn.text else { return }
        guard email != "" && password != ""
            else { self.errorMsgLbl.text=SigninError.emptyField.errorDescription ; return  }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else { self.errorMsgLbl.text=error?.localizedDescription ; return }
            
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            
            let mainTab = self.storyboard?.instantiateViewController(identifier: "MainTabBar") as! MainTabBar
            mainTab.modalPresentationStyle = .fullScreen
            mainTab.modalTransitionStyle = .flipHorizontal
            mainTab.selectedViewController = mainTab.viewControllers?[0]
            self.present(mainTab,animated: true,completion: nil)
        }
    }
    
    @IBAction func gotoSignUp(_ sender: UIButton)  {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else { return }
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .flipHorizontal
        self.present(signUpVC,animated: true,completion: nil)
    }
}
extension SignInVC: UITextFieldDelegate {
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
  }
}
