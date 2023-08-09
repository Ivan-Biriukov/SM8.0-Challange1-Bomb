//
//  RulesOfGameViewController.swift
//  Bomb
//
//  Created by Ислам Пулатов on 8/7/23.
//

import UIKit

class RulesViewController: UIViewController {
    
    var totalTableViewHeight: CGFloat = 0
    
    //    MARK: - UI Elements
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var rulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let categoryLabel: UILabel = {
        
        let category = UILabel()
        
        category.translatesAutoresizingMaskIntoConstraints = false
        category.text = "Категории"
        category.font = UIFont.delaGothic32()
        category.textColor = UIColor.specialViolet
        
        return category
        
    }()
    
    let describtionOfGameLabel: UILabel = {
        
        let describtion = UILabel()
        
        describtion.translatesAutoresizingMaskIntoConstraints = false
        describtion.text = "В игре доступно 6 \n категорий и более \n 90 вопросов."
        describtion.font = UIFont.delaGothic24()
        describtion.textColor = UIColor.specialViolet
        describtion.numberOfLines = 0
        describtion.textAlignment = .center
        
        return describtion
        
    }()
    
    let selectCategoryLabel: UILabel = {
        
        let select = UILabel()
        
        select.translatesAutoresizingMaskIntoConstraints = false
        select.text = "Можно выбрать \n сразу несколько \n категорий для игры."
        select.font = UIFont.delaGothic24()
        select.textColor = UIColor.specialViolet
        select.numberOfLines = 0
        select.textAlignment = .center
        
        return select
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Setup
    
    func setUpView() {
        
        // Navigation Bar
        createCustomNavigationBar(title: "Помощь")
        
        // Background Image
        
        view.backgroundColor = UIColor.gradientColor()
        
        // ScrollView
        scrollView = UIScrollView(frame: view.bounds)
        
        view.addSubview(scrollView)
        
        //        MARK: TableView
        
        //        Calculating tableView Height
        for rule in RulesData.shared.items {
            totalTableViewHeight += RulesData.shared.calculateCellHeight(for: rule.description, tableView: rulesTableView)
        }
        
        rulesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: totalTableViewHeight * 5.1), style: .grouped)
        rulesTableView.reloadData()
        rulesTableView.isScrollEnabled = false
        rulesTableView.backgroundColor = UIColor.clear
        rulesTableView.separatorStyle = .none
        rulesTableView.register(RulesCustomTableViewCell.self, forCellReuseIdentifier: RulesCustomTableViewCell.identifierForRulesTable)
        rulesTableView.delegate = self
        rulesTableView.dataSource = self
        
        
        //         MARK: SubViews of UIScrollView
        
        scrollView.addSubview(rulesTableView)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(describtionOfGameLabel)
        scrollView.addSubview(selectCategoryLabel)
        
        //        MARK: Contrains
        
        NSLayoutConstraint.activate([
            
            categoryLabel.topAnchor.constraint(equalTo: rulesTableView.bottomAnchor, constant: 16),
            categoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            describtionOfGameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 28),
            describtionOfGameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            selectCategoryLabel.topAnchor.constraint(equalTo: describtionOfGameLabel.bottomAnchor, constant: 28),
            selectCategoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ])
        
        let scrollViewContentHeight = rulesTableView.frame.height + categoryLabel.frame.height + describtionOfGameLabel.frame.height + selectCategoryLabel.frame.height
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: scrollViewContentHeight * 1.6)
        
    }
    
    
    
    
    
}
