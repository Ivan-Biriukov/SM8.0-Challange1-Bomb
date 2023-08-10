//
//  RulesOfGameViewController.swift
//  Bomb
//
//  Created by Ислам Пулатов on 8/7/23.
//

import UIKit

class RulesViewController: UIViewController {
    
    static let shared = RulesViewController()
    
    let ruleIdentifier = "ruleID"
    
    
    private var contentSize: CGSize  {
        CGSize(width: view.frame.width, height: view.frame.height + 1253)
    }
    
    //    MARK: - UI Elements
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentSize
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        
        createCustomNavigationBar(title: "Помощь")
        view.backgroundColor = UIColor.gradientColor()
        
        setUpView()
        addSubViews()
        setUpConstrains()
        
        rulesTableView.register(RulesCustomTableViewCell.self, forCellReuseIdentifier: RulesCustomTableViewCell.identifierForRulesTable)
        rulesTableView.isScrollEnabled = false
    }
    
    // MARK: - Setup
    
    private func addSubViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(rulesTableView)
        contentStackView.addArrangedSubview(categoryLabel)
        contentStackView.addArrangedSubview(describtionOfGameLabel)
        contentStackView.addArrangedSubview(selectCategoryLabel)
        
    }
    
    private func setUpConstrains() {
        
        let heightTableView = tableViewHeightCalculate() * 5.1
        
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rulesTableView.heightAnchor.constraint(equalToConstant: heightTableView),
            rulesTableView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth - 40)
            
            
        ])
        
    }
    
    private func tableViewHeightCalculate() -> CGFloat {
        
        var totalHeight: CGFloat = 0
        
        for rule in RulesData.shared.items {
            totalHeight += RulesData.shared.calculateCellHeight(for: rule.description, tableView: rulesTableView)
        }
        
        return totalHeight
    }
    
    
    func setUpView() {
        
        // Navigation Bar
//        createCustomNavigationBar(title: "Помощь")
        
        // Background Image
        
        
        
        // ScrollView
//        scrollView = UIScrollView(frame: view.bounds)
        
//        view.addSubview(scrollView)
        
        //        MARK: TableView
        
        //        Calculating tableView Height
        
        
        
        
//        rulesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: totalTableViewHeight * 5.1), style: .grouped)
//        rulesTableView.reloadData()
//        rulesTableView.isScrollEnabled = false
        rulesTableView.backgroundColor = UIColor.clear
        rulesTableView.separatorStyle = .none
//        rulesTableView.register(RulesCustomTableViewCell.self, forCellReuseIdentifier: RulesCustomTableViewCell.identifierForRulesTable)
        rulesTableView.delegate = self
        rulesTableView.dataSource = self
        
        
        //         MARK: SubViews of UIScrollView
        
//        scrollView.addSubview(rulesTableView)
//        scrollView.addSubview(categoryLabel)
//        scrollView.addSubview(describtionOfGameLabel)
//        scrollView.addSubview(selectCategoryLabel)
        
        //        MARK: Contrains
        
//        NSLayoutConstraint.activate([
//
//            categoryLabel.topAnchor.constraint(equalTo: rulesTableView.bottomAnchor, constant: 16),
//            categoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//
//            describtionOfGameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 28),
//            describtionOfGameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//
//            selectCategoryLabel.topAnchor.constraint(equalTo: describtionOfGameLabel.bottomAnchor, constant: 28),
//            selectCategoryLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
//
//        ])
        
//        let scrollViewContentHeight = rulesTableView.frame.height + categoryLabel.frame.height + describtionOfGameLabel.frame.height + selectCategoryLabel.frame.height
//        
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: scrollViewContentHeight * 1.6)
        
    }
    
    
    
    
    
}
