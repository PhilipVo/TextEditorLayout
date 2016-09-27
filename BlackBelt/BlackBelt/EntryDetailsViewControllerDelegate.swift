//
//  ListDetailsViewControllerDelegate.swift
//  BlackBelt
//
//  Created by Philip on 9/25/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import Foundation

protocol EntryDetailsViewControllerDelegate: class {
    func entryDetailsViewController(controller: EntryDetailsViewController, addEntry details: String)
    func entryDetailsViewController(controller: EntryDetailsViewController, editEntry entry: Entry)
}

