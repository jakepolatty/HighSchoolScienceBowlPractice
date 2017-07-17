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
    static let parsedQuestions = {
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
    
    static func parseQuestionForIndex(_ index: Int) -> Question {
        return parsedQuestions[index]
    }
    
    static func getRandomQuestion() -> Question {
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: parsedQuestions.count)
        return parseQuestionForIndex(randomIndex)
    }
    
    func getQuestionForCategory(_ category: Category) -> Question {
        while true {
            let question = QuestionJSONParser.getRandomQuestion()
            if question.category == category {
                return question
            }
        }
        // Will never reach this state because of limited enum values
    }
    
    func getQuestionForRound(_ round: Int) -> Question {
        while true {
            let question = QuestionJSONParser.getRandomQuestion()
            if question.roundNumber == round {
                return question
            }
        }
        // Will never reach this state because of limited round number selections
    }
    
    func getQuestionForSet(_ set: Int, andRound round: Int) -> Question {
        while true {
            let question = QuestionJSONParser.getRandomQuestion()
            if question.setNumber == set && question.roundNumber == round {
                return question
            }
        }
        // Will never reach this state because of limited set and round selections
    }
}





