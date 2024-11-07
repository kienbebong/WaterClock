//
//  ServicesCollectionViewCell.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    static let identifier = "ServicesCollectionViewCell"
    
    public let viewImage: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .blue
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpImage()
    }
    
    func setUpView() {
        addSubview(viewImage)
        viewImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    func setUpImage() {
        viewImage.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(viewImage)
            make.width.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with img: UIImage) {
        image.image = img
    }
}
