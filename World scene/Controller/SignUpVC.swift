//
//  SignUp.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    //MARK:-Outlets-
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet var errorMessageLbl: UILabel!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    //    MARK:- Lifecycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        setupScene()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- Actions and functions
    func isLoggedIn() {
        if UserDefaults.standard.bool(forKey:"isSignedIn")==true
        {
            let mainTab = self.storyboard?.instantiateViewController(identifier: "MainTabBar") as! MainTabBar
            mainTab.modalPresentationStyle = .fullScreen
            mainTab.modalTransitionStyle = .flipHorizontal
            mainTab.selectedViewController = mainTab.viewControllers?[1]
            self.present(mainTab,animated: false,completion: nil)
        }
    }
    func setupScene() {
        view.bindToKeyboard()
        userNameTextField.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextField.delegate = self
        emailTextField.delegate = self
        hideKeyboardWhenTappedAround()
        signinBtn.isEnabled=true
        signupBtn.isEnabled=true
        styleSignUpViews(userName:userNameTextField, email: emailTextField, password: passwordTextfield, confirmPassWord: confirmPasswordTextField,signUpButton: signupBtn, signinBtn : signinBtn)
        passwordTextfield.textContentType = .newPassword
        passwordTextfield.isSecureTextEntry = true
        confirmPasswordTextField.textContentType = .newPassword
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    func styleSignUpViews(userName:UITextField, email:UITextField, password:UITextField,confirmPassWord:UITextField, signUpButton:UIButton,signinBtn: UIButton) {
        Styles.styleTextField(textField: email)
        Styles.styleTextField(textField: userName)
        Styles.styleTextField(textField: password)
        Styles.styleTextField(textField: confirmPassWord)
        Styles.styleFilledButton(button: signUpButton)
        Styles.styleFilledButton(button: signinBtn)
    }
    
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        userNameTextField.resignFirstResponder()
        // extract clean user data.
        guard let userName = userNameTextField.text,
            let password = passwordTextfield.text,
            let confirmedPassword = confirmPasswordTextField.text,
            let email = emailTextField.text
            else {return}
        
        // Validating there aren't empty feiled.
        guard userName != "" && password != "" && confirmedPassword != "" && email != ""
            else { errorMessageLbl.text = SignupError.emptyField.errorDescription; return}
        // validating password acceptance
        guard password.count >= 6
            else { errorMessageLbl.text = SignupError.invalidePassword.errorDescription; return}
        //Validating entered passwords matched
        guard password == confirmedPassword
            else { errorMessageLbl.text = SignupError.notMatchedPasswords.errorDescription; return }
        //creating user and save its data
        
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            guard error == nil
                else { self.errorMessageLbl.text = SignupError.existedUser.errorDescription; return }
            
            guard let uid = result?.user.uid else{return}
            let userData:[String:Any] = ["name":userName,
                                         "email":email,
                                         "password":password
            ]
            
            let ref = Database.database().reference()
            ref.child("users").child(uid).child("userData").setValue(userData)
            self.errorMessageLbl.text = " registered successfully "
            // Transition to the Home screen ( master Feed )
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar else {return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: true,completion: nil)
        }
    }
    
    @IBAction func gotoSignIn(_ sender: Any)  {
        guard let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC else { return }
        signInVC.modalPresentationStyle = .fullScreen
        signInVC.modalTransitionStyle = .flipHorizontal 
        self.present(signInVC,animated: true,completion: nil)
    } 
}

extension SignUpVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


