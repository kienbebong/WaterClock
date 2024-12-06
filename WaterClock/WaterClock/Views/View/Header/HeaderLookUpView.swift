//
//  HeaderLookUpView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 4/11/24.
//

import UIKit

class HeaderLookUpView: UIView {
    var onSignInTapped: (() -> Void)?
    
    private let lookupImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chart.bar.xaxis")
        image.tintColor = .white
        return image
    }()
    
    private let lookupLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("LOOKUP", comment: "Lookup label text")
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("DETAIL", comment: "Detail label text")
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    private let logInLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("LOG_IN_NOW", comment: "Log in now label text")
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()



    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .blue
        return image
    }()

    private let signInView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        return view
    }()
    
    func setUpSignInView() {
        addSubview(signInView)
        signInView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(230)
            make.height.equalTo(50)
        }
        
        signInView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
        
        signInView.addSubview(logInLabel)
        logInLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImage).offset(38)
            make.height.equalTo(logoImage)
            make.width.equalTo(250)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignInViewTap))
        signInView.addGestureRecognizer(tapGesture)
    }
    
    func setUpLookupImage() {
        addSubview(lookupImage)
        lookupImage.snp.makeConstraints { make in
            make.top.equalTo(signInView)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
    }
    
    func setUpLookupLabel() {
        addSubview(lookupLabel)
        lookupLabel.snp.makeConstraints { make in
            make.top.equalTo(lookupImage).offset(10)
            make.leading.equalTo(lookupImage.snp.trailing).offset(5)
            make.width.equalTo(130)
        }
    }
    
    func setUpDetailLabel() {
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(lookupImage.snp.bottom).offset(20)
            make.leading.equalTo(lookupImage)
            make.width.equalTo(400)
        }
    }
    
    func handleAfterSignIn() {
        signInView.isHidden = true
        DataPersistenceManager.shared.fetchAccount { result in
            switch result {
            case .success(let account):
                self.detailLabel.text = String(format: NSLocalizedString("LOOKUP_CUSTOMER_INFO", comment: "Lookup customer information"), account.userName ?? "")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func handleAfterSignOut() {
        signInView.isHidden = false
        self.detailLabel.text =  NSLocalizedString("DETAIL", comment: "Detail label text")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        setUpSignInView()
        setUpLookupImage()
        setUpLookupLabel()
        setUpDetailLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func handleSignInViewTap() {
        onSignInTapped?()
    }
}
