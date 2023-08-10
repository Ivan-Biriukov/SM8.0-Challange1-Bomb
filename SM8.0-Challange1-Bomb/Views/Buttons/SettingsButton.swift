import UIKit

class SettingsButton: UIButton {
    
    enum ButtonStyle {
        case framed
        case framedSelected
        case black
    }

    private let text : String
    private let style : ButtonStyle
    
    init(text: String, style: ButtonStyle) {
        self.text = text
        self.style = style
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setTitle(text, for: .normal)
        titleLabel?.font = .delaGothic16()
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .framed :
            setTitleColor(.specialViolet, for: .normal)
            backgroundColor = .specialYellow
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 1.5
            self.heightAnchor.constraint(equalToConstant: (K.DeviceSizes.currentHeight / 21.3684211)).isActive = true
            self.widthAnchor.constraint(equalToConstant: (K.DeviceSizes.currentWidth / 2.5)).isActive = true
            layer.cornerRadius = ((K.DeviceSizes.currentHeight / 21.3684211) / 2)
        case .framedSelected:
            setTitleColor(.specialYellow, for: .normal)
            backgroundColor = .specialViolet
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 1.5
            self.heightAnchor.constraint(equalToConstant: (K.DeviceSizes.currentHeight / 21.3684211)).isActive = true
            self.widthAnchor.constraint(equalToConstant: (K.DeviceSizes.currentWidth / 2.5)).isActive = true
            layer.cornerRadius = ((K.DeviceSizes.currentHeight / 21.3684211) / 2)
        case .black :
            setTitleColor(.black, for: .normal)
            backgroundColor = .clear
        }

    }
}
