//
//  HelpPageViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/21/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Back Chevron"), for: .normal)
        button.setTitle(" Menu", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)
        button.sizeToFit()
        button.addTarget(self, action: #selector(AboutPageViewController.returnMainMenu), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var topHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This page provides information about the app's creation and licensing."
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightBold)
        return label
    }()
    
    lazy var appPurposeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This app is designed to help students and teams prepare for the National Science Bowl competiton."
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
        return label
    }()
    
    lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This app was created by Jake Polatty, co-captain of the Stanford University Online High School Science Bowl Team."
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightMedium)
        return label
    }()
    
    lazy var accreditationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "All practice questions used in the app are in the public domain and are taken from the Department of Energy's online database at science.energy.com."
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
        
        view.addSubview(appPurposeLabel)
        NSLayoutConstraint.activate([
            appPurposeLabel.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 10),
            appPurposeLabel.leadingAnchor.constraint(equalTo: topHeader.leadingAnchor, constant: 4),
            appPurposeLabel.trailingAnchor.constraint(equalTo: topHeader.trailingAnchor, constant: -4)
        ])
        
        view.addSubview(creatorLabel)
        NSLayoutConstraint.activate([
            creatorLabel.topAnchor.constraint(equalTo: appPurposeLabel.bottomAnchor, constant: 10),
            creatorLabel.leadingAnchor.constraint(equalTo: appPurposeLabel.leadingAnchor),
            creatorLabel.trailingAnchor.constraint(equalTo: appPurposeLabel.trailingAnchor)
        ])
        
        view.addSubview(accreditationLabel)
        NSLayoutConstraint.activate([
            accreditationLabel.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: 10),
            accreditationLabel.leadingAnchor.constraint(equalTo: creatorLabel.leadingAnchor),
            accreditationLabel.trailingAnchor.constraint(equalTo: creatorLabel.trailingAnchor)
        ])
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
