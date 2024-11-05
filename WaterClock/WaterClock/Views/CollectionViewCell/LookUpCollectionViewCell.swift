//
//  LookUpCollectionViewCell.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 4/11/24.
//

import UIKit

class LookUpCollectionViewCell: UICollectionViewCell {
    static let identifier = "LookUpCollectionViewCell"
    
    private let viewImage: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.backgroundColor = .blue.withAlphaComponent(0.1)
        return view
    }()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .blue
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpImage()
        setUpTitle()
    }
    
    func setUpView() {
        addSubview(viewImage)
        viewImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }
    
    func setUpImage() {
        viewImage.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(viewImage)
            make.width.height.equalTo(40)
        }
    }
    
    func setUpTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewImage.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with img: UIImage, title: String) {
        image.image = img
        titleLabel.text = title 
    }
}
