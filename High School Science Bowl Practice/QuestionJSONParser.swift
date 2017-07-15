//
//  QuestionJSONParser.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import GameKit
import Foundation

struct QuestionJSONParser {
    let parsedJSON = {
        QuestionJSONParser.parseJsonFile(withName: "questions")
    }()
    
    static func parseJsonFile(withName name: String) -> [[String: Any]] {
        let file = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: file!))
        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        return jsonData
    }
    
    func parseQuestionForIndex(_ index: Int) -> Question? {
        let questionJSON = parsedJSON[index]
        guard let parsedQuestion = Question(json: questionJSON) else {
            return nil
        }
        return parsedQuestion
    }
    
    func getRandomQuestion() -> Question? {
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: parsedJSON.count)
        return parseQuestionForIndex(randomIndex)
    }
}
