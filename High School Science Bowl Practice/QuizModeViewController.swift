//
//  QuizModeViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import Foundation
import UIKit

class QuizModeViewController: UIViewController {
    @IBOutlet weak var roundSetNumLabel: UILabel!
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var catTypeLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    let parser = QuestionJSONParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let question = parser.getQuestionForSet(8, andRound: 11)
        setupDisplayForQuestion(question)
        //let questionSet = parser.getQuestionSet(1, forRound: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDisplayForQuestion(_ question: Question) {
        let roundNum = question.roundNumber
        let setNum = question.setNumber
        roundSetNumLabel.text = "Question Set \(setNum) Round \(roundNum)"
        
        let questionNum = question.questionNumber
        let questionType = question.questionType
        questionNumLabel.text = "Question \(questionNum) \(String(describing: questionType))"
        
        let category = question.category
        let answerType = question.answerType
        catTypeLabel.text = "\(String(describing: category)) \(String(describing: answerType))"
        
        questionTextLabel.text = question.questionText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
