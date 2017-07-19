//
//  StudyModeViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/18/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class StudyModeViewController: UIViewController {
    var category: Category?
    var round: Int = 0
    lazy var question: Question = {
        guard let category = self.category else {
            return QuestionJSONParser.getRandomQuestion()
        }
        if self.round == 0 {
            return QuestionJSONParser.shared.getQuestionForCategory(category)
        } else {
            return QuestionJSONParser.shared.getQuestionForCategory(category, andRound: self.round)
        }
    }()
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Main Menu", style: .plain, target: self, action: #selector(StudyModeViewController.returnMainMenu))
        return button
    }()
    
    lazy var nextQuestionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Next Question", style: .plain, target: self, action: #selector(ReaderModeViewController.loadNextQuestion))
        return button
    }()
    
    lazy var roundSetNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.text = "Question Set \(self.question.setNumber) Round \(self.question.roundNumber)"
        return label
    }()
    
    lazy var questionNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.text = "Question \(self.question.questionNumber) \(self.question.questionType)"
        return label
    }()
    
    lazy var catTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.text = "\(String(describing: self.question.category)) \(String(describing: self.question.answerType))"
        return label
    }()
    
    lazy var questionTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium)
        label.textColor = UIColor.white
        label.text = self.question.questionText
        return label
    }()
    
    lazy var answerOptionsLabel: UILabel? = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightSemibold)
        label.textColor = UIColor(colorLiteralRed: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        if let answerChoices = self.question.answerChoices {
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
    
    lazy var showAnswerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Answer", for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        button.target(forAction: #selector(showAnswer), withSender: nil)
        return button
    }()
    
    lazy var questionAnswerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightHeavy)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        label.text = "Answer: \(self.question.answer)"
        return label
    }()
    
    init(category: Category?, round: Int) {
        self.category = category
        self.round = round
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(roundSetNumLabel)
        NSLayoutConstraint.activate([
            roundSetNumLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            roundSetNumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(questionNumLabel)
        NSLayoutConstraint.activate([
            questionNumLabel.topAnchor.constraint(equalTo: roundSetNumLabel.bottomAnchor, constant: 10),
            questionNumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(catTypeLabel)
        NSLayoutConstraint.activate([
            catTypeLabel.topAnchor.constraint(equalTo: questionNumLabel.bottomAnchor, constant: 10),
            catTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(questionTextLabel)
        NSLayoutConstraint.activate([
            questionTextLabel.topAnchor.constraint(equalTo: catTypeLabel.bottomAnchor, constant: 10),
            questionTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(showAnswerButton)
        NSLayoutConstraint.activate([
            showAnswerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30),
            showAnswerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
//        view.addSubview(questionAnswerLabel)
//        NSLayoutConstraint.activate([
//            questionAnswerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
//            questionAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            questionAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//        questionAnswerLabel.isHidden = true
        
        if let answerOptionsLabel = answerOptionsLabel {
            view.addSubview(answerOptionsLabel)
            NSLayoutConstraint.activate([
                answerOptionsLabel.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 20),
                answerOptionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                answerOptionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
    }
    
    func loadNextQuestion() {
        let nextQuestionController = StudyModeViewController(category: category, round: round)
        navigationController?.pushViewController(nextQuestionController, animated: true)
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func showAnswer() {
        showAnswerButton.isHidden = true
        //questionAnswerLabel.isHidden = false
    }
}
