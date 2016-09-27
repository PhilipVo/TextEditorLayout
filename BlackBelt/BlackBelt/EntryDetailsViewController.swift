//
//  ListDetailsViewController.swift
//  BlackBelt
//
//  Created by Philip on 9/25/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UITableViewController {
    @IBOutlet weak var entryDetailsTextField: UITextField!
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var entryDetailsDelegate: EntryDetailsViewControllerDelegate?
    
    var entryToEdit: Entry?
    var entryToEditIndexPath: Int?
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        if let entry = entryToEdit {
            entry.details = entryDetailsTextField.text!
            entryDetailsDelegate?.entryDetailsViewController(self, editEntry: entry)
        } else {
            let entry = entryDetailsTextField.text!
            entryDetailsDelegate?.entryDetailsViewController(self, addEntry: entry)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let entry = entryToEdit {
            entryDetailsTextField.text = entry.details
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
