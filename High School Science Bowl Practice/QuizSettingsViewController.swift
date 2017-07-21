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

class QuizSettingsViewController: UIViewController {
    static let lightGrey = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
    static let darkGrey = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = mainMenuButton
        self.navigationItem.title = "Quiz Mode"
        view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(topicHeader)
        NSLayoutConstraint.activate([
            topicHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30),
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
            startSetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            startSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func startQuizMode() {
        let category = getCategoryForToggle()
        let studyController = QuizModeViewController(category: category, stats: QuizModeStats())
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
}
