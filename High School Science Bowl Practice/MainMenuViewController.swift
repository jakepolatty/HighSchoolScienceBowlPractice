//
//  MainMenuViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/20/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startReaderMode(_ sender: Any) {
        let readerSettingsController = ReaderSettingsViewController()
        let navigationController = UINavigationController(rootViewController: readerSettingsController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func startStudyMode(_ sender: Any) {
        let studySettingsController = StudySettingsViewController()
        let navigationController = UINavigationController(rootViewController: studySettingsController)
        self.present(navigationController, animated: true, completion: nil)
    }
}
