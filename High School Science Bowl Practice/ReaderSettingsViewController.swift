//
//  ReaderSettingsViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class ReaderSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let roundPickerData = [
        ["Set 1", "Set 2", "Set 3", "Set 4", "Set 5", "Set 6", "Set 7", "Set 8"],
        ["Round 1", "Round 2", "Round 3", "Round 4", "Round 5", "Round 6", "Round 7", "Round 8", "Round 9", "Round 10", "Round 11", "Round 12", "Round 13", "Round 14", "Round 15", "Round 16", "Round 17"]
    ]
    
    let tossupTimePickerData = [["5 Seconds", "10 Seconds", "15 Seconds"]]
    let bonusTimePickerData = [["20 Seconds", "25 Seconds", "30 Seconds", "35 Seconds", "40 Seconds"]]
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(ReaderSettingsViewController.returnMainMenu))
        return button
    }()
    
    lazy var setChooserHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose a Question Set:"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var setRoundPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    lazy var startSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Set", for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 63.0/255.0, alpha: 0.5)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(ReaderSettingsViewController.startReaderMode), for: .touchUpInside)
        return button
    }()
    
    lazy var timePickerHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Question Time Limits:"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var tossupTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tossup:"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var tossupTimePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    lazy var bonusTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bonus:"
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var bonusTimePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = mainMenuButton
        self.navigationItem.title = "Reader Mode"
        view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        setRoundPicker.delegate = self
        setRoundPicker.dataSource = self
        tossupTimePicker.delegate = self
        tossupTimePicker.dataSource = self
        bonusTimePicker.delegate = self
        bonusTimePicker.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(setChooserHeader)
        NSLayoutConstraint.activate([
            setChooserHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20),
            setChooserHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(setRoundPicker)
        NSLayoutConstraint.activate([
            setRoundPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setRoundPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setRoundPicker.topAnchor.constraint(equalTo: setChooserHeader.bottomAnchor, constant: 10),
            setRoundPicker.heightAnchor.constraint(greaterThanOrEqualToConstant: 140)
        ])
        
        view.addSubview(startSetButton)
        NSLayoutConstraint.activate([
            startSetButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            startSetButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            startSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startSetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        view.addSubview(timePickerHeader)
        NSLayoutConstraint.activate([
            timePickerHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePickerHeader.topAnchor.constraint(equalTo: setRoundPicker.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(tossupTimeLabel)
        NSLayoutConstraint.activate([
            tossupTimeLabel.leadingAnchor.constraint(equalTo: timePickerHeader.leadingAnchor, constant: 15),
            tossupTimeLabel.topAnchor.constraint(equalTo: timePickerHeader.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(tossupTimePicker)
        NSLayoutConstraint.activate([
            tossupTimePicker.widthAnchor.constraint(equalToConstant: 140),
            tossupTimePicker.heightAnchor.constraint(equalToConstant: 50),
            tossupTimePicker.trailingAnchor.constraint(equalTo: timePickerHeader.trailingAnchor, constant: -15),
            tossupTimePicker.centerYAnchor.constraint(equalTo: tossupTimeLabel.centerYAnchor)
        ])
        
        view.addSubview(bonusTimeLabel)
        NSLayoutConstraint.activate([
            bonusTimeLabel.leadingAnchor.constraint(equalTo: tossupTimeLabel.leadingAnchor),
            bonusTimeLabel.topAnchor.constraint(equalTo: tossupTimeLabel.bottomAnchor, constant: 40)
        ])
        
        view.addSubview(bonusTimePicker)
        NSLayoutConstraint.activate([
            bonusTimePicker.widthAnchor.constraint(equalToConstant: 140),
            bonusTimePicker.heightAnchor.constraint(equalToConstant: 50),
            bonusTimePicker.leadingAnchor.constraint(equalTo: tossupTimePicker.leadingAnchor),
            bonusTimePicker.centerYAnchor.constraint(equalTo: bonusTimeLabel.centerYAnchor)
        ])
    }
    
    func startReaderMode() {
        let questionSetNum = setRoundPicker.selectedRow(inComponent: 0) + 1
        let roundNum = setRoundPicker.selectedRow(inComponent: 1) + 1
        let tossupTime = getTossupTimeSelected()
        let bonusTime = getBonusTimeSelected()
        if ((roundNum == 16 || roundNum == 17) && (questionSetNum == 5 || questionSetNum == 6)) {
        } else {
            let questionSet = QuestionJSONParser.shared.getQuestionSet(questionSetNum, forRound: roundNum)
            let readerController = ReaderModeViewController(questionSet: questionSet, index: 0, tossupTime: tossupTime, bonusTime: bonusTime)
            navigationController?.pushViewController(readerController, animated: true)
        }
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == setRoundPicker {
            return roundPickerData.count
        } else if pickerView == tossupTimePicker {
            return tossupTimePickerData.count
        } else if pickerView == bonusTimePicker {
            return bonusTimePickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == setRoundPicker {
            return roundPickerData[component].count
        } else if pickerView == tossupTimePicker {
            return tossupTimePickerData[component].count
        } else if pickerView == bonusTimePicker {
            return bonusTimePickerData[component].count
        } else {
            return 0
        }
    }
    
    // MARK: - Picker Delegate
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: String
        if pickerView == setRoundPicker {
            title = roundPickerData[component][row]
        } else if pickerView == tossupTimePicker {
            title = tossupTimePickerData[component][row]
        } else if pickerView == bonusTimePicker {
            title = bonusTimePickerData[component][row]
        } else {
            title = ""
        }
        let attributedString = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: UIColor.white])
        return attributedString
    }
    
    func getTossupTimeSelected() -> Int {
        let index = tossupTimePicker.selectedRow(inComponent: 0)
        switch index {
        case 0: return 5
        case 1: return 10
        case 2: return 15
        default: return 0
        }
    }
    
    func getBonusTimeSelected() -> Int {
        let index = bonusTimePicker.selectedRow(inComponent: 0)
        switch index {
        case 0: return 20
        case 1: return 25
        case 2: return 30
        case 3: return 35
        case 4: return 40
        default: return 0
        }
    }
}
