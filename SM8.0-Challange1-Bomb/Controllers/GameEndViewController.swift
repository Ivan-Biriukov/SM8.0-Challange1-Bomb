//
//  GameEndViewController.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ilyas Tyumenev on 09.08.2023.
//

import UIKit

class GameEndViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private var tasksArray = TasksDataModel.tasks.shuffled()

    // MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.Images.background)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

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
        label.text = "В следующем раунде после каждого ответа хлопать в ладоши"
        label.font = .delaGothic20()
        label.textColor = .specialViolet
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextTaskButton: UIButton = {
        let button = CustomButton(text: "Другое Задание", active: .enable)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextTaskButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var startAgainButton: UIButton = {
        let button = CustomButton(text: "Начать Заново", active: .enable)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startAgainButtonPressed), for: .touchUpInside)
        return button
    }()



    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomNavigationBar(title: "Игра")
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults.set(false, forKey: K.UserDefaultsKeys.gameInProgress)
    }

    // MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(topLabel)
        view.addSubview(explosionImageView)
        view.addSubview(currentTaskLabel)
        view.addSubview(nextTaskButton)
        view.addSubview(startAgainButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),

            explosionImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 166),
            explosionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            explosionImageView.widthAnchor.constraint(equalToConstant: 249),
            explosionImageView.heightAnchor.constraint(equalToConstant: 300),

            currentTaskLabel.topAnchor.constraint(equalTo: explosionImageView.bottomAnchor, constant: 20),
            currentTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            currentTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),

            nextTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
            nextTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -143),

            startAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
            startAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49)
        ])
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
        print("startAgainButtonPressed")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func removeFirstTask() {
        tasksArray.removeFirst()
    }
    
    private func updateTasks() {
        tasksArray = TasksDataModel.tasks.shuffled()
    }
}
