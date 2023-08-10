//
//  GameViewController.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Ilyas Tyumenev on 09.08.2023.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.Images.background)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let runLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите \"Запустить\", чтобы начать игру"
        label.font = .delaGothic28()
        label.textColor = .specialViolet
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bombImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.Images.bomb)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var runButton: UIButton = {
        let button = CustomButton(text: "Запустить")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(runButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomNavigationBar(title: "Игра")
        addButtonToNavBar()
        addSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(runLabel)
        view.addSubview(bombImageView)
        view.addSubview(runButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            runLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            runLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            runLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),

            bombImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 223),
            bombImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 11),
            bombImageView.widthAnchor.constraint(equalToConstant: 312),
            bombImageView.heightAnchor.constraint(equalToConstant: 352),

            runButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            runButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ])
    }
    
    private func createGif() {
        
        guard let gifPath = Bundle.main.path(forResource: "bombGif", ofType: "gif") else {
            print("Failed to find the GIF image.")
            return
        }

        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            print("Failed to load the GIF image data.")
            return
        }

        guard let gifImage = UIImage.gifImageWithData(gifData) else {
            print("Failed to create the GIF image.")
            return
        }

        // Set the loaded GIF image to the UIImageView
        bombImageView.image = gifImage
    }
}

// MARK: - Target Actions
extension GameViewController {

    @objc func runButtonPressed(_ button: UIButton) {
        print("runButtonPressed")
        createGif()
        runLabel.text = "Назовите вид зимнего спорта"
        runButton.isHidden = true
    }
}
