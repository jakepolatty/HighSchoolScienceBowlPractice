//
//  QuizSettingsViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/20/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

class QuizSettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    static let lightGrey = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
    static let darkGrey = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
    
    let tossupTimePickerData = [["10 Seconds", "15 Seconds", "20 Seconds", "25 Seconds", "30 Seconds"]]
    let bonusTimePickerData = [["10 Seconds", "15 Seconds", "20 Seconds", "25 Seconds", "30 Seconds", "35 Seconds", "40 Seconds"]]
    var category: Category?
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(QuizSettingsViewController.returnMainMenu))
        return button
    }()
    
    lazy var topicHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose a Topic:"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var biologyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Biology", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.toggleBiology), for: .touchUpInside)
        return button
    }()
    
    lazy var chemistryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Chemistry", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.toggleChemistry), for: .touchUpInside)
        return button
    }()
    
    lazy var earthAndSpaceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Earth and Space", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.toggleEarthAndSpace), for: .touchUpInside)
        return button
    }()
    
    lazy var energyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Energy", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.toggleEnergy), for: .touchUpInside)
        return button
    }()
    
    lazy var mathButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Mathematics", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.toggleMath), for: .touchUpInside)
        return button
    }()
    
    lazy var physicsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Physics", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.togglePhysics), for: .touchUpInside)
        return button
    }()
    
    lazy var randomHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Or Generate Random Questions:"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var randomButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Random", for: .normal)
        button.setBackgroundColor(color: lightGrey, forState: .normal)
        button.setBackgroundColor(color: darkGrey, forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.isSelected = true
        button.addTarget(self, action: #selector(QuizSettingsViewController.toggleRandom), for: .touchUpInside)
        return button
    }()
    
    lazy var startSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Set", for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 63.0/255.0, alpha: 0.5)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(QuizSettingsViewController.startQuizMode), for: .touchUpInside)
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
        self.navigationItem.title = "Quiz Mode"
        view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        tossupTimePicker.delegate = self
        tossupTimePicker.dataSource = self
        bonusTimePicker.delegate = self
        bonusTimePicker.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(topicHeader)
        NSLayoutConstraint.activate([
            topicHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20),
            topicHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(biologyButton)
        NSLayoutConstraint.activate([
            biologyButton.widthAnchor.constraint(equalToConstant: 130),
            biologyButton.heightAnchor.constraint(equalToConstant: 44),
            biologyButton.topAnchor.constraint(equalTo: topicHeader.bottomAnchor, constant: 7),
            biologyButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -15)
        ])
        
        view.addSubview(chemistryButton)
        NSLayoutConstraint.activate([
            chemistryButton.widthAnchor.constraint(equalToConstant: 130),
            chemistryButton.heightAnchor.constraint(equalToConstant: 44),
            chemistryButton.topAnchor.constraint(equalTo: topicHeader.bottomAnchor, constant: 7),
            chemistryButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15)
        ])
        
        view.addSubview(earthAndSpaceButton)
        NSLayoutConstraint.activate([
            earthAndSpaceButton.widthAnchor.constraint(equalToConstant: 130),
            earthAndSpaceButton.heightAnchor.constraint(equalToConstant: 44),
            earthAndSpaceButton.topAnchor.constraint(equalTo: biologyButton.bottomAnchor, constant: 10),
            earthAndSpaceButton.leadingAnchor.constraint(equalTo: biologyButton.leadingAnchor)
        ])
        
        view.addSubview(energyButton)
        NSLayoutConstraint.activate([
            energyButton.widthAnchor.constraint(equalToConstant: 130),
            energyButton.heightAnchor.constraint(equalToConstant: 44),
            energyButton.topAnchor.constraint(equalTo: chemistryButton.bottomAnchor, constant: 10),
            energyButton.trailingAnchor.constraint(equalTo: chemistryButton.trailingAnchor)
        ])
        
        view.addSubview(mathButton)
        NSLayoutConstraint.activate([
            mathButton.widthAnchor.constraint(equalToConstant: 130),
            mathButton.heightAnchor.constraint(equalToConstant: 44),
            mathButton.topAnchor.constraint(equalTo: earthAndSpaceButton.bottomAnchor, constant: 10),
            mathButton.leadingAnchor.constraint(equalTo: earthAndSpaceButton.leadingAnchor)
        ])
        
        view.addSubview(physicsButton)
        NSLayoutConstraint.activate([
            physicsButton.widthAnchor.constraint(equalToConstant: 130),
            physicsButton.heightAnchor.constraint(equalToConstant: 44),
            physicsButton.topAnchor.constraint(equalTo: energyButton.bottomAnchor, constant: 10),
            physicsButton.trailingAnchor.constraint(equalTo: energyButton.trailingAnchor),
        ])
        
        view.addSubview(randomHeader)
        NSLayoutConstraint.activate([
            randomHeader.topAnchor.constraint(equalTo: mathButton.bottomAnchor, constant: 10),
            randomHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomButton.widthAnchor.constraint(equalToConstant: 130),
            randomButton.heightAnchor.constraint(equalToConstant: 44),
            randomButton.topAnchor.constraint(equalTo: randomHeader.bottomAnchor, constant: 7),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(startSetButton)
        NSLayoutConstraint.activate([
            startSetButton.widthAnchor.constraint(equalToConstant: 120),
            startSetButton.heightAnchor.constraint(equalToConstant: 44),
            startSetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            startSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(timePickerHeader)
        NSLayoutConstraint.activate([
            timePickerHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePickerHeader.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(tossupTimeLabel)
        NSLayoutConstraint.activate([
            tossupTimeLabel.leadingAnchor.constraint(equalTo: timePickerHeader.leadingAnchor, constant: 30),
            tossupTimeLabel.topAnchor.constraint(equalTo: timePickerHeader.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(tossupTimePicker)
        NSLayoutConstraint.activate([
            tossupTimePicker.widthAnchor.constraint(equalToConstant: 100),
            tossupTimePicker.heightAnchor.constraint(equalToConstant: 50),
            tossupTimePicker.trailingAnchor.constraint(equalTo: timePickerHeader.trailingAnchor, constant: -30),
            tossupTimePicker.centerYAnchor.constraint(equalTo: tossupTimeLabel.centerYAnchor)
        ])
        
        view.addSubview(bonusTimeLabel)
        NSLayoutConstraint.activate([
            bonusTimeLabel.leadingAnchor.constraint(equalTo: tossupTimeLabel.leadingAnchor),
            bonusTimeLabel.topAnchor.constraint(equalTo: tossupTimeLabel.bottomAnchor, constant: 40)
        ])
        
        view.addSubview(bonusTimePicker)
        NSLayoutConstraint.activate([
            bonusTimePicker.widthAnchor.constraint(equalToConstant: 100),
            bonusTimePicker.heightAnchor.constraint(equalToConstant: 50),
            bonusTimePicker.leadingAnchor.constraint(equalTo: tossupTimePicker.leadingAnchor),
            bonusTimePicker.centerYAnchor.constraint(equalTo: bonusTimeLabel.centerYAnchor)
        ])
    }
    
    func startQuizMode() {
        let category = getCategoryForToggle()
        let tossupTime = getTossupTimeSelected()
        let bonusTime = getBonusTimeSelected()
        let studyController = QuizModeViewController(category: category, stats: QuizModeStats(), tossupTime: tossupTime, bonusTime: bonusTime)
        navigationController?.pushViewController(studyController, animated: true)
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Toggle Button Handlers
    
    func toggleOff() {
        biologyButton.isSelected = false
        chemistryButton.isSelected = false
        earthAndSpaceButton.isSelected = false
        energyButton.isSelected = false
        mathButton.isSelected = false
        physicsButton.isSelected = false
        randomButton.isSelected = false
    }
    
    func toggleBiology() {
        toggleOff()
        biologyButton.isSelected = true
        category = Category.biology
    }
    
    func toggleChemistry() {
        toggleOff()
        chemistryButton.isSelected = true
        category = Category.chemistry
    }
    
    func toggleEarthAndSpace() {
        toggleOff()
        earthAndSpaceButton.isSelected = true
        category = Category.earthAndSpace
    }
    
    func toggleEnergy() {
        toggleOff()
        energyButton.isSelected = true
        category = Category.energy
    }
    
    func toggleMath() {
        toggleOff()
        mathButton.isSelected = true
        category = Category.mathematics
    }
    
    func togglePhysics() {
        toggleOff()
        physicsButton.isSelected = true
        category = Category.physics
    }
    
    func toggleRandom() {
        toggleOff()
        randomButton.isSelected = true
        category = nil
    }
    
    func getCategoryForToggle() -> Category? {
        if biologyButton.isSelected {
            return Category.biology
        } else if chemistryButton.isSelected {
            return Category.chemistry
        } else if earthAndSpaceButton.isSelected {
            return Category.earthAndSpace
        } else if energyButton.isSelected {
            return Category.energy
        } else if mathButton.isSelected {
            return Category.mathematics
        } else if physicsButton.isSelected {
            return Category.physics
        } else {
            return nil
        }
    }
    
    // MARK: - Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == tossupTimePicker {
            return tossupTimePickerData.count
        } else if pickerView == bonusTimePicker {
            return bonusTimePickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == tossupTimePicker {
            return tossupTimePickerData[component].count
        } else if pickerView == bonusTimePicker {
            return bonusTimePickerData[component].count
        } else {
            return 0
        }
    }
    
    // MARK: - Picker Delegate
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.textAlignment = .center
        }
        let title: String
        if pickerView == tossupTimePicker {
            title = tossupTimePickerData[component][row]
            pickerLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)
        } else if pickerView == bonusTimePicker {
            title = bonusTimePickerData[component][row]
            pickerLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)
        } else {
            title = ""
        }
        pickerLabel?.text = title
        pickerLabel?.textColor = UIColor.white
        return pickerLabel!
    }
    
    func getTossupTimeSelected() -> Int {
        let index = tossupTimePicker.selectedRow(inComponent: 0)
        switch index {
        case 0: return 10
        case 1: return 15
        case 2: return 20
        case 3: return 25
        case 4: return 30
        default: return 0
        }
    }
    
    func getBonusTimeSelected() -> Int {
        let index = bonusTimePicker.selectedRow(inComponent: 0)
        switch index {
        case 0: return 10
        case 1: return 15
        case 2: return 20
        case 3: return 25
        case 4: return 30
        case 5: return 35
        case 6: return 40
        default: return 0
        }
    }
}
