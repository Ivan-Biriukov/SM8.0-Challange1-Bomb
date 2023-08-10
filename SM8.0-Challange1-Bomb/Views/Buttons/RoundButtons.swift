import UIKit

class RoundButton: UIButton {
    
    private let image : String
    
    init(image: String) {
        self.image = image
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: (60)).isActive = true
        self.widthAnchor.constraint(equalToConstant: (60)).isActive = true
        setImage(UIImage(named: image), for: .normal)
        
        addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
    }
    
    @objc private func didTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
    }
}
