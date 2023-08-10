//
//  RulesViewController + UITableViewDelegate.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ислам Пулатов on 8/9/23.
//

import UIKit

extension RulesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

