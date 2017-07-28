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
    
    static let shared = QuestionJSONParser()
    
    static func parseJsonFile(withName name: String) -> [[String: Any]] {
        let file = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: file!))
        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        if let jsonData = jsonData {
            return jsonData
        } else {
            return [[String: Any]]()
        }
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
        return QuestionJSONParser.shared.parseQuestionForIndex(randomIndex)
    }
    
    func getQuestionForCategory(_ category: Category) -> Question {
        while true {
            let question = QuestionJSONParser.shared.getRandomQuestion()
            if question.category == category {
                return question
            }
        }
        // Will never reach this state because of limited enum values
    }
    
    func getQuestionForCategory(_ category: Category, andRound round: Int) -> Question {
        while true {
            let question = QuestionJSONParser.shared.getRandomQuestion()
            if question.category == category && question.roundNumber == round {
                return question
            }
        }
        // Will never reach this state because of limited enum values
    }
    
    func getQuestionForRound(_ round: Int) -> Question {
        while true {
            let question = QuestionJSONParser.shared.getRandomQuestion()
            if question.roundNumber == round {
                return question
            }
        }
        // Will never reach this state because of limited round number selections
    }
    
    func getQuestionForSet(_ set: Int, andRound round: Int) -> Question {
        while true {
            let question = QuestionJSONParser.shared.getRandomQuestion()
            if question.setNumber == set && question.roundNumber == round {
                return question
            }
        }
        // Will never reach this state because of limited set and round selections
    }
    
    func getQuestionSet(_ set: Int, forRound round: Int) -> [Question] {
        var questions = [Question]()
        for question in QuestionJSONParser.shared.parsedQuestions {
            if question.setNumber == set && question.roundNumber == round {
                questions.append(question)
            }
        }
        return questions.sorted(by: sortQuestionsByNumberAndType)
    }
    
    func sortQuestionsByNumberAndType(this: Question, that: Question) -> Bool {
        let thisFirst: Bool
        if this.questionNumber < that.questionNumber {
            thisFirst = true
        } else if this.questionNumber == that.questionNumber {
            if this.questionType == .tossup {
                thisFirst = true
            } else {
                thisFirst = false
            }
        } else {
            thisFirst = false
        }
        
        return thisFirst
    }
    
    func getMCQuestion() -> Question {
        while true {
            let question = QuestionJSONParser.shared.getRandomQuestion()
            if question.answerType == .multipleChoice && question.answerChoices!.count == 4 {
                return question
            }
        }
    }
    
    func getMCQuestionForCategory(_ category: Category) -> Question {
        while true {
            let question = QuestionJSONParser.shared.getMCQuestion()
            if question.category == category {
                return question
            }
        }
    }
}





