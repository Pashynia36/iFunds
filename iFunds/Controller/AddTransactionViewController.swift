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
        _ = PHAsset.fetchAssets(with: nil)
    }
    
    func save(isIncome: Bool, purpose: String, description: String, amount: Float, photo: String) {
        
        let date = Date()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        // Taking managedContext
        let managedContext = appDelegate.persistentContainer.viewContext
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
        }
    }
}

extension AddTransactionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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
}
