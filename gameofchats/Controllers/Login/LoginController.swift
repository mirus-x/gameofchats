//
//  LoginController.swift
//  gameofchats
//
//  Created by 2x2 on 11/11/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.loginRegBtn
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.white, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleTypeOfUserAuth), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Name"
        input.textColor = Colors.loginRegBtn
        input.setBottomBorder()
        return input
    }()
    
    let passwordTextField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Password"
        input.textColor = Colors.loginRegBtn
        input.isSecureTextEntry = true
        return input
    }()
    
    let emailTextField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Email"
        input.textColor = Colors.loginRegBtn
        input.setBottomBorder()
        return input
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wolf")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    lazy var segmentedControlView: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Login", "Register"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.tintColor = Colors.white
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.white], for: UIControl.State.normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.loginBgBlue], for: UIControl.State.selected)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: FontSizes.x16], for: .normal)
        segment.selectedSegmentIndex = 1
        segment.addTarget(self, action: #selector(handleLoginRegisterViewChange), for: .valueChanged)
        return segment
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPageUI()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}


