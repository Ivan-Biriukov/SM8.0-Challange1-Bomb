import UIKit

class CategoriesViewController: UIViewController {
    private let defaults = UserDefaults.standard
    
    private var cellDataArray : [CategoryesDataModel] = [
        .init(imageName: K.Images.aboutLife, titleLabel: "О Разном", chechMarkSelected: UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.aboutAllCategoryChoosen)),
        .init(imageName: K.Images.sportAndHobby, titleLabel: "Спорт и Хобби", chechMarkSelected: UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.sportAndHobbyCathegoryChoosen)),
        .init(imageName: K.Images.aboutLife, titleLabel: "Про Жизнь", chechMarkSelected: UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.lifeCategoryChoosen)),
        .init(imageName: K.Images.fameos, titleLabel: "Знаменитости", chechMarkSelected: UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.fameosCategoryChoosen)),
        .init(imageName: K.Images.artAndCinema, titleLabel: "Искусство и Кино", chechMarkSelected: UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.artAndCinemaCategoryChoosen)),
        .init(imageName: K.Images.nature, titleLabel: "Природа", chechMarkSelected: UserDefaults.standard.bool(forKey: K.UserDefaultsKeys.natureCategoryChoosen))
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
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gradientColor()
        createCustomNavigationBar(title: "Категории")
        setupViews()
        setupConstraints()
        configureCollection()
    }
    
    // MARK: - Configure UI
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
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
        let currentValue = cellDataArray[indexPath.row].chechMarkSelected
        
        switch indexPath.row {
        case 0:
            self.cellDataArray[indexPath.row].chechMarkSelected = !currentValue
            defaults.set(!currentValue, forKey: K.UserDefaultsKeys.aboutAllCategoryChoosen)
        case 1:
            self.cellDataArray[indexPath.row].chechMarkSelected = !currentValue
            defaults.set(!currentValue, forKey: K.UserDefaultsKeys.sportAndHobbyCathegoryChoosen)
        case 2:
            self.cellDataArray[indexPath.row].chechMarkSelected = !currentValue
            defaults.set(!currentValue, forKey: K.UserDefaultsKeys.lifeCategoryChoosen)
        case 3:
            self.cellDataArray[indexPath.row].chechMarkSelected = !currentValue
            defaults.set(!currentValue, forKey: K.UserDefaultsKeys.fameosCategoryChoosen)
        case 4:
            self.cellDataArray[indexPath.row].chechMarkSelected = !currentValue
            defaults.set(!currentValue, forKey: K.UserDefaultsKeys.artAndCinemaCategoryChoosen)
        case 5:
            self.cellDataArray[indexPath.row].chechMarkSelected = !currentValue
            defaults.set(!currentValue, forKey: K.UserDefaultsKeys.natureCategoryChoosen)
        default:
            print("Out of Range")
        }
        collectionView.reloadData()
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

