import UIKit

struct RulesData {
    
    // Singleton
    static let shared = RulesData()
    private init() {}
    
    let items: [Rule] = [
        Rule(ruleNumber: 1,description: "Все игроки становятся в круг."),
        Rule(ruleNumber: 2, description: "Первый игрок берет телефон и нажимает кнопку: Старт игры"),
        Rule(ruleNumber: 3, description: "На экране появляется вопрос “Назовите Фрукт”."),
        Rule(ruleNumber: 4, description: "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку (правильность ответа определяют другие участники)."),
        Rule(ruleNumber: 5, description: "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба."),
        Rule(ruleNumber: 6, description: "Проигравшим считается тот, в чьих руках взорвалась бомба."),
        Rule(ruleNumber: 7, description: "Если в настройках выбран режим игры “С Заданиями”, то проигравший выполняет задание.")
    ]
    
    func calculateCellHeight(for text: String, tableView: UITableView) -> CGFloat {
            let labelWidth = tableView.bounds.width
            let labelInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            let labelHorizontalInsets = labelInsets.left + labelInsets.right
            let labelVerticalInsets = labelInsets.top + labelInsets.bottom
            
            let labelHeight = text.boundingRect(
                with: CGSize(width: labelWidth - labelHorizontalInsets,
                             height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], // Use your desired font
                context: nil
            ).height
            
            return labelHeight + labelVerticalInsets
        }
}
