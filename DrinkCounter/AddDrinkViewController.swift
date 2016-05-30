//
//  AddDrinkViewController.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import UIKit

class AddDrinkViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismiss()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        dismiss()
    }
    
    
    func dismiss() {
        textField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSaveButton()
        textField.becomeFirstResponder()
    }
    

    @IBAction func editingChanged(sender: AnyObject) {
        enableSaveButton()
    }
    
    func enableSaveButton() {
        guard let text = textField.text else {
            return
        }
        saveButton.enabled = text.characters.count > 0
    }
    
    // MARK: - UITextFieldDelegate
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        enableSaveButton()
//        return true
//    }
}