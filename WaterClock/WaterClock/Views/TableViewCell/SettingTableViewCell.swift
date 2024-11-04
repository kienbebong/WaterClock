//
//  SettingTableViewCell.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 1/11/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"

    private let logoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let detaillLabel: UILabel = {
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
    
    private let viewLabel: UIView = {
        let view = UIView()
        return view
    }()
    
    private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .gray.withAlphaComponent(0.05)
        
        setUpContainer()
        setUplogoImage()
        setUpViewLabel()
        setUpRightImage()
        
        self.backgroundColor = .white

    }
    
    func setUpContainer() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setUplogoImage() {
        containerView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(30)
        }
    }
    
    func setUpViewLabel() {
        containerView.addSubview(viewLabel)
        viewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImage).offset(70)
            make.top.equalToSuperview().offset(10)
        }
        
        viewLabel.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        viewLabel.addSubview(detaillLabel)
        detaillLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(30)
            make.leading.equalTo(titleLabel)
            make.width.equalTo(300)
            
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
    
    func configure(with image: UIImage, titleLabel: String, detailLabel: String) {
        self.detaillLabel.text = detailLabel
        self.logoImage.image = image
        self.titleLabel.text = titleLabel
    }
}
