import UIKit

class RulesCustomTableViewCell: UITableViewCell {
    
    static let identifierForRulesTable = "rulesCell"

    private let ruleDescribtion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.delaGothic24()
        label.textColor = UIColor.specialGrey
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let ruleNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.delaGothic16()
        label.textColor = UIColor.specialYellow
        label.backgroundColor = UIColor.specialViolet
        label.textAlignment = .center
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 8
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with numberRule: String, and textLabel: String) {
        self.ruleNumber.text = numberRule
        
        let attributedText = NSMutableAttributedString(string: textLabel)
        
        if textLabel.contains("Старт игры") {
            let rangeToHighlight = (textLabel as NSString).range(of: "Старт игры")
            
            attributedText.addAttribute(.foregroundColor, value: UIColor.specialYellow, range: rangeToHighlight)
            
            let backgroundColor = UIColor.specialViolet
        
            attributedText.addAttribute(.backgroundColor, value: backgroundColor, range: rangeToHighlight)
            
        } else if textLabel.contains("“С Заданиями”") {
            
            let rangeToHighlight = (textLabel as NSString).range(of: "“С Заданиями”")
            
            attributedText.addAttribute(.foregroundColor, value: UIColor.specialViolet, range: rangeToHighlight)
        }
        self.ruleDescribtion.attributedText = attributedText
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.clear
        
        contentView.addSubview(ruleDescribtion)
        contentView.addSubview(ruleNumber)
        
        ruleDescribtion.translatesAutoresizingMaskIntoConstraints = false
        ruleNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ruleNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ruleNumber.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            ruleNumber.widthAnchor.constraint(equalToConstant: 29),
            ruleNumber.heightAnchor.constraint(equalToConstant: 29),
            ruleDescribtion.leadingAnchor.constraint(equalTo: ruleNumber.trailingAnchor, constant: 16),
            ruleDescribtion.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
