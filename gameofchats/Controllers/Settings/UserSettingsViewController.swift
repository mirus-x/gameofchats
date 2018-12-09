//
//  UserSettingsViewController.swift
//  gameofchats
//
//  Created by 2x2 on 11/14/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage

class UserSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profileState: Bool = false
    let imagePicker = UIImagePickerController()
    
    let profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 60
        container.clipsToBounds = true
        container.layer.masksToBounds = false
        container.layer.borderWidth = 3
        container.layer.borderColor = Colors.white.cgColor
        
        return container
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.image = UIImage(named: "wolf")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.isUserInteractionEnabled = false
        
        imageView.layer.borderWidth = 0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    
    let profileEmailField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Email: "
        tf.textColor = Colors.loginRegBtn
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    let profileNameField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = "Name: "
        tf.textColor = Colors.loginRegBtn
        tf.isUserInteractionEnabled = false
        tf.setBottomBorder()
        return tf
    }()
    
    let profileDeleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.loginRegBtn
        button.setTitle("Delete profile", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.white, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.addTarget(self, action: #selector(handleProfileDelete), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.loginBgBlue
        self.setNeedsStatusBarAppearanceUpdate()
        imagePicker.delegate = self
        setupNavigationBarStyles()
        // Do any additional setup after loading the view.
        
        view.addSubview(profileContainerView)
        view.addSubview(profileImageContainerView)
        view.addSubview(profileDeleteButton)
        
        setupProfileContainerViewConstraints()
        setupProfileImageViewConstraints()
        setupProfileDeleteButtonConstraints()
        
        // load profile image if any exist
        
        guard let user = Auth.auth().currentUser else {
            print("Error! User is not authenticated!")
            let logout = MessagesViewController()
            logout.handleLogoutPress()
            return
        }
        
        
        if let profileImage = user.photoURL?.absoluteString{
        guard let url = NSURL(string: profileImage) else { return }
            URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.profileImageView.image = image
                })
            }.resume()
        }
        
        self.profileNameField.text = user.displayName
        self.profileEmailField.text = user.email
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let user = Auth.auth().currentUser else {
            let logout = MessagesViewController()
            logout.handleLogoutPress()
            return
        }
        
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = pickedImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            profileImageView.image = selectedImage
        }
        
        let currentTimeStamp = NSDate().timeIntervalSince1970.toString()
        let storageRef = Storage.storage(url: PathUrls.firestore).reference().child("\(currentTimeStamp)_got.png")
        
        if let uploadImage = self.profileImageView.image!.pngData(){
            storageRef.putData(uploadImage, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("Error: ", error!)
                    return
                }
                
                storageRef.downloadURL(completion: { (url, error) in
                    guard let imageUrl = url else{
                        print("Could not find image URL. Error: ", error!)
                        return
                    }
                    //user.createProfileChangeRequest().photoURL = imageUrl
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.photoURL = imageUrl
                    changeRequest.commitChanges { error in
                        if let _ = error {
                            print("Try Again")
                        } else {
                            print(user.photoURL?.absoluteString)
                            print("Photo Updated")
                        }
                    }
                })
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleProfileDelete(){
    
    }
    
    
    var profileDBHC: NSLayoutConstraint?
    @objc func saveUserProfile(){
        //save edited information to the database
        profileDBHC?.constant = 0
        
        profileEmailField.isUserInteractionEnabled = false
        profileNameField.isUserInteractionEnabled = false
        // change button state
        let rightNavButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
        
        profileImageView.isUserInteractionEnabled = false
    }
    
    
    
    @objc func editUserProfile(){
        // show edit information view
        
        profileDBHC?.constant = 50
        profileEmailField.isUserInteractionEnabled = true
        profileNameField.isUserInteractionEnabled = true
        //change button state (my be need to define global button ???
        let rightNavButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveUserProfile))
        rightNavButton.tintColor = Colors.white
        navigationItem.rightBarButtonItem = rightNavButton
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(changeUserProfileImage))
        profileImageView.addGestureRecognizer(pictureTap)
        profileImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func changeUserProfileImage(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @objc func closeSettingsViewController(){
        profileEmailField.isUserInteractionEnabled = false
        profileNameField.isUserInteractionEnabled = false
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}


extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

