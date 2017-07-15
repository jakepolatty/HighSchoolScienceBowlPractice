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
        
        let question = parser.getRandomQuestion()
        if let roundNum = question?.roundNumber, let setNum = question?.setNumber {
            roundSetNumLabel.text = "Question Set \(setNum) Round \(roundNum)"
        }
        if let questionNum = question?.questionNumber {
            questionNumLabel.text = "Question \(questionNum)"
        }
        questionTextLabel.text = question?.questionText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
