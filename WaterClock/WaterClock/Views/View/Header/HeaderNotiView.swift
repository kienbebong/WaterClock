import UIKit
import SnapKit

class HeaderNotiView: UIView {
    
    private let logoNotiImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "bell.fill")
        img.tintColor = .red
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.text = "Thông báo"
        return label
    }()
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NotificationCollectionViewCell.self, forCellWithReuseIdentifier: NotificationCollectionViewCell.identifier)
        collection.backgroundColor = .white
        return collection
    }()
    
    private let titles = ["Tất cả", "Sự cố nước", "Lịch công tác", "Tiền điện", "Nhắc nợ", "Chỉ số nước"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        setUpImg()
        setUpTitleLabel()
        setUpCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpImg() {
        addSubview(logoNotiImageView)
        logoNotiImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(30)
        }
    }
    
    func setUpTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalTo(logoNotiImageView.snp.trailing).offset(10)
            make.width.equalTo(150)
        }
    }
    
    func setUpCollection() {
        addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        
        collection.snp.makeConstraints { make in
            make.top.equalTo(logoNotiImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}

extension HeaderNotiView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionViewCell.identifier, for: indexPath) as! NotificationCollectionViewCell
        cell.configure(with: titles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = titles[indexPath.item]
        let font = UIFont.systemFont(ofSize: 17)
        let textWidth = text.width(withConstrainedHeight: 50, font: font)
        return CGSize(width: textWidth + 20, height: 80)
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
