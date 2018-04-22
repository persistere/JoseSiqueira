//
//  ViewController+CoreData.swift
//  JoseSiqueira
//
//  Created by Jose Otavio on 22/04/2018.
//  Copyright © 2018 Jose Otavio. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
