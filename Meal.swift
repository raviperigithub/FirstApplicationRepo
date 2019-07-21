//
//  Meal.swift
//  FirstApplicationRepo
//
//  Created by Srinivasa Ravi Teja Peri on 7/19/19.
//  Copyright © 2019 HarshaRaviGitHub. All rights reserved.
//

import UIKit


class Meal {
    var name : String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating>=0) && (rating < 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
