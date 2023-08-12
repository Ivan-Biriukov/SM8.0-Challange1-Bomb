import UIKit

class CategoryesCollectionViewCell: UICollectionViewCell {
    
    var cellData : CategoryesDataModel? {
        didSet {
            self.image.image = UIImage(named: cellData!.imageName)
            self.titleLabel.text = cellData?.titleLabel
            self.isOn = cellData!.chechMarkSelected
        }
    }
    
    private var isOn : Bool = false
    
    private let image : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.widthAnchor.constraint(equalToConstant: 96).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .delaGothic16()
        lb.textColor = .specialYellow
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let checkmarkImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: K.Images.chekmark)
        img.heightAnchor.constraint(equalToConstant: 30).isActive = true
        img.widthAnchor.constraint(equalToConstant: 30).isActive = true
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addCheckMark(isOn: isOn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.backgroundColor = .specialViolet
        contentView.layer.cornerRadius = 175 / 4
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
     func addCheckMark(isOn : Bool) {
        if isOn {
            contentView.addSubview(checkmarkImage)
            NSLayoutConstraint.activate([
                checkmarkImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
                checkmarkImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            ])
        } else {
            checkmarkImage.removeFromSuperview()
            NSLayoutConstraint.deactivate([
                checkmarkImage.topAnchor.constraint(equalTo: contentView.topAnchor),
                checkmarkImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -5)
            ])
        }
    }
}
