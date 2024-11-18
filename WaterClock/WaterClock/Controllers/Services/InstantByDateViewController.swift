//
//  CutCalenderViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit

class InstantByDateViewController: UIViewController, ChooseInstantDateViewDelegate {
    var chooseDateView: ChooseInstantDateView?
    var dataView: DataInstantSpreadsheetView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpChooseDateView()
        
    }
    
    func setUpChooseDateView() {
        chooseDateView = ChooseInstantDateView(frame: .zero)
        view.addSubview(chooseDateView!)
        chooseDateView?.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        chooseDateView?.delegate = self
    }
    
    func didTappedSearch(with data: [InstantByDate]) {
            DispatchQueue.main.async {
                self.dataView = DataInstantSpreadsheetView(frame: .zero)
                self.view.addSubview(self.dataView!)
                self.dataView?.snp.makeConstraints { make in
                    make.top.equalTo(self.chooseDateView!.snp.bottom).offset(20)
                    make.leading.equalToSuperview().offset(10)
                    make.trailing.equalToSuperview().offset(-10)
                    make.height.greaterThanOrEqualTo(400)
                }
                self.dataView?.updateData(data)
                self.dataView?.spreadsheetView.reloadData()
            }
    }
}
