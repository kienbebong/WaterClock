//
//  SearchViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class SearchViewController: UIViewController {
    var headerView: HeaderSearchView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpHeader()
    }
    
    private func setUpHeader() {
        headerView = HeaderSearchView(frame: .zero)
        view.addSubview(headerView!)
        
        headerView?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerView?.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    
}
