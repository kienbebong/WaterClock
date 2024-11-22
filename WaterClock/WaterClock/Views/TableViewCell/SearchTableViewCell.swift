//
//  SearchTableViewCell.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//


import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.tintColor = .blue
        return img
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        setUpImg()
        setUpNameLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpImg() {
        addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    func setUpNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
    
    func configure(with img: UIImage, name: String) {
        image.image = img
        nameLabel.text = name
    }

}
