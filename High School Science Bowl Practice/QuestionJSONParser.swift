//
//  QuestionJSONParser.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import Foundation

struct QuestionJSONParser {
    let parsedJSON = {
        QuestionJSONParser.parseJsonFile(withName: "questions")
    }()
    
    static func parseJsonFile(withName name: String) -> [NSDictionary] {
        let file = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: file!))
        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as! [NSDictionary]
        return jsonData
    }
    
//    func parseQuestionForIndex(_ index: Int) -> Question {
//        
//    }
}
