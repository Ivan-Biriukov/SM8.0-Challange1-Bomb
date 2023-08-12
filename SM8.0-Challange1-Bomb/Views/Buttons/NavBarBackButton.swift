import UIKit

class NavBarBackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        tintColor = .black
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        addTarget(self, action: #selector(didTaped), for: .touchUpInside)
    }
    
    @objc private func didTaped() {
        print("работает")
    }
}
