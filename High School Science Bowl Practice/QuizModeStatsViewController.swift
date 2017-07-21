//
//  QuizModeStatsViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/20/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class QuizModeStatsViewController: UIViewController {
    var stats: QuizModeStats?
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Main Menu", style: .plain, target: self, action: #selector(QuizModeStatsViewController.returnMainMenu))
        return button
    }()
    
    lazy var correctLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let numCorrect = self.stats?.numberCorrect {
            label.text = "Number Correct: \(numCorrect)"
        }
        return label
    }()
    
    lazy var incorrectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let numIncorrect = self.stats?.numberIncorrect {
            label.text = "Number Incorrect: \(numIncorrect)"
        }
        return label
    }()
    
    lazy var notAnsweredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if let numNotAnswered = self.stats?.numberNotAnswered {
            label.text = "Number Not Answered: \(numNotAnswered)"
        }
        return label
    }()
    
    init(stats: QuizModeStats?) {
        self.stats = stats
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.navigationItem.title = "Statistics"
        self.navigationItem.leftBarButtonItem = mainMenuButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(correctLabel)
        NSLayoutConstraint.activate([
            correctLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30),
            correctLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(incorrectLabel)
        NSLayoutConstraint.activate([
            incorrectLabel.topAnchor.constraint(equalTo: correctLabel.bottomAnchor, constant: 10),
            incorrectLabel.leadingAnchor.constraint(equalTo: correctLabel.leadingAnchor)
        ])
        
        view.addSubview(notAnsweredLabel)
        NSLayoutConstraint.activate([
            notAnsweredLabel.topAnchor.constraint(equalTo: incorrectLabel.bottomAnchor, constant: 10),
            notAnsweredLabel.leadingAnchor.constraint(equalTo: incorrectLabel.leadingAnchor)
        ])
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
