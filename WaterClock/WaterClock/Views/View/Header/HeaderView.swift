import UIKit
import SnapKit

class HeaderView: UIView {
    
    var onContactTapped: (() -> Void)?
    var onSignInTapped: (() -> Void)?
    var onSettingInTapped: (() -> Void)?
    var onSearchTapped: (() -> Void)?
    
    private let backgroundImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "BGRB")
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()

    private let signInImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoLogIn")
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true

        return image
    }()
    
    public let logInLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("LOG_IN_NOW", comment: "LOG_IN_NOW")
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .white
        return image
    }()

    public let signInView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let logoImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.isUserInteractionEnabled = true
        image.tintColor = .white
        return image
    }()
    
    private let logoImage3: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone.fill")
        image.tintColor = .white
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(signInImage)
        signInImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(60)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(openSettingConTroller))
        signInImage.addGestureRecognizer(tapGesture1)
        
            addSubview(signInView)
            signInView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(60)
                make.leading.equalTo(signInImage.snp.trailing).offset(15)
                make.height.equalTo(60)
                make.width.equalTo(200)
            }
            signInView.addSubview(logoImage)
            logoImage.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(10)
                make.width.height.equalTo(30)
            }
            
            let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleSignInViewTap))
            signInView.addGestureRecognizer(tapGesture2)
            
            signInView.addSubview(logInLabel)
            logInLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(logoImage).offset(38)
                make.height.equalTo(logoImage)
                make.width.equalTo(200)
            }

        
        addSubview(logoImage2)
        logoImage2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-80)
            make.width.height.equalTo(30)
        }
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(OpenSearchTab))
        logoImage2.addGestureRecognizer(tapGesture3)
        
        addSubview(logoImage3)
        logoImage3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-30)
            make.width.height.equalTo(30)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OpenTabContact))
        logoImage3.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func handleSignInViewTap() {
        onSignInTapped?()
    }
    
    @objc private func OpenTabContact() {
        onContactTapped?()
    }
    
    @objc private func openSettingConTroller() {
        onSettingInTapped?()
    }
    
    @objc private func OpenSearchTab() {
        onSearchTapped?()
    }
    
    func updateViewVisibility() {
        self.isHidden = UserDefaults.standard.bool(forKey: "isUserSignedIn")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


