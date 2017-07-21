//
//  QuizModeViewController.swift
//  High School Science Bowl Practice
//
//  Created by Jake Polatty on 7/11/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import Foundation
import UIKit

class QuizModeViewController: UIViewController {
    var category: Category? = Category.physics
    lazy var question: Question = {
        guard let category = self.category else {
            return QuestionJSONParser.shared.getMCQuestion()
        }
        return QuestionJSONParser.shared.getMCQuestionForCategory(category)
    }()
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Main Menu", style: .plain, target: self, action: #selector(QuizModeViewController.returnMainMenu))
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
    
    lazy var optionWButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.question.answerChoices?[0], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
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
        button.setTitle(self.question.answerChoices?[1], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
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
        button.setTitle(self.question.answerChoices?[2], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
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
        button.setTitle(self.question.answerChoices?[3], for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightLight)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.addTarget(self, action: #selector(QuizModeViewController.selectOptionZ), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = mainMenuButton
        self.navigationItem.title = "Quiz Mode"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(roundSetNumLabel)
        NSLayoutConstraint.activate([
            roundSetNumLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30),
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
        
        view.addSubview(optionWButton)
        NSLayoutConstraint.activate([
            optionWButton.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 10),
            optionWButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionWButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            optionWButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        view.addSubview(optionXButton)
        NSLayoutConstraint.activate([
            optionXButton.topAnchor.constraint(equalTo: optionWButton.bottomAnchor, constant: 7),
            optionXButton.leadingAnchor.constraint(equalTo: optionWButton.leadingAnchor),
            optionXButton.trailingAnchor.constraint(equalTo: optionWButton.trailingAnchor),
            optionXButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        view.addSubview(optionYButton)
        NSLayoutConstraint.activate([
            optionYButton.topAnchor.constraint(equalTo: optionXButton.bottomAnchor, constant: 7),
            optionYButton.leadingAnchor.constraint(equalTo: optionXButton.leadingAnchor),
            optionYButton.trailingAnchor.constraint(equalTo: optionXButton.trailingAnchor),
            optionYButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        view.addSubview(optionZButton)
        NSLayoutConstraint.activate([
            optionZButton.topAnchor.constraint(equalTo: optionYButton.bottomAnchor, constant: 7),
            optionZButton.leadingAnchor.constraint(equalTo: optionYButton.leadingAnchor),
            optionZButton.trailingAnchor.constraint(equalTo: optionYButton.trailingAnchor),
            optionZButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func selectOptionW() {
        
    }
    
    func selectOptionX() {
        
    }
    
    func selectOptionY() {
        
    }
    
    func selectOptionZ() {
        
    }
}
