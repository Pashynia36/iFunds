//
//  AddTransactionViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import CoreData
import Photos

final class AddTransactionViewController: UIViewController {
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var purposeField: UITextField!
    @IBOutlet private weak var descriptionField: UITextField!
    @IBOutlet private weak var amountField: UITextField!
    
    private var photo: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackground()
        _ = PHAsset.fetchAssets(with: nil)
        purposeField.delegate = self
        descriptionField.delegate = self
        amountField.delegate = self
    }
    
    func setBackground() {
        
       self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.alpha = 1
        let gradient = CAGradientLayer()
        let colorOne = UIColor(red: 90.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorTwo = UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorThree = UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorThree, colorTwo, colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height * 2)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func save(isIncome: Bool, purpose: String, description: String, amount: Float, photo: String) {
        
        let date = Date()
        // Taking managedContext
        let managedContext = AppDelegate.viewContext
        // Creating new managed Object
        let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        // Setting new value to managedObject via KVC
        object.setValue(isIncome, forKey: "isIncome")
        object.setValue(purpose, forKey: "purpose")
        object.setValue(description, forKey: "descr")
        object.setValue(amount, forKey: "amount")
        object.setValue(photo, forKey: "photo")
        object.setValue(date, forKey: "date")
        // Commit changes in the managedContext
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    @IBAction func photoButton(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source for photo", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        // TODO: - Core data save
        if (purposeField.text?.count)! > 2 && !(amountField.text?.isEmpty)! {
            let isIncome = (segmentControl.selectedSegmentIndex == 0)
            let purpose = purposeField.text!
            let description = descriptionField.text ?? ""
            let amount = Float(amountField.text!)!
            save(isIncome: isIncome, purpose: purpose, description: description, amount: amount, photo: photo)
            navigationController?.popViewController(animated: true)
        } else {
            purposeField.layer.backgroundColor = UIColor.red.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.purposeField.layer.backgroundColor = UIColor.white.cgColor
            }
            let animation = CAKeyframeAnimation()
            
            animation.keyPath = "position.x"
            
            animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
            
            animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
            animation.duration = 0.4
            
            animation.isAdditive = true
            
            purposeField.layer.add(animation, forKey: "shake")
        }
    }
}

extension AddTransactionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // Did finish picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Taking chosen PHAsset
        let image = info[UIImagePickerControllerPHAsset]
        photo = (image as! PHAsset).localIdentifier
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Did cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Should close keyboard after pressing 'Done'
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
