//
//  HeaderSearchView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//
protocol HeaderSearchViewDelegate: AnyObject {
    func didUpdateSearchText(_ searchText: String)
}

import UIKit

class HeaderSearchView: UIView, UISearchBarDelegate {
    
    var back: (() -> Void)?
    var delegate: HeaderSearchViewDelegate?


    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BGRB")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backLogoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.backward")
        img.tintColor = .white
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("SEARCH_PLACEHOLDER", comment: "Search placeholder text")
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .white
        searchBar.barTintColor = .gray.withAlphaComponent(0.5)
        
        return searchBar
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        setUpBackGround()
        setUpBackLogo()
        setUpSearchField()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpBackGround() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpBackLogo() {
        addSubview(backLogoImage)
        backLogoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(28)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backLogoImage.addGestureRecognizer(tapGesture1)
    }
    
    func setUpSearchField() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalTo(backLogoImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        searchBar.delegate = self
    }

    
    
    @objc private func backHome() {
        back?()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didUpdateSearchText(searchText)
    }
    
}
