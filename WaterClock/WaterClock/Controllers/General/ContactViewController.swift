import UIKit

class ContactViewController: UIViewController {
    
    private let callIMG: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "CallMe")
        img.layer.cornerRadius = 40
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let chatIMG: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Chat")
        img.layer.cornerRadius = 40
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        navigationItem.title = "Tổng đài CSKH miễn phí"
        
        view.addSubview(callIMG)
        callIMG.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(220)
        }
        
        view.addSubview(chatIMG)
        chatIMG.snp.makeConstraints { make in
            make.top.equalTo(callIMG.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(220)
        }
        
    }

}
