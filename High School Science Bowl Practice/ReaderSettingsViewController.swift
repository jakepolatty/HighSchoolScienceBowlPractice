//
//  ReaderSettingsViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class ReaderSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var setRoundPicker: UIPickerView!
    let pickerData = [
        ["Question Set 1", "Question Set 2", "Question Set 3", "Question Set 4", "Question Set 5", "Question Set 6", "Question Set 7", "Question Set 8"],
        ["Round 1", "Round 2", "Round 3", "Round 4", "Round 5", "Round 6", "Round 7", "Round 8", "Round 9", "Round 10", "Round 11", "Round 12", "Round 13", "Round 14", "Round 15", "Round 16", "Round 17"]
    ]
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Main Menu", style: .plain, target: self, action: #selector(ReaderSettingsViewController.returnMainMenu))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = mainMenuButton
        setRoundPicker.delegate = self
        setRoundPicker.dataSource = self
        
    }
    
    @IBAction func startReaderMode(_ sender: Any) {
        let questionSetNum = setRoundPicker.selectedRow(inComponent: 0) + 1
        let roundNum = setRoundPicker.selectedRow(inComponent: 1) + 1
        let questionSet = QuestionJSONParser.shared.getQuestionSet(questionSetNum, forRound: roundNum)
        let readerController = ReaderModeViewController(questionSet: questionSet, index: 0)
        navigationController?.pushViewController(readerController, animated: true)
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
