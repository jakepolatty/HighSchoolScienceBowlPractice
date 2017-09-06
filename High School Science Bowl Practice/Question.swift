//
//  Question.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import Foundation

enum AnswerType {
    case multipleChoice
    case shortAnswer
    
    init(typeString: String) {
        switch typeString {
        case "MC": self = .multipleChoice
        case "SA": self = .shortAnswer
        default: self = .shortAnswer
        }
    }
}

extension AnswerType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .multipleChoice: return "Multiple Choice"
        case .shortAnswer: return "Short Answer"
        }
    }
}

enum QuestionType {
    case tossup
    case bonus
    
    init (typeString: String) {
        switch typeString {
        case "T": self = .tossup
        case "B": self = .bonus
        default: self = .tossup
        }
    }
}

extension QuestionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .tossup: return "Tossup"
        case .bonus: return "Bonus"
        }
    }
}

struct Question {
    let questionText: String
    let category: Category
    let questionType: QuestionType
    let answerType: AnswerType
    let setNumber: Int
    let roundNumber: Int
    let questionNumber: Int
    let answerChoices: [String]?
    let answer: String
}

extension Question {
    struct Key {
        static let questionText = "qTxt"
        static let questionAnswer = "qAns"
        static let answerChoices = "ansCh"
        static let category = "cat"
        static let setNumber = "sNum"
        static let roundNumber = "rNum"
        static let questionNumber = "qNum"
        static let answerType = "mc"
        static let questionType = "tb"
    }
    
    init?(json: [String: Any]) {
        guard let qText = json[Key.questionText] as? String,
            let qAnswer = json[Key.questionAnswer] as? String,
            let catString = json[Key.category] as? String,
            let setNumber = json[Key.setNumber] as? Int,
            let roundNumber = json[Key.roundNumber] as? Int,
            let questionNumber = json[Key.questionNumber] as? Int,
            let answerType = json[Key.answerType] as? String,
            let questionType = json[Key.questionType] as? String else {
                return nil;
        }
        
        self.questionText = qText
        self.answer = qAnswer
        self.setNumber = setNumber
        self.roundNumber = roundNumber
        self.questionNumber = questionNumber
        self.category = Category(catString: catString)
        self.answerType = AnswerType(typeString: answerType)
        self.questionType = QuestionType(typeString: questionType)
        
        if self.answerType == .multipleChoice {
            guard let ansChoices = json[Key.answerChoices] as? [String] else {
                return nil;
            }
            self.answerChoices = ansChoices
        } else {
            self.answerChoices = nil
        }
    }
}
