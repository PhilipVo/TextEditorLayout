//
//  Entry+CoreDataProperties.swift
//  BlackBelt
//
//  Created by Philip on 9/26/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {

    @NSManaged var details: String?
    @NSManaged var beasted: NSNumber?
    @NSManaged var beasted_date: NSDate?

}
