//
//  StudySettingsViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class StudySettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var roundPicker: UIPickerView!
    let pickerData = [
        ["All Rounds", "Round 1", "Round 2", "Round 3", "Round 4", "Round 5", "Round 6", "Round 7", "Round 8", "Round 9", "Round 10", "Round 11", "Round 12", "Round 13", "Round 14", "Round 15", "Round 16", "Round 17"]
    ]
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Main Menu", style: .plain, target: self, action: #selector(StudySettingsViewController.returnMainMenu))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = mainMenuButton
        roundPicker.dataSource = self
        roundPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startStudyMode(_ sender: Any) {
        let category = Category.physics
        let roundNumber = roundPicker.selectedRow(inComponent: 0)
        let studyController = StudyModeViewController(category: category, round: roundNumber)
        navigationController?.pushViewController(studyController, animated: true)
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    // MARK: - Picker Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
}
