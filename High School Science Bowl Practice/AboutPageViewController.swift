//
//  HelpPageViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/21/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {
    var scrollView: UIScrollView = UIScrollView()
    
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
        label.text = "This app is designed to help students and teams prepare for Science Bowl competitons. This app is not sponsored by the National Science Bowl®, U.S. Department of Energy or the U.S. Government."
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
        label.text = "This app uses questions released by the National Science Bowl® that have been used at regional competitions in previous years. The questions taken from the National Science Bowl® website are the property of the Department of Energy and are available to the general public at no cost."
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
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(topHeader)
        NSLayoutConstraint.activate([
            topHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30),
            topHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        scrollView.addSubview(appPurposeLabel)
        NSLayoutConstraint.activate([
            appPurposeLabel.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 10),
            appPurposeLabel.leadingAnchor.constraint(equalTo: topHeader.leadingAnchor, constant: 4),
            appPurposeLabel.trailingAnchor.constraint(equalTo: topHeader.trailingAnchor, constant: -4)
        ])
        
        scrollView.addSubview(creatorLabel)
        NSLayoutConstraint.activate([
            creatorLabel.topAnchor.constraint(equalTo: appPurposeLabel.bottomAnchor, constant: 10),
            creatorLabel.leadingAnchor.constraint(equalTo: appPurposeLabel.leadingAnchor),
            creatorLabel.trailingAnchor.constraint(equalTo: appPurposeLabel.trailingAnchor)
        ])
        
        scrollView.addSubview(accreditationLabel)
        NSLayoutConstraint.activate([
            accreditationLabel.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: 10),
            accreditationLabel.leadingAnchor.constraint(equalTo: creatorLabel.leadingAnchor),
            accreditationLabel.trailingAnchor.constraint(equalTo: creatorLabel.trailingAnchor)
        ])
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
