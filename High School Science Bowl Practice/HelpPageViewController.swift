//
//  AboutPageViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/21/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class HelpPageViewController: UIViewController {
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(HelpPageViewController.returnMainMenu))
        return button
    }()
    
    lazy var topHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This help page provides information about the app's different modes and settings."
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightBold)
        return label
    }()
    
    lazy var quizModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Quiz Mode: Multiple-choice only quiz mode that tests your knowledge against a clock and tracks statistics of your performance. You can select any category or pull questions from all categories (random option), and can also choose the time limits for tossup and bonus questions."
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
        return label
    }()
    
    lazy var readerModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Reader Mode: Designed for coaches and team leaders to use in meetings to run practice rounds. You can select any specific set from the online database by the set number and round, and can set custom time limits."
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
        return label
    }()
    
    lazy var studyModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Study Mode: Casual mode used for studying questions without a time limit. You can select any category (or all categories) and any round difficulty level (or allow questions from all rounds)."
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.navigationItem.title = "About"
        self.navigationItem.leftBarButtonItem = mainMenuButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(topHeader)
        NSLayoutConstraint.activate([
            topHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30),
            topHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(quizModeLabel)
        NSLayoutConstraint.activate([
            quizModeLabel.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 10),
            quizModeLabel.leadingAnchor.constraint(equalTo: topHeader.leadingAnchor, constant: 4),
            quizModeLabel.trailingAnchor.constraint(equalTo: topHeader.trailingAnchor, constant: -4)
        ])
        
        view.addSubview(readerModeLabel)
        NSLayoutConstraint.activate([
            readerModeLabel.topAnchor.constraint(equalTo: quizModeLabel.bottomAnchor, constant: 10),
            readerModeLabel.leadingAnchor.constraint(equalTo: quizModeLabel.leadingAnchor),
            readerModeLabel.trailingAnchor.constraint(equalTo: quizModeLabel.trailingAnchor)
        ])
        
        view.addSubview(studyModeLabel)
        NSLayoutConstraint.activate([
            studyModeLabel.topAnchor.constraint(equalTo: readerModeLabel.bottomAnchor, constant: 10),
            studyModeLabel.leadingAnchor.constraint(equalTo: readerModeLabel.leadingAnchor),
            studyModeLabel.trailingAnchor.constraint(equalTo: readerModeLabel.trailingAnchor)
        ])
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
