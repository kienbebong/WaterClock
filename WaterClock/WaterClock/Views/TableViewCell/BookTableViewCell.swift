//
//  BookTableViewCell.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 11/11/24.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    static let identifier = "BookTableViewCell"

    private let logoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
        
    private let rightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .blue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        self.selectedBackgroundView = selectedView
        
        setUpContainer()
        setUplogoImage()
        setUpViewLabel()
        setUpRightImage()

    }
    
    func setUpContainer() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.backgroundColor = .blue.withAlphaComponent(0.05)
    }
    
    func setUplogoImage() {
        containerView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func setUpViewLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImage.snp.trailing).offset(10)
            make.width.equalTo(270)
            make.height.greaterThanOrEqualTo(200)
        }
    }
    
    func setUpRightImage() {
        containerView.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage, titleLabel: String) {
        self.logoImage.image = image
        self.titleLabel.text = titleLabel
    }

}
