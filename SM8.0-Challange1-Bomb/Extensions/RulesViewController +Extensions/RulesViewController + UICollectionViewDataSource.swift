//
//  RulesViewController + UICollectionViewDataSource.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ислам Пулатов on 8/9/23.
//

import UIKit


extension RulesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let ruleData = RulesData.shared.selectCategory
        
        return ruleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ruleData = RulesData.shared.selectCategory
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCustomCollectionViewCell.identifier, for: indexPath) as? CategoryCustomCollectionViewCell else { fatalError("Failed to dequeue CategoryCustomCollectionViewCell in RulesViewController") }
        
        if let categoryImage = ruleData[indexPath.row].image {
            cell.configire(with: categoryImage, and: ruleData[indexPath.row].name)
        }
        
        
        
        return cell
    }
    
    
}
