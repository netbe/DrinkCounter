//
//  AddDrinkViewController.swift
//  DrinkCounter
//
//  Created by François Benaiteau on 29/05/16.
//  Copyright © 2016 François Benaiteau. All rights reserved.
//

import UIKit

class AddDrinkViewController: UIViewController, UITextFieldDelegate, Provided {
    
    var provider: Provider?
    func receiveProvider(provider: Provider) {
        self.provider = provider
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismiss()
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        enableSaveButton()
    }
    
    @IBAction func textFieldPrimaryAction(sender:AnyObject) {
        saveButtonTapped(sender)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let text = textField.text, provider = provider else {
            // should never happen
            print("Error: missing text or provider")
            showError()
            return
        }
        provider.saveDrink(text) { (success) in
            if success {
                self.dismiss()
            }else{
                self.showError()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSaveButton()
        textField.becomeFirstResponder()
    }
    
    func showError() {
        let originalColor = textField.textColor
        
        self.textField.textColor = UIColor.redColor()
        self.textField.layer.borderColor = self.textField.textColor?.CGColor
        self.textField.layer.layoutIfNeeded()
        let frame = self.textField.frame
        
        UIView.animateKeyframesWithDuration(0.4, delay: 0, options: .AllowUserInteraction, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.25, animations: {
                self.textField.frame = CGRectOffset(frame,10, 0)
                
            })
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: {
                self.textField.frame = CGRectOffset(frame, -10, 0)
                
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.25, animations: {
                self.textField.frame = CGRectOffset(frame,10, 0)
                
            })
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25, animations: {
                self.textField.frame = CGRectOffset(frame, -10, 0)
                
            })
            
        }) { (finished) in
            self.textField.frame = frame
            self.textField.textColor = originalColor
        }
    }
    
    func enableSaveButton() {
        guard let text = textField.text else {
            return
        }
        saveButton.enabled = text.characters.count > 0
    }
    
    func dismiss() {
        textField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    //    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    //        enableSaveButton()
    //        return true
    //    }
}