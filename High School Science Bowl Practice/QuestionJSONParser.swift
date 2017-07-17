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
    let parsedQuestions = {
        QuestionJSONParser.parseJSONToQuestions()
    }()
    
    static func parseJsonFile(withName name: String) -> [[String: Any]] {
        let file = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: file!))
        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        return jsonData
    }
    
    static func parseJSONToQuestions() -> [Question] {
        var questionArray = [Question]()
        let parsedJSON = QuestionJSONParser.parseJsonFile(withName: "questions")
        for questionJSON in parsedJSON {
            if let parsedQuestion = Question(json: questionJSON) {
                questionArray.append(parsedQuestion)
            }
        }
        return questionArray
    }
    
    func parseQuestionForIndex(_ index: Int) -> Question {
        return parsedQuestions[index]
    }
    
    func getRandomQuestion() -> Question {
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: parsedQuestions.count)
        return parseQuestionForIndex(randomIndex)
    }
    
    func getQuestionForCategory(_ category: Category) -> Question {
        
        return parsedQuestions[0]
    }
}
