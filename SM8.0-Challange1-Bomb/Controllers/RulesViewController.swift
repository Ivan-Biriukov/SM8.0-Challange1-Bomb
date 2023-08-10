//
//  RulesOfGameViewController.swift
//  Bomb
//
//  Created by Ислам Пулатов on 8/7/23.
//

import UIKit

class RulesViewController: UIViewController {
    
    let dataArray : [RulesTableViewDataModel] = [
        .init(numberString: "1", dicription: "Все игроки становятся в круг.", buttonNeeded: false, attributedStringNeeded: false),
        .init(numberString: "2", dicription: "Первый игрок берет телефон и нажимает кнопку:", buttonNeeded: true, attributedStringNeeded: false),
        .init(numberString: "3", dicription: "На экране появляется вопрос “Назовите Фрукт”.", buttonNeeded: false, attributedStringNeeded: false),
        .init(numberString: "4", dicription: "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку (правильность ответа определяют другие участники).", buttonNeeded: false, attributedStringNeeded: false),
        .init(numberString: "5", dicription: "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба.", buttonNeeded: false, attributedStringNeeded: false),
        .init(numberString: "6", dicription: "Проигравшим считается тот, в чьих руках взорвалась бомба.", buttonNeeded: false, attributedStringNeeded: false),
        .init(numberString: "7", dicription: "Если в настройках выбран режим игры “С Заданиями”, то проигравший выполняет задание.", buttonNeeded: false, attributedStringNeeded: true)
    ]
    
    
    let collectionDataArray : [CategoryesDataModel] = [
        .init(imageName: K.Images.nature, titleLabel: "Природа", chechMarkSelected: true),
        .init(imageName: K.Images.artAndCinema, titleLabel: "Искусство и Кино", chechMarkSelected: true),
        .init(imageName: K.Images.aboutLife, titleLabel: "О Разном", chechMarkSelected: true),
        .init(imageName: K.Images.sportAndHobby, titleLabel: "Спорт и Хобби", chechMarkSelected: true)
    ]
    
    
    let timeTableDataArray: [RulesPlusTaskTableViewDataModel] = [
    
        .init(buttonTitle: "Короткое", describtion: "Бомба взорвется в течении 10 секунд."),
        .init(buttonTitle: "Средние", describtion: "Бомба взорвется в течении 20 секунд."),
        .init(buttonTitle: "Длиное", describtion: "Бомба взорвется в течении 45 секунд."),
        .init(buttonTitle: "Случайное", describtion: "Бомба взорвется в течении 10-45 секунд.")
    
    ]
    
    
    static let shared = RulesViewController()
    
    let ruleIdentifier = "ruleID"
    
    let collectionCellID = "collectionID"
    
    private var contentSize: CGSize  {
        CGSize(width: view.frame.width, height: view.frame.height + 615)
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
    
    let colletctionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 178, height: 175)
        c.backgroundColor = .clear
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomNavigationBar(title: "Помощь")
        view.backgroundColor = UIColor.gradientColor()
        
        setUpView()
        addSubViews()
        setUpConstrains()
        setUpDelegates()
        registerCells()
        
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
        contentStackView.addArrangedSubview(colletctionView)
        
    }
    
    private func setUpConstrains() {
        
        let heightTableView = tableViewHeightCalculate() * 2.5
        
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rulesTableView.heightAnchor.constraint(equalToConstant: heightTableView),
            rulesTableView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth - 40),
            
            colletctionView.heightAnchor.constraint(equalToConstant: 400),
            colletctionView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth - 20)
            
            
        ])
        
    }
    
    private func tableViewHeightCalculate() -> CGFloat {
        
        var totalHeight: CGFloat = 0
        
        for rule in RulesData.shared.items {
            totalHeight += RulesData.shared.calculateCellHeight(for: rule.description, tableView: rulesTableView)
        }
        
        return totalHeight
    }
    
    
    private func setUpDelegates() {
        
        rulesTableView.dataSource = self
        rulesTableView.delegate = self
        
        colletctionView.dataSource = self
        colletctionView.delegate = self
        
    }
    
    private func registerCells() {
        
        rulesTableView.register(RulesTableViewCell.self, forCellReuseIdentifier: ruleIdentifier)
        
        colletctionView.register(CategoryesCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        
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


//  MARK: - TableViewDelegates DataSource

extension RulesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == rulesTableView {
            return dataArray.count
        } else {
            return timeTableDataArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView == rulesTableView {
            
            let cell = rulesTableView.dequeueReusableCell(withIdentifier: ruleIdentifier, for: indexPath) as! RulesTableViewCell
            
            let currentCell = dataArray[indexPath.row]
            cell.cellData = currentCell
            cell.addButtonToCell(bool: currentCell.buttonNeeded)
            cell.changeLabelStyle(bool: currentCell.attributedStringNeeded)
            
            return cell
            
        }
        
        
        return UITableViewCell()
    }
    
    
    
    
}


//  MARK: - CollectionViewDelegates DataSource

extension RulesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! CategoryesCollectionViewCell
        let currentCell = collectionDataArray[indexPath.row]
        cell.cellData = currentCell
        cell.addCheckMark(isOn: currentCell.chechMarkSelected)

        
        
        return cell
        
    }
    
    
    
    
}





