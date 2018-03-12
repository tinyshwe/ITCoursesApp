//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit


class Meal {
    
    //MARK: Properties
    
    var number: String
    var title: String
    var description: String
    
    //MARK: Initialization
    
    init?(number: String, title: String, description: String) {
        
        // The name must not be empty
        guard !number.isEmpty else {
            return nil
        }
        // Initialize stored properties.
        self.number = number
        self.title = title
        self.description = description
        
    }
}
