//
//  ReaderSettingsViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class ReaderSettingsViewController: UIViewController {
    let parser = QuestionJSONParser()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startReaderMode(_ sender: Any) {
        let questionSet = parser.getQuestionSet(1, forRound: 1)
        let readerController = ReaderModeViewController(questionSet: questionSet, index: 0)
        navigationController?.pushViewController(readerController, animated: true)
    }
}
