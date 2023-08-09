//
//  ViewController.swift
//  SM8.0-Challange1-Bomb
//
//  Created by иван Бирюков on 09.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let backgroundView: UIImageView = {
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
    
    let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    let titleOne: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Игра для компании"
        label.textAlignment = .center
        label.font = .delaGothic32()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let titleBomb: UILabel = {
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
    
    let logoImage: UIImageView = {
      let view = UIImageView()
        view.image = UIImage(named: K.Images.logoImage)
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let buttonOne = CustomButton(text: "Старт игры")
    let buttonTwo = CustomButton(text: "Продолжить")
    let buttonThree = CustomButton(text: "Категории")
    
    let buttonSettings = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(contentStack)
        
        contentStack.addArrangedSubview(titleStack)
        titleStack.addArrangedSubview(titleOne)
        titleStack.addArrangedSubview(titleBomb)
        
        contentStack.addArrangedSubview(logoImage)
        
        contentStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(buttonOne)
        buttonsStack.addArrangedSubview(buttonTwo)
        buttonsStack.addArrangedSubview(buttonThree)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3)
        ])
    }
}

