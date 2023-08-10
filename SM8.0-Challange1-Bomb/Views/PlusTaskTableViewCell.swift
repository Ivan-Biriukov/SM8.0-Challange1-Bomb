//
//  PlusTaskTableViewCell.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ислам Пулатов on 8/10/23.
//

//  MARK: - Font 14 button

import UIKit

class PlusTaskTableViewCell: UITableViewCell {

    var cellData: RulesPlusTaskTableViewDataModel? {
        didSet {
            
            self.button.setTitle(cellData?.buttonTitle, for: .normal)
            self.titleLabel.text = cellData?.describtion
        }
    }
    
    private let button: UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = .delaGothic16()
        btn.setTitleColor(UIColor.specialYellow, for: .normal)
        btn.backgroundColor = .specialViolet
        
        btn.heightAnchor.constraint(equalToConstant: 27).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 106).isActive = true
        
        btn.layer.cornerRadius = 13.5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        
        return btn
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .delaGothic16()
        lb.textColor = .speciallightBlack
        lb.textAlignment = .center
        lb.numberOfLines = 0
        
        return lb
    }()
    
    
    private let conteiner: UIView = {
        let iv = UIView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
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
        selectionStyle = .none
        
        contentView.addSubview(conteiner)
        conteiner.addSubview(button)
        conteiner.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
        
            conteiner.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteiner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteiner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conteiner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            button.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 5),
            button.leadingAnchor.constraint(equalTo: conteiner.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: conteiner.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: conteiner.bottomAnchor, constant: -5)
            
        ])
        
    }
    

}
