import UIKit

class RulesTableViewCell: UITableViewCell {
    
    var cellData: RulesTableViewDataModel? {
        didSet {
            self.numberLabel.text = cellData?.numberString
            self.discriptionLabel.text = cellData?.dicription
        }
    }
    
    private let circleContainer : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 29).isActive = true
        view.widthAnchor.constraint(equalToConstant: 29).isActive = true
        view.backgroundColor = .specialViolet
        view.layer.cornerRadius = 14.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let numberLabel : UILabel = {
        let lb = UILabel()
        lb.font = .delaGothic16()
        lb.textColor = .specialYellow
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let discriptionLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = .speciallightBlack
        lb.font = .delaGothic16()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let startButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Старт игры", for: .normal)
        btn.setTitleColor(.specialYellow, for: .normal)
        btn.backgroundColor = .specialViolet
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.heightAnchor.constraint(equalToConstant: 27).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 106).isActive = true
        btn.layer.cornerRadius = 13.5
        btn.isEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let container : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let attributedFirst = NSAttributedString(string: "Если в настройках выбран режим игры", attributes: [NSAttributedString.Key.font: UIFont.delaGothic16()!, NSAttributedString.Key.foregroundColor: UIColor.speciallightBlack])
    
    let attributedSecond = NSAttributedString(string: "С Заданиями", attributes: [NSAttributedString.Key.font: UIFont.delaGothic16()!, NSAttributedString.Key.foregroundColor: UIColor.specialViolet])
    
    let attributedThird = NSAttributedString(string: ",то проигравший выполняет задание.", attributes: [NSAttributedString.Key.font: UIFont.delaGothic16()!, NSAttributedString.Key.foregroundColor: UIColor.black])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(container)
        container.addSubview(circleContainer)
        circleContainer.addSubview(numberLabel)
        container.addSubview(discriptionLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            numberLabel.centerXAnchor.constraint(equalTo: circleContainer.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: circleContainer.centerYAnchor),
            
            circleContainer.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            circleContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            discriptionLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            discriptionLabel.leadingAnchor.constraint(equalTo: circleContainer.trailingAnchor, constant: 5),
            discriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
        ])
    }
    
    func addButtonToCell(bool : Bool) {
        if bool {
            container.addSubview(startButton)
            NSLayoutConstraint.activate([
                startButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                startButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15),
                discriptionLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -5),
            ])
        } else {
            NSLayoutConstraint.activate([discriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -15)])
        }
    }
    
    func changeLabelStyle(bool:Bool) {
        if bool {
            let combinedAttributedString = NSMutableAttributedString()
            
            let firstPartOfText = NSAttributedString(string: "Если в настройках выбран режим игры ",
                                                     attributes: [NSAttributedString.Key.font: UIFont.delaGothic16()!, NSAttributedString.Key.foregroundColor: UIColor.speciallightBlack])
            
            let secondPartOfText = NSAttributedString(string: "“С Заданиями” ",
                                                      attributes: [NSAttributedString.Key.font: UIFont.delaGothic16()!, NSAttributedString.Key.foregroundColor: UIColor.specialViolet])
            
            let thirdPartOfText = NSAttributedString(string: ",то проигравший выполняет задание.",
                                                     attributes: [NSAttributedString.Key.font: UIFont.delaGothic16()!, NSAttributedString.Key.foregroundColor: UIColor.black])
            
            combinedAttributedString.append(firstPartOfText)
            combinedAttributedString.append(secondPartOfText)
            combinedAttributedString.append(thirdPartOfText)
            
            self.discriptionLabel.attributedText = combinedAttributedString
        } else {
            self.discriptionLabel.attributedText = nil
            self.discriptionLabel.text = cellData?.dicription
        }
    }
}
