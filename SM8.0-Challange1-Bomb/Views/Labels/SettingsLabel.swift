import UIKit

class SettingsLabel: UILabel {

    private let labelText : String
    
    init(labelText: String) {
        self.labelText = labelText
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .specialViolet
        textAlignment = .center
        font = .delaGothic20()
        translatesAutoresizingMaskIntoConstraints = false
        text = labelText
    }
}
