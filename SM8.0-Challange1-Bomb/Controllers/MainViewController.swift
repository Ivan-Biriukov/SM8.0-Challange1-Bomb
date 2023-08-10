import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: K.Images.background)
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = -36
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = -20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var roundButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private let titleOne: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Игра для компании"
        label.textAlignment = .center
        label.font = .delaGothic32()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let titleBomb: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "БОМБА"
        label.textAlignment = .center
        label.font = .delaGothic48()
        label.textColor = .specialViolet
        label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private let logoImage: UIImageView = {
      let view = UIImageView()
        view.image = UIImage(named: K.Images.logoImage)
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    

    private lazy var gameStartButton = CustomButton(text: "Старт игры")
    private lazy var gameContinewButton = CustomButton(text: "Продолжить")
    private lazy var categoryButton = CustomButton(text: "Категории")
    
    private lazy var buttonSettings = RoundButton(image: K.Images.settingsLogo)
    private lazy var buttonHelp = RoundButton(image: K.Images.question)
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        addButtonsMethods()
        setUDDefaultsValuesForFirstAppLaunch()
    }
    
    // MARK: - Buttons Methods
    
    @objc private func startGameTaped() {
        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc private func continewTaped() {
        
    }
    
    @objc private func categoryTaped() {
        self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
    }
    
    @objc private func settingsTaped() {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc private func helpTaped() {
        self.navigationController?.pushViewController(RulesViewController(), animated: true)
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(contentStack)
        
        contentStack.addArrangedSubview(titleStack)
        titleStack.addArrangedSubview(titleOne)
        titleStack.addArrangedSubview(titleBomb)
        
        contentStack.addArrangedSubview(logoImage)
        contentStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(gameStartButton)
        buttonsStack.addArrangedSubview(gameContinewButton)
        buttonsStack.addArrangedSubview(categoryButton)
    
        view.addSubview(roundButtonsStack)
        roundButtonsStack.addArrangedSubview(buttonSettings)
        roundButtonsStack.addArrangedSubview(buttonHelp)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3),
            
            roundButtonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            roundButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            roundButtonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14)
        ])
    }
    
    private func addButtonsMethods() {
        gameStartButton.addTarget(self, action: #selector(startGameTaped), for: .touchUpInside)
        gameContinewButton.addTarget(self, action: #selector(continewTaped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryTaped), for: .touchUpInside)
        buttonSettings.addTarget(self, action: #selector(settingsTaped), for: .touchUpInside)
        buttonHelp.addTarget(self, action: #selector(helpTaped), for: .touchUpInside)
    }
}

