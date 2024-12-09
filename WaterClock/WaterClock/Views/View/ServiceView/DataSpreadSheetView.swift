//
//  DataSpreadSheetView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 15/11/24.
//

import UIKit
import SpreadsheetView

class DataSpreadSheetView: UIView {

    let spreadsheetView = SpreadsheetView()
    var receiveData: [MeterDataInDay]?
    
    let dataName = [
        NSLocalizedString("METER_NUMBER", comment: "Mô tả số đồng hồ"),
        NSLocalizedString("TIME_WITH_DATA", comment: "Mô tả thời gian gắn với dữ liệu"),
        NSLocalizedString("MODULE_INDEX", comment: "Mô tả chỉ số module"),
        NSLocalizedString("PRESSURE", comment: "Mô tả áp suất"),
        NSLocalizedString("BATTERY_VOLTAGE", comment: "Mô tả điện áp pin")
    ]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSpreadsheetView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpSpreadsheetView() {
        addSubview(spreadsheetView)
        spreadsheetView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        
        spreadsheetView.delegate = self
        spreadsheetView.dataSource = self
    }
    
    func updateData(_ data: [MeterDataInDay]){
        receiveData = data
        spreadsheetView.reloadData()
    }
    
    
    
}
extension DataSpreadSheetView: SpreadsheetViewDelegate, SpreadsheetViewDataSource {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 180
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return dataName.count
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return (receiveData?.count ?? 0) + 2
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let totalColumns = dataName.count
        let totalRows = receiveData?.count ?? 0
        let totalItems = totalRows * totalColumns
        
        guard indexPath.row < totalItems else {
            return nil
        }
        
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
        let dataIndex = indexPath.row / totalColumns
        let headerIndex = indexPath.row % totalColumns
        
        if indexPath.column == 0 {
            // Cột đầu tiên: Tiêu đề
            cell.label.text = dataName[headerIndex]
        } else if let data = receiveData?[dataIndex] {
            // Cột dữ liệu
            switch headerIndex {
            case 0:
                cell.label.text = data.METER_NO
            case 1:
                cell.label.text = data.DATA_TIME
            case 2:
                cell.label.text = data.ACTIVE_TOTAL
            case 3:
                cell.label.text = data.PRESSURE ?? "N/A"
            case 4:
                cell.label.text = data.VOLTAGE ?? "N/A"
            default:
                cell.label.text = ""
            }
        }
        
        return cell
    }

}

class TextCell: Cell {
    var label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.font = .systemFont(ofSize: 16)
        label.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .gray.withAlphaComponent(0.15)
        label.numberOfLines = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

