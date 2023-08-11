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
    
    
    let settingsTableDataArray: [RulesPlusTaskTableViewDataModel] = [
        
        .init(buttonTitle: "Короткое", describtion: "Бомба взорвется в течении 10 секунд."),
        .init(buttonTitle: "Средние", describtion: "Бомба взорвется в течении 20 секунд."),
        .init(buttonTitle: "Длиное", describtion: "Бомба взорвется в течении 45 секунд."),
        .init(buttonTitle: "Случайное", describtion: "Бомба взорвется в течении 10-45 секунд.")
        
    ]
    
    
    static let shared = RulesViewController()
    
    let ruleIdentifier = "ruleID"
    
    let collectionCellID = "collectionID"
    
    let settingsCellID = "settingsCellID"
    
    private var contentSize: CGSize  {
        CGSize(width: view.frame.width, height: view.frame.height + 615 + 232 + 350)
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
    
    private var rulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private let categoryLabel: UILabel = {
        let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.text = "Категории"
        category.font = UIFont.delaGothic32()
        category.textColor = UIColor.specialViolet
        return category
    }()
    
    private let describtionOfGameLabel: UILabel = {
        let describtion = UILabel()
        describtion.translatesAutoresizingMaskIntoConstraints = false
        describtion.text = "В игре доступно 6 \n категорий и более \n 90 вопросов."
        describtion.font = UIFont.delaGothic24()
        describtion.textColor = UIColor.specialViolet
        describtion.numberOfLines = 0
        describtion.textAlignment = .center
        return describtion
    }()
    
    private let selectCategoryLabel: UILabel = {
        let select = UILabel()
        select.translatesAutoresizingMaskIntoConstraints = false
        select.text = "Можно выбрать \n сразу несколько \n категорий для игры."
        select.font = UIFont.delaGothic24()
        select.textColor = UIColor.specialViolet
        select.numberOfLines = 0
        select.textAlignment = .center
        return select
    }()
    
    private let colletctionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 178, height: 175)
        c.backgroundColor = .clear
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    
    private let settingsLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Настройки"
        lbl.font = .delaGothic20()
        lbl.textColor = UIColor.specialViolet
        
        return lbl
    }()
    
    lazy private var bombOptionsStackView = createOptionsSetting("В настройках игры можно \n задать время взрыва бомбы:")
    
    private var settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy private var ruleAfterBombActivated = createOptionsSetting("Если выбран режим “С Заданиями”,\n то после взрыва бомбы на экране \n будет появляться задание для \n проигравшего игрока.")
    
    private let additionalFeaturessettingsLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Также в настройках\n можно"
        lbl.font = .delaGothic20()
        lbl.textColor = UIColor.specialViolet
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        
        lbl.layer.shadowColor = UIColor.black.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0, height: 4) // Positive vertical value for lower shadow
        lbl.layer.shadowOpacity = 0.5
        lbl.layer.shadowRadius = 4
        
        return lbl
    }()
    
    lazy private var ruleAboutMusic = createOptionsSetting("Включить / Отключить фоновую \n музыку.")
    
    lazy private var ruleAboutSounds  = createOptionsSetting("Выбрать звуки для фоновой музыки, тиканья бомбы и взрыва.")
    
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
        contentStackView.addArrangedSubview(settingsLabel)
        contentStackView.addArrangedSubview(bombOptionsStackView)
        contentStackView.addArrangedSubview(settingTableView)
        contentStackView.addArrangedSubview(ruleAfterBombActivated)
        contentStackView.addArrangedSubview(additionalFeaturessettingsLabel)
        contentStackView.addArrangedSubview(ruleAboutMusic)
        contentStackView.addArrangedSubview(ruleAboutSounds)
        
    }
    
    private func setUpConstrains() {
        
        let rulesTableViewheight = tableViewHeightCalculate(rulesTableView) * 2.5
        
        let settingsTableViewHeight = tableViewHeightCalculate(settingTableView) * 1.65
        
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rulesTableView.heightAnchor.constraint(equalToConstant: rulesTableViewheight),
            rulesTableView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth - 40),
            
            colletctionView.heightAnchor.constraint(equalToConstant: 400),
            colletctionView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth - 20),
            
            settingsLabel.topAnchor.constraint(equalTo: colletctionView.bottomAnchor, constant: 30),
            settingsLabel.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            
            bombOptionsStackView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 15),
            bombOptionsStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            bombOptionsStackView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            settingTableView.topAnchor.constraint(equalTo: bombOptionsStackView.bottomAnchor, constant: 30),
            settingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            settingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            settingTableView.heightAnchor.constraint(equalToConstant: settingsTableViewHeight),
            
            ruleAfterBombActivated.topAnchor.constraint(equalTo: settingTableView.bottomAnchor, constant: 10),
            ruleAfterBombActivated.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            
            additionalFeaturessettingsLabel.topAnchor.constraint(equalTo: ruleAfterBombActivated.bottomAnchor, constant: 20),
            additionalFeaturessettingsLabel.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            
            ruleAboutMusic.topAnchor.constraint(equalTo: additionalFeaturessettingsLabel.bottomAnchor, constant: 20),
            ruleAboutMusic.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            ruleAboutMusic.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            ruleAboutSounds.topAnchor.constraint(equalTo: ruleAboutMusic.bottomAnchor, constant: 25),
            ruleAboutSounds.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            ruleAboutSounds.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            
        ])
        
    }
    
    private func tableViewHeightCalculate(_ tableView: UITableView) -> CGFloat {
        
        if tableView == rulesTableView {
            var totalHeight: CGFloat = 0
            
            for rule in RulesData.shared.items {
                totalHeight += RulesData.shared.calculateCellHeight(for: rule.description, tableView: rulesTableView)
            }
            
            return totalHeight
        } else {
            
            var settingTableViewTotalHeight: CGFloat = 0
            
            for setting in settingsTableDataArray {
                settingTableViewTotalHeight += RulesData.shared.calculateCellHeight(for: setting.describtion, tableView: settingTableView)
            }
            
            return settingTableViewTotalHeight
        }
        
        
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
        
        settingTableView.register(PlusTaskTableViewCell.self, forCellReuseIdentifier: settingsCellID)
    }
    
    
    private func createOptionsSetting(_ textOfLabel: String) -> UIStackView {
        
        let settingsOPtionsBombStackView: UIStackView = {
            let stack = UIStackView()
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 15
            
            return stack
        }()
        
        let optionDot: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .specialViolet
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 4.5
            view.heightAnchor.constraint(equalToConstant: 9).isActive = true
            view.widthAnchor.constraint(equalToConstant: 9).isActive = true
            return view
        }()
        
        
        let settingOptionLablel: UILabel = {
            let lbl = UILabel()
            
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.numberOfLines = 0
            lbl.textAlignment = .center
            lbl.textColor = .speciallightBlack
            lbl.font = .delaGothic16()
            lbl.text = textOfLabel
            
            
            return lbl
        }()
        
        
        settingsOPtionsBombStackView.addArrangedSubview(optionDot)
        settingsOPtionsBombStackView.addArrangedSubview(settingOptionLablel)
        
        
        NSLayoutConstraint.activate([
            
            optionDot.centerYAnchor.constraint(equalTo: settingsOPtionsBombStackView.centerYAnchor),
            optionDot.leadingAnchor.constraint(equalTo: settingsOPtionsBombStackView.leadingAnchor, constant: 30),
            
            settingOptionLablel.centerYAnchor.constraint(equalTo: settingsOPtionsBombStackView.centerYAnchor),
            //            settingOptionLablel.topAnchor.constraint(equalTo: optionDot.topAnchor),
            settingOptionLablel.leadingAnchor.constraint(equalTo: optionDot.trailingAnchor, constant: 15),
            
            
        ])
        
        
        
        
        return settingsOPtionsBombStackView
        
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
        
        
        settingTableView.backgroundColor = .clear
        settingTableView.separatorStyle = .none
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        
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
            return settingsTableDataArray.count
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
            
        } else {
            
            let cell = settingTableView.dequeueReusableCell(withIdentifier: settingsCellID, for: indexPath) as! PlusTaskTableViewCell
            
            let currentCell = settingsTableDataArray[indexPath.row]
            
            cell.cellData = currentCell
            
            
            return cell
        }
        
        
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





