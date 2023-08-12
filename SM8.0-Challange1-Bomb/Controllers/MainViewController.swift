import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = -36
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = -20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var roundButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleOne: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Игра для компании"
        label.textAlignment = .center
        label.font = .delaGothic32()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    }()
    
    private let logoImage: UIImageView = {
      let view = UIImageView()
        view.image = UIImage(named: K.Images.logoImage)
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    private lazy var gameStartButton = CustomButton(text: "Старт игры", active: .enable)
    private lazy var gameContinewButton = CustomButton(text: "Продолжить", active: .disable)
    private lazy var categoryButton = CustomButton(text: "Категории", active: .enable)
    private lazy var buttonSettings = RoundButton(image: K.Images.settingsLogo)
    private lazy var buttonHelp = RoundButton(image: K.Images.question)
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gradientColor()
        addSubviews()
        setupConstraints()
        addButtonsMethods()
        setUDDefaultsValuesForFirstAppLaunch()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeContinewButton()
    }
    
    // MARK: - Buttons Methods
    
    @objc private func startGameTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            sender.alpha = 1
            self.navigationController?.pushViewController(GameViewController(gameIsPaused: false), animated: true)
        }
    }
    
    @objc private func continewTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            sender.alpha = 1
            self.navigationController?.pushViewController(GameViewController(gameIsPaused: true), animated: true)
        }
    }
    
    @objc private func categoryTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            sender.alpha = 1
            self.navigationController?.pushViewController(CategoriesViewController(), animated: true)
        }
    }
    
    @objc private func settingsTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            sender.alpha = 1
            self.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }
    }
    
    @objc private func helpTaped(_ sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            sender.alpha = 1
            self.navigationController?.pushViewController(RulesViewController(), animated: true)
        }
    }
    
    // MARK: - Configure UI
    
    private func addSubviews() {
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
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3),
            
            roundButtonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            roundButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            roundButtonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14)
        ])
    }
    
    private func addButtonsMethods() {
        gameStartButton.addTarget(self, action: #selector(startGameTaped(_:)), for: .touchUpInside)
        gameContinewButton.addTarget(self, action: #selector(continewTaped(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryTaped(_:)), for: .touchUpInside)
        buttonSettings.addTarget(self, action: #selector(settingsTaped(_:)), for: .touchUpInside)
        buttonHelp.addTarget(self, action: #selector(helpTaped(_:)), for: .touchUpInside)
    }
    
    private func changeContinewButton() {
        if UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.gameInProgress) {
            gameContinewButton.isEnabled = true
            gameContinewButton.backgroundColor = .specialViolet
            gameContinewButton.setTitleColor(.specialYellow, for: .normal)
        } else {
            gameContinewButton.isEnabled = false
            gameContinewButton.backgroundColor = .systemGray
            gameContinewButton.setTitleColor(.systemGray6, for: .normal)
        }
    }
}

