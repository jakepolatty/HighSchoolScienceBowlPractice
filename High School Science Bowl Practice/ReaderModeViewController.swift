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
    var questionTimer = Timer()
    var contentOffset: CGFloat = 0
    var scrollView: UIScrollView = UIScrollView()
    
    var isTimedRound: Bool = false
    var roundTimeRemaining: Int = 0
    var halfNum: Int = 0
    var isTimerRunning: Bool = false
    var roundTimer = Timer()
    
    lazy var mainMenuButton: UIBarButtonItem? = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Back Chevron"), for: .normal)
        button.setTitle(" Menu", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
        button.sizeToFit()
        button.addTarget(self, action: #selector(ReaderModeViewController.returnMainMenu), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var nextQuestionButton: UIBarButtonItem = {
        let count = self.questionSet?.count ?? 0
        let button: UIButton
        if self.index == count - 1 {
            button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "Forward Chevron"), for: .normal)
            button.setTitle("Finish Set ", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
            button.sizeToFit()
            button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.addTarget(self, action: #selector(ReaderModeViewController.finishSet), for: .touchUpInside)
        } else {
            button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "Forward Chevron"), for: .normal)
            button.setTitle("Next ", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
            button.sizeToFit()
            button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.addTarget(self, action: #selector(ReaderModeViewController.loadNextQuestion), for: .touchUpInside)
        }
        return UIBarButtonItem(customView: button)
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
    
    lazy var timerBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 89.0/255.0, green: 185.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        return view
    }()
    
    lazy var roundTimeHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightLight)
        label.textColor = UIColor.white
        label.text = "Round Timer:"
        return label
    }()
    
    lazy var roundTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightBold)
        label.textColor = UIColor.white
        label.text = "8:00 (Half 1)"
        return label
    }()
    
    lazy var roundTimerStartToggle: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Timer", for: .normal)
        button.setTitle("Pause", for: .selected)
        button.setBackgroundColor(color: UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5), forState: .normal)
        button.setBackgroundColor(color: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5), forState: .selected)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(ReaderModeViewController.toggleRoundTimer), for: .touchUpInside)
        return button
    }()
    
    init(questionSet: [Question], index: Int, tossupTime: Int, bonusTime: Int, isTimedRound: Bool, roundTimeRemaining: Int, halfNum: Int, isTimerRunning: Bool) {
        self.questionSet = questionSet
        self.index = index
        self.tossupTime = tossupTime
        self.bonusTime = bonusTime
        
        self.isTimedRound = isTimedRound
        if (isTimedRound) {
            self.roundTimeRemaining = roundTimeRemaining
            self.halfNum = halfNum
            self.isTimerRunning = isTimerRunning
        }
        
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
        
        if (isTimedRound) {
            view.addSubview(timerBar)
            NSLayoutConstraint.activate([
                timerBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                timerBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                timerBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                timerBar.heightAnchor.constraint(equalToConstant: 44)
            ])
            
            timerBar.addSubview(roundTimeHeader)
            NSLayoutConstraint.activate([
                roundTimeHeader.centerYAnchor.constraint(equalTo: timerBar.centerYAnchor),
                roundTimeHeader.leadingAnchor.constraint(equalTo: timerBar.leadingAnchor, constant: 10)
            ])
            
            timerBar.addSubview(roundTimeLabel)
            NSLayoutConstraint.activate([
                roundTimeLabel.centerYAnchor.constraint(equalTo: timerBar.centerYAnchor),
                roundTimeLabel.leadingAnchor.constraint(equalTo: roundTimeHeader.trailingAnchor, constant: 4)
            ])
            
            timerBar.addSubview(roundTimerStartToggle)
            NSLayoutConstraint.activate([
                roundTimerStartToggle.widthAnchor.constraint(equalToConstant: 100),
                roundTimerStartToggle.heightAnchor.constraint(equalToConstant: 35),
                roundTimerStartToggle.centerYAnchor.constraint(equalTo: timerBar.centerYAnchor),
                roundTimerStartToggle.trailingAnchor.constraint(equalTo: timerBar.trailingAnchor, constant: -10)
            ])
            
            view.addSubview(scrollView)
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: timerBar.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            view.addSubview(scrollView)
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
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
    
    // MARK: - Round Timer
    
    func toggleRoundTimer() {
        if (!roundTimerStartToggle.isSelected) {
            runRoundTimer()
            roundTimerStartToggle.isSelected = true
            roundTimerStartToggle.setTitle("Resume", for: .normal)
        } else {
            roundTimer.invalidate()
            isTimerRunning = false
            roundTimerStartToggle.isSelected = false
        }
    }
    
    func runRoundTimer() {
        isTimerRunning = true
        roundTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ReaderModeViewController.updateRoundTimer), userInfo: nil, repeats: true)
    }
    
    func updateRoundTimer() {
        if roundTimeRemaining == 1 {
            roundTimer.invalidate()
            isTimerRunning = false
            if (halfNum == 1) {
                roundTimeLabel.text = "Halftime"
            } else {
                roundTimeLabel.text = "Round Over"
            }
        } else {
            roundTimeRemaining -= 1
            let minutes = (roundTimeRemaining / 60) % 60
            let seconds = roundTimeRemaining % 60
            roundTimeLabel.text = String(format: "%i:%02i (Half %i)", minutes, seconds, halfNum)
        }
    }
    
    // MARK: - Navigation
    
    func loadNextQuestion() {
        if let questionSet = questionSet {
            let nextQuestionController = ReaderModeViewController(questionSet: questionSet, index: index+1, tossupTime: tossupTime, bonusTime: bonusTime, isTimedRound: isTimedRound, roundTimeRemaining: roundTimeRemaining, halfNum: halfNum, isTimerRunning: isTimerRunning)
            navigationController?.pushViewController(nextQuestionController, animated: true)
        }
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func finishSet() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Question Timer
    
    func startTimerPressed() {
        runTimer()
        startTimerButton.isHidden = true
        timerLabel.isHidden = false
    }
    
    func runTimer() {
        questionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ReaderModeViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds == 1 {
            questionTimer.invalidate()
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
