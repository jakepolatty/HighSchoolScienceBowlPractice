//
//  QuizModeStatsViewController.swift
//  High School Science Bowl Practice
//
//  Created by David Polatty on 7/20/17.
//  Copyright © 2017 Jake Polatty. All rights reserved.
//

import UIKit
import Charts

class QuizModeStatsViewController: UIViewController {
    var stats: QuizModeStats?
    var category: Category?
    
    lazy var mainMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(QuizModeStatsViewController.returnMainMenu))
        return button
    }()
    
    lazy var topHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quiz Results"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold)
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightLight)
        if let category = self.category {
            label.text = "Category: \(category)"
        } else {
            label.text = "Category: All"
        }
        return label
    }()
    
    lazy var statsPieChart: PieChartView = {
        let pieChart = PieChartView()
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        pieChart.holeColor = UIColor.clear
        pieChart.transparentCircleColor = UIColor.clear
        let description = Description()
        description.text = ""
        pieChart.chartDescription = description
        pieChart.entryLabelColor = UIColor.white
        pieChart.entryLabelFont = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightLight)
        pieChart.legend.enabled = false
        return pieChart
    }()
    
    func setChart() {
        var dataEntries: [PieChartDataEntry] = []
        var colors: [UIColor] = []
        if let correct = stats?.numberCorrect{
            if correct > 0 {
                dataEntries.append(PieChartDataEntry(value: Double(correct), label: "Correct"))
                colors.append(UIColor(colorLiteralRed: 0.0, green: 1.0, blue: 0.0, alpha: 0.5))
            }
        }
        if let incorrect = stats?.numberIncorrect {
            if incorrect > 0 {
                dataEntries.append(PieChartDataEntry(value: Double(incorrect), label: "Incorrect"))
                colors.append(UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.5))
            }
        }
        if let notAnswered = stats?.numberNotAnswered {
            if notAnswered > 0 {
                dataEntries.append(PieChartDataEntry(value: Double(notAnswered), label: "Not Answered"))
                colors.append(UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.25))
            }
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        statsPieChart.data = pieChartData
    }
    
    init(stats: QuizModeStats?, category: Category?) {
        self.stats = stats
        self.category = category
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
        setChart()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(topHeader)
        NSLayoutConstraint.activate([
            topHeader.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30),
            topHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 15),
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(statsPieChart)
        NSLayoutConstraint.activate([
            statsPieChart.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            statsPieChart.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            statsPieChart.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            statsPieChart.heightAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
    }
    
    func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
