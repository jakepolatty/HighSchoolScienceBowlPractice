//
//  ReaderModeViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class ReaderModeViewController: UIViewController, UIScrollViewDelegate {
    var questionSet: [Question]?
    var index: Int = 0
    var seconds: Int = 0
    var tossupTime: Int = 0
    var bonusTime: Int = 0
    var timer = Timer()
    var contentOffset: CGFloat = 0
    var scrollView: UIScrollView = UIScrollView()
    
    lazy var mainMenuButton: UIBarButtonItem? = {
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(StudyModeViewController.returnMainMenu))
        return button
    }()
    
    lazy var nextQuestionButton: UIBarButtonItem = {
        let count = self.questionSet?.count ?? 0
        let button: UIBarButtonItem
        if self.index == count - 1 {
            button = UIBarButtonItem(title: "Finish Set", style: .done, target: self, action: #selector(ReaderModeViewController.finishSet))
        } else {
            button = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(ReaderModeViewController.loadNextQuestion))
        }
        return button
    }()
    
    lazy var roundSetNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        if let roundNum = self.questionSet?[self.index].roundNumber, let setNum = self.questionSet?[self.index].setNumber {
            label.text = "Question Set \(setNum) Round \(roundNum)"
        }
        return label
    }()
    
    lazy var questionNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        if let questionNum = self.questionSet?[self.index].questionNumber, let questionType = self.questionSet?[self.index].questionType {
            label.text = "Question \(questionNum) \(questionType)"
        }
        return label
    }()
    
    lazy var catTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        if let category = self.questionSet?[self.index].category, let answerType = self.questionSet?[self.index].answerType {
            label.text = "\(String(describing: category)) \(String(describing: answerType))"
        }
        return label
    }()
    
    lazy var questionTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        if let questionText = self.questionSet?[self.index].questionText {
            label.text = questionText
        }
        return label
    }()
    
    lazy var answerOptionsLabel: UILabel? = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightSemibold)
        label.textColor = UIColor(colorLiteralRed: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        if let answerChoices = self.questionSet?[self.index].answerChoices {
            if answerChoices.count > 0 {
                label.text = "\(answerChoices[0])\n\(answerChoices[1])\n\(answerChoices[2])\n\(answerChoices[3])"
                return label
            } else {
                return nil
            }
        } else {
            return nil
        }
    }()
    
    lazy var questionAnswerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightHeavy)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.95)
        if let answerText = self.questionSet?[self.index].answer {
            label.text = "Answer: \(answerText)"
        }
        return label
    }()
    
    lazy var startTimerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Timer", for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 63.0/255.0, alpha: 0.5)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(ReaderModeViewController.startTimerPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightThin)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        label.isHidden = true
        label.text = "\(self.seconds) Seconds Left"
        return label
    }()
    
    init(questionSet: [Question], index: Int, tossupTime: Int, bonusTime: Int) {
        self.questionSet = questionSet
        self.index = index
        self.tossupTime = tossupTime
        self.bonusTime = bonusTime
        if questionSet[index].questionType == .tossup {
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
        self.navigationItem.rightBarButtonItem = nextQuestionButton
        self.navigationItem.leftBarButtonItem = mainMenuButton
        self.navigationItem.title = "Reader Mode"
        scrollView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
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
        
        scrollView.addSubview(questionAnswerLabel)
        NSLayoutConstraint.activate([
            questionAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        scrollView.addSubview(startTimerButton)
        NSLayoutConstraint.activate([
            startTimerButton.widthAnchor.constraint(equalToConstant: 120),
            startTimerButton.heightAnchor.constraint(equalToConstant: 44),
            startTimerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startTimerButton.topAnchor.constraint(equalTo: questionAnswerLabel.bottomAnchor, constant: 10),
        ])
        
        scrollView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: startTimerButton.centerYAnchor)
        ])
        
        if let answerOptionsLabel = answerOptionsLabel {
            scrollView.addSubview(answerOptionsLabel)
            NSLayoutConstraint.activate([
                answerOptionsLabel.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 20),
                answerOptionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                answerOptionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                questionAnswerLabel.topAnchor.constraint(equalTo: answerOptionsLabel.bottomAnchor, constant: 30)
            ])
        } else {
            NSLayoutConstraint.activate([
                questionAnswerLabel.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 30)
            ])
        }
        
        let height = startTimerButton.frame.origin.y + startTimerButton.frame.height + 30
        if height <= scrollView.frame.height {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        } else {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: height)
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentOffset = CGPoint(x: 0, y: contentOffset)
    }
    
    func loadNextQuestion() {
        if let questionSet = questionSet {
            let nextQuestionController = ReaderModeViewController(questionSet: questionSet, index: index+1, tossupTime: tossupTime, bonusTime: bonusTime)
            navigationController?.pushViewController(nextQuestionController, animated: true)
        }
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func finishSet() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func startTimerPressed() {
        runTimer()
        startTimerButton.isHidden = true
        timerLabel.isHidden = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ReaderModeViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds == 1 {
            timer.invalidate()
            timerLabel.text = "Time's Up"
        } else {
            seconds -= 1
            timerLabel.text = "\(seconds) Seconds Left"
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset = scrollView.contentOffset.y
    }
}
