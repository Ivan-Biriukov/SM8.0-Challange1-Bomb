//
//  RulesViewController + UITableViewDataSource.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ислам Пулатов on 8/9/23.
//

import UIKit


extension RulesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rulesData = RulesData.shared.gameRules
        
        return rulesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rulesData = RulesData.shared.gameRules
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RulesCustomTableViewCell.identifierForRulesTable, for: indexPath) as? RulesCustomTableViewCell else { fatalError("The TableView could not dequeue in RulesViewController")}
        
        
        cell.configure(with: String(rulesData[indexPath.row].ruleNumber) , and: rulesData[indexPath.row].description)
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let titleHeight: CGFloat = 50.0
        
        return titleHeight + 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        headerView.backgroundColor = UIColor.clear
        
        let titleLabel: UILabel = {
            
            let title = UILabel()
            
            title.translatesAutoresizingMaskIntoConstraints = false
            title.text = "Правила Игры"
            title.font = UIFont.delaGothic32()
            title.textColor = UIColor.specialViolet
            
            return title
            
        }()
        
        
        headerView.addSubview(titleLabel)
        
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let rulesData = RulesData.shared.gameRules

        let dataModel = rulesData[indexPath.row].description

        let labelWidth = tableView.bounds.width - 16 * 2

        let labelInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        let labelHorizontalInsets = labelInsets.left + labelInsets.right

        let labelVerticalInsets = labelInsets.top + labelInsets.bottom

        let labelHeight = dataModel.boundingRect(
            with: CGSize(width: labelWidth - labelHorizontalInsets,
                         height: .greatestFiniteMagnitude),
                         options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: (UIFont.delaGothic24() ?? UIFont.systemFont(ofSize: 24)) as UIFont],
                         context: nil
        ).height

        let totalCellHeight = labelHeight + labelVerticalInsets + 13

        return totalCellHeight
    }

    
    
    
    
}

