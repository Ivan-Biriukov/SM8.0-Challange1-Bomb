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
        self.heightAnchor.constraint(equalToConstant: (K.DeviceSizes.currentHeight / 10.3417722)).isActive = true
        self.widthAnchor.constraint(equalToConstant: (K.DeviceSizes.currentWidth / 1.36861314)).isActive = true
        setTitle(text, for: .normal)
        titleLabel?.font = .delaGothic24()
        layer.cornerRadius = ((K.DeviceSizes.currentHeight / 10.3417722) / 2)
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
