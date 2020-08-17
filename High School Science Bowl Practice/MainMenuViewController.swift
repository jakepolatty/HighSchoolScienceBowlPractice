//
//  MainMenuViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/20/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "High School Science Bowl Practice"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 39.0, weight: UIFont.Weight.heavy)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var quizModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quiz Mode", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(MainMenuViewController.startQuizMode), for: .touchUpInside)
        return button
    }()
    
    lazy var readerModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reader Mode", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(MainMenuViewController.startReaderMode), for: .touchUpInside)
        return button
    }()
    
    lazy var studyModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Study Mode", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(MainMenuViewController.startStudyMode), for: .touchUpInside)
        return button
    }()
    
    lazy var aboutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("About", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.light)
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(MainMenuViewController.openAboutPage), for: .touchUpInside)
        return button
    }()
    
    lazy var helpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Help", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.light)
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(MainMenuViewController.openHelpPage), for: .touchUpInside)
        return button
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            header.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(quizModeButton)
        NSLayoutConstraint.activate([
            quizModeButton.widthAnchor.constraint(equalToConstant: 150),
            quizModeButton.heightAnchor.constraint(equalToConstant: 44),
            quizModeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizModeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -35)
        ])
        
        view.addSubview(readerModeButton)
        NSLayoutConstraint.activate([
            readerModeButton.widthAnchor.constraint(equalToConstant: 150),
            readerModeButton.heightAnchor.constraint(equalToConstant: 44),
            readerModeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readerModeButton.topAnchor.constraint(equalTo: quizModeButton.bottomAnchor, constant: 25)
        ])
        
        view.addSubview(studyModeButton)
        NSLayoutConstraint.activate([
            studyModeButton.widthAnchor.constraint(equalToConstant: 150),
            studyModeButton.heightAnchor.constraint(equalToConstant: 44),
            studyModeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studyModeButton.topAnchor.constraint(equalTo: readerModeButton.bottomAnchor, constant: 25)
        ])
        
        view.addSubview(aboutButton)
        NSLayoutConstraint.activate([
            aboutButton.widthAnchor.constraint(equalToConstant: 44),
            aboutButton.heightAnchor.constraint(equalToConstant: 44),
            aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            aboutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(helpButton)
        NSLayoutConstraint.activate([
            helpButton.widthAnchor.constraint(equalToConstant: 44),
            helpButton.heightAnchor.constraint(equalToConstant: 44),
            helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            helpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 80),
            logoImage.heightAnchor.constraint(equalToConstant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -14)
        ])
    }
    
    @objc func startQuizMode() {
        let quizSettingsController = QuizSettingsViewController()
        let navigationController = UINavigationController(rootViewController: quizSettingsController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func startReaderMode() {
        let readerSettingsController = ReaderSettingsViewController()
        let navigationController = UINavigationController(rootViewController: readerSettingsController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func startStudyMode() {
        let studySettingsController = StudySettingsViewController()
        let navigationController = UINavigationController(rootViewController: studySettingsController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func openAboutPage() {
        let aboutPageController = AboutPageViewController()
        let navigationController = UINavigationController(rootViewController: aboutPageController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func openHelpPage() {
        let helpPageController = HelpPageViewController()
        let navigationController = UINavigationController(rootViewController: helpPageController)
        self.present(navigationController, animated: true, completion: nil)
    }
}
