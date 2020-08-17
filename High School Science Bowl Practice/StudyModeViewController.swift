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
            if self.round == 0 {
                return QuestionJSONParser.shared.getRandomQuestion()
            } else {
                return QuestionJSONParser.shared.getQuestionForRound(self.round)
            }
        }
        if self.round == 0 {
            return QuestionJSONParser.shared.getQuestionForCategory(category)
        } else {
            return QuestionJSONParser.shared.getQuestionForCategory(category, andRound: self.round)
        }
    }()
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Back Chevron"), for: .normal)
        button.setTitle(" Menu", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular)
        button.sizeToFit()
        button.addTarget(self, action: #selector(StudyModeViewController.returnMainMenu), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var nextQuestionButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Forward Chevron"), for: .normal)
        button.setTitle("Next ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular)
        button.sizeToFit()
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.addTarget(self, action: #selector(StudyModeViewController.loadNextQuestion), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var roundSetNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.light)
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.text = "Question Set \(self.question.setNumber) Round \(self.question.roundNumber)"
        return label
    }()
    
    lazy var questionNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.light)
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.text = "Question \(self.question.questionNumber) \(self.question.questionType)"
        return label
    }()
    
    lazy var catTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.light)
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.text = "\(String(describing: self.question.category)) \(String(describing: self.question.answerType))"
        return label
    }()
    
    lazy var questionTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        label.textColor = UIColor.white
        label.text = self.question.questionText
        return label
    }()
    
    lazy var answerOptionsLabel: UILabel? = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.semibold)
        label.textColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        if let answerChoices = self.question.answerChoices {
            if answerChoices.count == 4 {
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Answer", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(StudyModeViewController.showAnswer), for: .touchUpInside)
        return button
    }()
    
    lazy var questionAnswerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.heavy)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
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
        view.backgroundColor = UIColor(red: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = nextQuestionButton
        self.navigationItem.leftBarButtonItem = mainMenuButton
        self.navigationItem.title = "Study Mode"
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(red: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
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
        
        scrollView.addSubview(showAnswerButton)
        NSLayoutConstraint.activate([
            showAnswerButton.heightAnchor.constraint(equalToConstant: 44),
            showAnswerButton.widthAnchor.constraint(equalToConstant: 120),
            showAnswerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        scrollView.addSubview(questionAnswerLabel)
        NSLayoutConstraint.activate([
            questionAnswerLabel.topAnchor.constraint(equalTo: showAnswerButton.topAnchor),
            questionAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        questionAnswerLabel.isHidden = true
        
        if let answerOptionsLabel = answerOptionsLabel {
            scrollView.addSubview(answerOptionsLabel)
            NSLayoutConstraint.activate([
                answerOptionsLabel.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 20),
                answerOptionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                answerOptionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                showAnswerButton.topAnchor.constraint(equalTo: answerOptionsLabel.bottomAnchor, constant: 30)
            ])
        } else {
            NSLayoutConstraint.activate([
                showAnswerButton.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 30)
            ])
        }
        
        let height: CGFloat
        if questionAnswerLabel.frame.height > showAnswerButton.frame.height {
            height = questionAnswerLabel.frame.origin.y + questionAnswerLabel.frame.height + 30
        } else {
            height = showAnswerButton.frame.origin.y + showAnswerButton.frame.height + 30
        }
        if height <= scrollView.frame.height {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        } else {
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: height)
        }
    }
    
    @objc func loadNextQuestion() {
        let nextQuestionController = StudyModeViewController(category: category, round: round)
        navigationController?.pushViewController(nextQuestionController, animated: true)
    }
    
    @objc func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func showAnswer() {
        showAnswerButton.isHidden = true
        questionAnswerLabel.isHidden = false
    }
}
