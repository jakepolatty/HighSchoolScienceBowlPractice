//
//  StudySettingsViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class StudySettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startStudyMode(_ sender: Any) {
        let category = Category.physics
        let studyController = StudyModeViewController(category: category, round: nil)
        navigationController?.pushViewController(studyController, animated: true)
    }
}
