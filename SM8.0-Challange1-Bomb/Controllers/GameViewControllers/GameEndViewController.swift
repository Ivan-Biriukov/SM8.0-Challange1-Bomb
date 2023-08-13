import UIKit

class GameEndViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    private var tasksArray = TasksDataModel.tasks.shuffled()
    private var gameWithTasksEnabled : Bool = UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.gameWithTasksBool)

    // MARK: - Properties
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Проигравший выполняет \nзадание"
        label.font = .delaGothic24()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let explosionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.Images.explosion)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let currentTaskLabel: UILabel = {
        let label = UILabel()
        label.font = .delaGothic20()
        label.textColor = .specialViolet
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextTaskButton: UIButton = {
        let button = CustomButton(text: "  Другое \nЗадание", active: .enable)
        button.titleLabel?.numberOfLines = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextTaskButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var startAgainButton: UIButton = {
        let button = CustomButton(text: "Начать \nЗаново", active: .enable)
        button.titleLabel?.numberOfLines = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startAgainButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gradientColor()
        createCustomNavigationBar(title: "Игра")
        addSubviews()
        setupConstraints()
        adaptiveUI()
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(backToInitial(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFirstTaskText()
        removeFirstTask()
        settingUIFromUD()
    }

    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(topLabel)
        view.addSubview(explosionImageView)
        view.addSubview(currentTaskLabel)
        view.addSubview(nextTaskButton)
        view.addSubview(startAgainButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),

            explosionImageView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 35),
            explosionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            explosionImageView.widthAnchor.constraint(equalToConstant: 265),
//            explosionImageView.heightAnchor.constraint(equalToConstant: 300),

            currentTaskLabel.topAnchor.constraint(equalTo: explosionImageView.bottomAnchor, constant: 35),
//            currentTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            currentTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            nextTaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextTaskButton.bottomAnchor.constraint(equalTo: startAgainButton.topAnchor, constant: -15),
            startAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            startAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49)
        ])
    }
    
    private func adaptiveUI() {
        if K.DeviceSizes.currentHeight <= 575 {
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
            topLabel.font = .delaGothic20()
            explosionImageView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth / 2).isActive = true
            explosionImageView.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentHeight / 4).isActive = true
            currentTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
            currentTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
            currentTaskLabel.font = .delaGothic16()
            startAgainButton.titleLabel?.font = .delaGothic14()
            nextTaskButton.titleLabel?.font = .delaGothic14()
            startAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        } else if K.DeviceSizes.currentHeight <= 667 {
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
            topLabel.font = .delaGothic20()
            explosionImageView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth / 2).isActive = true
            explosionImageView.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentHeight / 3).isActive = true
            currentTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
            currentTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
            currentTaskLabel.font = .delaGothic20()
            startAgainButton.titleLabel?.font = .delaGothic16()
            nextTaskButton.titleLabel?.font = .delaGothic16()
            startAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        } else {
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 105).isActive = true
            topLabel.font = .delaGothic20()
            explosionImageView.widthAnchor.constraint(equalToConstant: K.DeviceSizes.currentWidth / 2).isActive = true
            explosionImageView.heightAnchor.constraint(equalToConstant: K.DeviceSizes.currentHeight / 3).isActive = true
            currentTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            currentTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
//            currentTaskLabel.font = .delaGothic20()
//            startAgainButton.titleLabel?.font = .delaGothic16()
//            nextTaskButton.titleLabel?.font = .delaGothic16()
            startAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        }
    }
}

// MARK: - Target Actions

extension GameEndViewController {

    @objc func nextTaskButtonPressed(_ button: UIButton) {
        if tasksArray.first != nil {
            currentTaskLabel.text = tasksArray.first
            removeFirstTask()
        } else {
            updateTasks()
            currentTaskLabel.text = tasksArray.first
        }
    }

    @objc func startAgainButtonPressed(_ button: UIButton) {
        self.navigationController?.pushViewController(GameViewController(gameIsPaused: false), animated: true)
    }
    
    @objc func backToInitial(_ sender: AnyObject) {
         self.navigationController?.popToRootViewController(animated: true)
     }
    
    private func removeFirstTask() {
        tasksArray.removeFirst()
    }
    
    private func updateTasks() {
        tasksArray = TasksDataModel.tasks.shuffled()
    }
    
    private func setupFirstTaskText() {
        currentTaskLabel.text = tasksArray.first
    }
    
    private func settingUIFromUD() {
        if gameWithTasksEnabled {
            topLabel.text = "Проигравший выполняет \nзадание"
            currentTaskLabel.isHidden = false
            nextTaskButton.isHidden = false
        } else {
            topLabel.text = "Игра закончена"
            currentTaskLabel.isHidden = true
            nextTaskButton.isHidden = true
        }
    }
}
