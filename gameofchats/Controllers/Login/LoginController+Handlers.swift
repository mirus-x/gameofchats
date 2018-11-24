//
//  LoginController+Handlers.swift
//  gameofchats
//
//  Created by 2x2 on 11/24/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


extension LoginController{
    /*
     All Handler functions goes here
     */
    
    @objc func handleTypeOfUserAuth(){
        if segmentedControlView.selectedSegmentIndex == 0{
            exisitingUserLogIn()
        }else{
            newUserRegistration()
        }
    }
    
    func exisitingUserLogIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text
            else{
                print("Please enter valid form data")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if  error != nil {
                print("Signing in failed! Error : ", error! )
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func newUserRegistration(){
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else{
                print("Please enter valid form data")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if  error != nil {
                print("Error! : ", error! )
                return
            }
            
            //            guard let user = authResult?.user else { return }
            guard let uid = authResult?.user.uid else {return}
            
            var ref: DatabaseReference!
            ref = Database.database().reference(fromURL: "https://gameofchats-lbta.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            userReference.updateChildValues(values, withCompletionBlock: { (writeError, ref) in
                if writeError != nil{
                    print("Error: Unable to register new user. ", writeError!)
                    return
                }
                
                print("New user was registered successfully")
                self.dismiss(animated: true, completion: nil)
            })
            
            
        }
    }
    
    
    @objc func handleLoginRegisterViewChange(){
        let title = segmentedControlView.titleForSegment(at: segmentedControlView.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //change inputViewHeight 100:150
        LoginController.inputContainerViewHeightAncor?.constant = segmentedControlView.selectedSegmentIndex == 0 ? 100 : 150
        
        //change nameTextFieldHeightAnchor height on segment switch
        LoginController.nameTextFieldHeightAnchor?.constant = segmentedControlView.selectedSegmentIndex == 0 ? 0 : 49
    }
    
    
}
