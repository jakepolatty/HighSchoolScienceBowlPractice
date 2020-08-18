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
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Back Chevron"), for: .normal)
        button.setTitle(" Menu", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular)
        button.sizeToFit()
        button.addTarget(self, action: #selector(QuizModeStatsViewController.returnMainMenu), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var topHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quiz Results"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.bold)
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.light)
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
        pieChart.entryLabelFont = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.light)
        pieChart.legend.enabled = false
        return pieChart
    }()

    lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Results Available"
        label.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.light)
        if self.stats?.numberCorrect == 0 && self.stats?.numberIncorrect == 0 && self.stats?.numberNotAnswered == 0 {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
        return label
    }()
    
    func setChart() {
        var dataEntries: [PieChartDataEntry] = []
        var colors: [UIColor] = []
        if let correct = stats?.numberCorrect, let incorrect = stats?.numberIncorrect, let notAnswered = stats?.numberNotAnswered  {
            if correct > 0 {
                let correctEntry = PieChartDataEntry(value: Double(correct), label: "Correct")
                dataEntries.append(correctEntry)
                colors.append(UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5))
            }
            if incorrect > 0 {
                dataEntries.append(PieChartDataEntry(value: Double(incorrect), label: "Incorrect"))
                colors.append(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5))
            }
            if notAnswered > 0 {
                dataEntries.append(PieChartDataEntry(value: Double(notAnswered), label: "Not Answered"))
                colors.append(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25))
            }
        }

        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(dataSets: [pieChartDataSet])
        let format = NumberFormatter()
        format.maximumFractionDigits = 0
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
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
        view.backgroundColor = UIColor(red: 0.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1.0)
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
        
        view.addSubview(noResultsLabel)
        NSLayoutConstraint.activate([
            noResultsLabel.centerXAnchor.constraint(equalTo: statsPieChart.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: statsPieChart.centerYAnchor)
        ])
    }
    
    @objc func returnMainMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
