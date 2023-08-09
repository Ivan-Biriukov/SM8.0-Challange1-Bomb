import UIKit

class CustomButton: UIButton {
    
    private let text : String
    
    init(text: String) {
        self.text = text
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
        backgroundColor = .specialViolet
        setTitle(text, for: .normal)
        setTitleColor(.specialYellow, for: .normal)
        titleLabel?.font = .delaGothic24()
        layer.cornerRadius = ((K.DeviceSizes.currentHeight / 10.3417722) / 2)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
    }
    
    @objc private func didTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
}
