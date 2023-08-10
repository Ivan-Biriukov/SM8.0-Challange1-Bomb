//
//  TestTableViewCell.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ислам Пулатов on 8/10/23.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    var cellData: Rule? {
        didSet {
            self.ruleNumber.text = "1"
            self.ruleDescribtion.text = cellData?.description
        }
    }
    
//    private let ruleNumber: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.delaGothic16()
//        label.textColor = UIColor.specialYellow
//        label.backgroundColor = UIColor.specialViolet
//        label.textAlignment = .center
//        label.layer.cornerRadius = 14
//        label.layer.masksToBounds = true
//        label.layer.borderWidth = 1.0
//        label.layer.borderColor = UIColor.black.cgColor
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowOpacity = 0.5
//        label.layer.shadowOffset = CGSize(width: 0, height: 2)
//        label.layer.shadowRadius = 8
//        return label
//    }()
    
    private let ruleNumber: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.delaGothic16()
        
        return label
    }()
    
    private let ruleDescribtion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.delaGothic24()
        label.textColor = UIColor.specialGrey
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let cellStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUp() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(cellStackView)
        
        cellStackView.addArrangedSubview(ruleNumber)
        cellStackView.addArrangedSubview(ruleDescribtion)
        
        NSLayoutConstraint.activate([
        
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }
    
}
