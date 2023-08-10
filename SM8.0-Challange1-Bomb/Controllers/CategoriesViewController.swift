import UIKit

class CategoriesViewController: UIViewController {
    
    private var cellDataArray : [CategoryesDataModel] = [
        .init(imageName: K.Images.aboutLife, titleLabel: "О Разном", chechMarkSelected: false),
        .init(imageName: K.Images.sportAndHobby, titleLabel: "Спорт и Хобби", chechMarkSelected: false),
        .init(imageName: K.Images.aboutLife, titleLabel: "Про Жизнь", chechMarkSelected: true),
        .init(imageName: K.Images.fameos, titleLabel: "Знаменитости", chechMarkSelected: true),
        .init(imageName: K.Images.artAndCinema, titleLabel: "Искусство и Кино", chechMarkSelected: false),
        .init(imageName: K.Images.nature, titleLabel: "Природа", chechMarkSelected: false)
    ]
    
    // MARK: - UIElements
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 178, height: 175)
        c.backgroundColor = .clear
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    let backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCustomNavigationBar(title: "Категории")
        setupViews()
        setupConstraints()
        configureCollection()
    }
    
    // MARK: - Configure UI
    
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
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
        ])
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

// MARK: - CollectionView Delegate & DataSource

extension CategoriesViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentItemChecked = cellDataArray[indexPath.row].chechMarkSelected
        self.cellDataArray[indexPath.row].chechMarkSelected = !currentItemChecked
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryesCollectionViewCell
        
        let currentCell = cellDataArray[indexPath.row]
        
        cell.cellData = currentCell
        cell.addCheckMark(isOn: currentCell.chechMarkSelected)
        
        return cell
    }
}

