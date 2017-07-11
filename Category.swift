//
//  Category.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import Foundation

enum Category {
    case biology
    case chemistry
    case earthAndSpace
    case energy
    case mathematics
    case physics
    case generalScience
    case computerScience
    
    init(catString: String) {
        switch catString {
        case "BIO": self = .biology
        case "CHEM": self = .chemistry
        case "EAS": self = .earthAndSpace
        case "ENG": self = .energy
        case "MATH": self = .mathematics
        case "PHY": self = .physics
        case "GS": self = .generalScience
        case "CS": self = .computerScience
        default: self = .generalScience
        }
    }
}
