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
    @IBOutlet weak var questionTextLabel: UILabel!
    let parser = QuestionJSONParser()

    override func viewDidLoad() {
        super.viewDidLoad()

        let parsedJSON = parser.parseJsonFile(withName: "questions")
        guard let question = parsedJSON["S1R17Q1Tossup"] else {
            fatalError()
        }
        guard let q = question as? [String: Any], let qText = q["tossupQuestion"], let text = qText as? String else {
            fatalError()
        }
        questionTextLabel.text = text
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
