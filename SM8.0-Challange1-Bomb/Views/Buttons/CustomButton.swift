import UIKit

class CustomButton: UIButton {
    
    enum ButtonStatus {
        case enable
        case disable
    }
    
    private let text : String
    private let active : ButtonStatus
    
    init(text: String, active: ButtonStatus) {
        self.text = text
        self.active = active
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        if K.DeviceSizes.currentHeight <= 667 {
            self.heightAnchor.constraint(equalToConstant: (K.DeviceSizes.currentHeight / 12)).isActive = true
        } else {
            self.heightAnchor.constraint(equalToConstant: (K.DeviceSizes.currentHeight / 10.3417722)).isActive = true
        }

        self.widthAnchor.constraint(equalToConstant: (K.DeviceSizes.currentWidth / 1.36861314)).isActive = true
        setTitle(text, for: .normal)
        titleLabel?.font = .delaGothic24()
        layer.cornerRadius = ((K.DeviceSizes.currentHeight / 10.3417722) / 2)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
        
        switch active {
        case .enable:
            backgroundColor = .specialViolet
            setTitleColor(.specialYellow, for: .normal)
            isEnabled = true
        case.disable:
            backgroundColor = .systemGray
            setTitleColor(.systemGray6, for: .normal)
            isEnabled = false
        }
    }
    
    @objc private func didTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
}
