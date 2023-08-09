//
//  CategoriesViewController.swift
//  SM8.0-Challange1-Bomb
//
//  Created by Elizaveta Eremyonok on 09.08.2023.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.itemSize = CGSize(width: 100, height: 100)
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
           return collectionView
    }()
    
    let reuseIdentifier = "Cell"

   let backgroundView: UIImageView = {
       let view = UIImageView()
       view.image = UIImage(named: "background")
       view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
   }()


    override func viewDidLoad() {
        createCustomNavigationBar(title: "Категории")
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
    

    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
            
        let imageName: String
                let title: String
                switch indexPath.item {
                    case 0:
                    imageName = K.Images.diference
                        title = "О Разном"
                    case 1:
                        imageName = "image 2"
                        title = "Спорт и Хобби"
                    case 2:
                        imageName = "image 3"
                        title = "Про Жизнь"
                    case 3:
                        imageName = "image 4"
                        title = "Знаменитости"
                    case 4:
                        imageName = "image 5"
                        title = "Исскусство и Кино"
                    case 5:
                        imageName = "image 10"
                        title = "Природа"
                    default:
                        imageName = "image 10"
                        title = "По умолчанию"
                }
           
        cell.configure(imageName: imageName, title: title, backgroundColor: .specialViolet)
                
                return cell
        }
    }

class CustomCollectionViewCell: UICollectionViewCell {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String, title: String, backgroundColor: UIColor) {
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = backgroundColor
        
        titleLabel.text = title
    }
}
