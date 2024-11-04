import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"chevron.forward.circle.fill")
        imageView.tintColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.width.height.equalTo(40)
        }
        
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.centerY.equalTo(imageView)
            make.trailing.equalTo(contentView).offset(-50)
        }
        
        contentView.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage?, text: String) {
        imageView.image = image
        textLabel.text = text
    }
}
