//
//  QuizModeViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import Foundation
import UIKit

extension Question {
    func getAnswerLetter() -> String {
        return String(self.answer.characters.first!)
    }
}

class QuizModeViewController: UIViewController {
    var category: Category?
    var statsTracker: QuizModeStats?
    var seconds: Int = 0
    var tossupTime: Int = 0
    var bonusTime: Int = 0
    var timer = Timer()
    var question: Question?
    
    lazy var finishSetButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Finish Set", style: .plain, target: self, action: #selector(QuizModeViewController.finishSet))
        return button
    }()
    
    lazy var nextQuestionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(QuizModeViewController.loadNextQuestion))
        return button
    }()
    
    lazy var roundSetNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        if let setNumber = self.question?.setNumber, let roundNumber = self.question?.roundNumber {
            label.text = "Question Set \(setNumber) Round \(roundNumber)"
        }
        return label
    }()
    
    lazy var questionNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        if let questionNumber = self.question?.questionNumber, let questionType = self.question?.questionType {
            label.text = "Question \(questionNumber) \(questionType)"
        }
        return label
    }()
    
    lazy var catTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        if let category = self.question?.category, let answerType = self.question?.answerType {
            label.text = "\(category) \(answerType)"
        }
        return label
    }()
    
    lazy var questionTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        label.text = self.question?.questionText
        return label
    }()
    
    lazy var optionWButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.question?.answerChoices?[0], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        button.titleLabel?.numberOfLines = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(QuizModeViewController.selectOptionW), for: .touchUpInside)
        return button
    }()
    
    lazy var optionXButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.question?.answerChoices?[1], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        button.titleLabel?.numberOfLines = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(QuizModeViewController.selectOptionX), for: .touchUpInside)
        return button
    }()
    
    lazy var optionYButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.question?.answerChoices?[2], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        button.titleLabel?.numberOfLines = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(QuizModeViewController.selectOptionY), for: .touchUpInside)
        return button
    }()
    
    lazy var optionZButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.question?.answerChoices?[3], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        button.titleLabel?.numberOfLines = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(QuizModeViewController.selectOptionZ), for: .touchUpInside)
        return button
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightThin)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        label.text = "\(self.seconds) Seconds Left"
        return label
    }()
    
    init(category: Category?, stats: QuizModeStats?, tossupTime: Int, bonusTime: Int) {
        self.category = category
        if let category = category {
            self.question = QuestionJSONParser.shared.getMCQuestionForCategory(category)
        } else {
            self.question = QuestionJSONParser.shared.getMCQuestion()
        }
        self.statsTracker = stats
        self.tossupTime = tossupTime
        self.bonusTime = bonusTime
        if self.question?.questionType == .tossup {
            self.seconds = tossupTime
        } else {
            self.seconds = bonusTime
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.navigationItem.leftBarButtonItem = finishSetButton
        self.navigationItem.title = "Quiz Mode"
        runTimer()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(roundSetNumLabel)
        NSLayoutConstraint.activate([
            roundSetNumLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            roundSetNumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        scrollView.addSubview(questionNumLabel)
        NSLayoutConstraint.activate([
            questionNumLabel.topAnchor.constraint(equalTo: roundSetNumLabel.bottomAnchor, constant: 10),
            questionNumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        scrollView.addSubview(catTypeLabel)
        NSLayoutConstraint.activate([
            catTypeLabel.topAnchor.constraint(equalTo: questionNumLabel.bottomAnchor, constant: 10),
            catTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        scrollView.addSubview(questionTextLabel)
        NSLayoutConstraint.activate([
            questionTextLabel.topAnchor.constraint(equalTo: catTypeLabel.bottomAnchor, constant: 10),
            questionTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        scrollView.addSubview(optionWButton)
        NSLayoutConstraint.activate([
            optionWButton.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 10),
            optionWButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionWButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            optionWButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.addSubview(optionXButton)
        NSLayoutConstraint.activate([
            optionXButton.topAnchor.constraint(equalTo: optionWButton.bottomAnchor, constant: 7),
            optionXButton.leadingAnchor.constraint(equalTo: optionWButton.leadingAnchor),
            optionXButton.trailingAnchor.constraint(equalTo: optionWButton.trailingAnchor),
            optionXButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.addSubview(optionYButton)
        NSLayoutConstraint.activate([
            optionYButton.topAnchor.constraint(equalTo: optionXButton.bottomAnchor, constant: 7),
            optionYButton.leadingAnchor.constraint(equalTo: optionXButton.leadingAnchor),
            optionYButton.trailingAnchor.constraint(equalTo: optionXButton.trailingAnchor),
            optionYButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.addSubview(optionZButton)
        NSLayoutConstraint.activate([
            optionZButton.topAnchor.constraint(equalTo: optionYButton.bottomAnchor, constant: 7),
            optionZButton.leadingAnchor.constraint(equalTo: optionYButton.leadingAnchor),
            optionZButton.trailingAnchor.constraint(equalTo: optionYButton.trailingAnchor),
            optionZButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: optionZButton.bottomAnchor, constant: 30)
        ])
        
        let height = timerLabel.frame.origin.y + timerLabel.frame.height + 30
        if height <= scrollView.frame.height {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        } else {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: height)
        }
    }
    
    func finishSet() {
        let statsController = QuizModeStatsViewController(stats: statsTracker)
        navigationController?.pushViewController(statsController, animated: true)
    }
    
    func disableButtons() {
        optionWButton.isEnabled = false
        optionXButton.isEnabled = false
        optionYButton.isEnabled = false
        optionZButton.isEnabled = false
        timer.invalidate()
    }
    
    func makeCorrectAnswerButtonGreen() {
        let answerletter = question?.getAnswerLetter()
        if answerletter == "W" {
            optionWButton.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        } else if answerletter == "X" {
            optionXButton.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        } else if answerletter == "Y" {
            optionYButton.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        } else if answerletter == "Z" {
            optionZButton.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        }
    }
    
    func optionSelected() {
        disableButtons()
        makeCorrectAnswerButtonGreen()
        self.navigationItem.rightBarButtonItem = nextQuestionButton
    }
    
    func selectOptionW() {
        optionSelected()
        timerLabel.isHidden = true
        if question?.getAnswerLetter() == "W" {
            statsTracker?.numberCorrect += 1
        } else {
            optionWButton.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
            statsTracker?.numberIncorrect += 1
        }
    }
    
    func selectOptionX() {
        optionSelected()
        timerLabel.isHidden = true
        if question?.getAnswerLetter() == "X" {
            statsTracker?.numberCorrect += 1
        } else {
            optionXButton.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
            statsTracker?.numberIncorrect += 1
        }
    }
    
    func selectOptionY() {
        optionSelected()
        timerLabel.isHidden = true
        if question?.getAnswerLetter() == "Y" {
            statsTracker?.numberCorrect += 1
        } else {
            optionYButton.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
            statsTracker?.numberIncorrect += 1
        }
    }
    
    func selectOptionZ() {
        optionSelected()
        timerLabel.isHidden = true
        if question?.getAnswerLetter() == "Z" {
            statsTracker?.numberCorrect += 1
        } else {
            optionZButton.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
            statsTracker?.numberIncorrect += 1
        }
    }
    
    func loadNextQuestion() {
        let nextQuestionController = QuizModeViewController(category: category, stats: statsTracker, tossupTime: tossupTime, bonusTime: bonusTime)
        navigationController?.pushViewController(nextQuestionController, animated: true)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuizModeViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds == 1 {
            timerLabel.text = "Time's Up"
            statsTracker?.numberNotAnswered += 1
            optionSelected()
        } else {
            seconds -= 1
            timerLabel.text = "\(seconds) Seconds Left"
        }
    }
}
