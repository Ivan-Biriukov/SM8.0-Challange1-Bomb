//
//  CategoryCustomCollectionViewCell.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ислам Пулатов on 8/9/23.
//

import UIKit

class CategoryCustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCustomCollectionViewCell"
    
    
    private let categoryImage: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = UIColor.black
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.specialYellow
        label.font = UIFont.delaGothic16()
        label.numberOfLines = 0
        
        
        return label
    }()
    
    private let selelected: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    public func configire(with image: UIImage, and textCategory: String) {
        
        categoryImage.image = image
        categoryLabel.text = textCategory
        
        setUpUI()
    }
    
    
    
    
    
    private func setUpUI() {
        
        backgroundColor = UIColor.specialViolet
        
        
        NSLayoutConstraint.activate([
        
            categoryImage.topAnchor.constraint(equalTo: topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            categoryLabel.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            
            
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryImage.image = nil
    }
    
    
}
