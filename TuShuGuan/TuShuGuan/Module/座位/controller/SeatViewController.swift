//
//  SeatViewController.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/25.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit

class SeatViewController: BaseViewController {

    var dataController:SeatDataViewController!
    var selectedModel:FVSeatItem?
    var oldSelectedDic = NSMutableDictionary()
    var selectedDic = NSMutableDictionary()
    var seatsInfo2 = [FVSeatItem]()
    let picker = FVSeatsPicker()
    var seatMaxX = 0
    var seatMaxY = 0
    
    var dataArray = [SeatItemModel]()
    var tempDataArray = [SeatItemModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

//        for i in 0..<100{
//            let model = SeatModel()
//            if i == 0 {
//                model.status = .seatsStateUnavailable
//            }
//            if i == 1 {
//                model.status = .seatsStateSellOut
//            }
//           
//            if i == 2 {
//                model.status = .seatsStateSelected
//            }
//            model.name = "第\(i)"
//            dataArray.append(model)
//        }
        title = "选座"
        initData()
        initUI()
        getSeats()
    }


   

}
extension SeatViewController{
    fileprivate func initUI(){
        picker.cellSize = CGSize(width: 24, height: 24)
        picker.minimumZoomScale = 1
        picker.maximumZoomScale = 2
        picker.seatsDelegate = self
        picker.setImage(UIImage.init(named: "seat_available"), for: .normal)
        picker.setImage(UIImage.init(named: "seat_unavailable"), for: .disabled)
        picker.setImage(UIImage.init(named: "yx"), for: .selected)
        picker.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: ScreenHeight - 100 - CGFloat(navHeight) - 40)
        self.view.addSubview(picker)
        
        
        
    }
    fileprivate func initData(){
        dataController = SeatDataViewController(delegate: self)
        
        
    }
    func loadData(){
//        let path = Bundle.main.path(forResource: "districtOne.plist", ofType: nil)
//        let dic = NSDictionary.init(contentsOfFile: path!)
        
        
//        seatMaxX = dic!["x"] as! String
//        seatMaxY = dic!["y"] as! String
//        seatMaxX = maxRow
//        seatMaxY = maxCol
        
        let resultData = NSMutableArray()
        
        for j in 1...seatMaxY{
            for i in 1...dataArray.count{
               
                if i % seatMaxY == j{
                    dataArray[i - 1].col = String(j)
                    dataArray[i - 1].row = String((i / seatMaxY) + 1)
                    tempDataArray.append(dataArray[i - 1])
                }else if i % seatMaxY == 0{
                    dataArray[i - 1].col = String(seatMaxY)
                    dataArray[i - 1].row = String(i / seatMaxY)
                    tempDataArray.append(dataArray[i - 1])
                }
            }
        }
        
        
        for i in 1...tempDataArray.count{
            let seatsInfo = FVSeatItem()
            seatsInfo.seatName = tempDataArray[i-1].name
            seatsInfo.seatId = Int32(tempDataArray[i-1].id)!
            seatsInfo.col = Int32(tempDataArray[i-1].col)!
            seatsInfo.row = Int32(tempDataArray[i-1].row)!
            seatsInfo.coordinateX = Int32(tempDataArray[i-1].col)!
            seatsInfo.coordinateY = Int32(tempDataArray[i-1].row)!
            seatsInfo.seatStatus = tempDataArray[i-1].status
            resultData.add(seatsInfo)
            
        }
//        for item in dic!["seats"] as! NSArray{
//            let temDic = item as! NSDictionary
//            let seatsInfo = FVSeatItem()
//
//            seatsInfo.seatId = Int32(Int(temDic.value(forKey: "id") as! String)!)
//            seatsInfo.seatName = temDic.value(forKey: "name") as! String
//            seatsInfo.price = Int32(Int(temDic.value(forKey: "price") as! String)!)
//            seatsInfo.col = Int32(Int(temDic.value(forKey: "col") as! String)!)
//            seatsInfo.row = Int32(Int(temDic.value(forKey: "row") as! String)!)
//            seatsInfo.seatStatus = FVSeatState(rawValue: Int(temDic.value(forKey: "status") as! String)!)!
//            seatsInfo.coordinateX = Int32(Int(temDic.value(forKey: "x") as! String)!)
//            seatsInfo.coordinateY = Int32(Int(temDic.value(forKey: "y") as! String)!)
//            resultData.add(seatsInfo)
//        }
        seatsInfo2 = resultData as! [FVSeatItem]
        fillDataToSeatsSelector()
    }
    func fillDataToSeatsSelector(){
        picker.rowCount = UInt(seatMaxX)
        picker.colCount = UInt(seatMaxY)
        picker.seats = seatsInfo2 as NSArray
        picker.reloadData()
        //        picker.reloadData
    }
}
extension SeatViewController:FVSeatsPickerDelegate{
    func shouldSelectSeat(_ seatInfo: FVSeatItem!, in picker: FVSeatsPicker!) -> Bool {
        
        return true
    }
    func shouldDeselectSeat(_ seatInfo: FVSeatItem!, in picker: FVSeatsPicker!) -> Bool {
        return true
    }
    func seatsPicker(_ picker: FVSeatsPicker!, didSelectSeat seatInfo: FVSeatItem!) {
        if selectedModel != nil{
            for item in seatsInfo2{
                if item.seatId == selectedModel?.seatId{
                    item.seatStatus = .seatsStateAvailable
                    break
                }
            }
        }
        selectedModel = seatInfo
        seatInfo.seatStatus = .seatsStateSelected
            selectedDic.removeAllObjects()
        
        
        selectedDic[seatInfo.seatId] = seatInfo
        picker.reloadData()
        print(seatInfo)
    }
    func seatsPicker(_ picker: FVSeatsPicker!, didDeselectSeat seatInfo: FVSeatItem!) {
        selectedModel = nil
        selectedDic.removeObject(forKey: seatInfo.seatId)
        seatInfo.seatStatus = .seatsStateAvailable
        picker.reloadData()
        print(seatInfo)
    }
    
    
}


extension SeatViewController{
    func getSeats(){
        
        let parameter:NSMutableDictionary = [
            "stuPhone":"13980881222"
            
        ]
        dataController.querySelectSite(parameter: parameter) { [weak self](isSucceed, info) in
            if isSucceed {
                self?.oprdata()
            }
        }
    }
    func oprdata(){
        for item in dataController.model.data.seats{
            if item.id == dataController.model.data.selectedSeatId{
                item.status = .seatsStateSelected
                if dataController.model.data.selectedSeatId != ""{
                    let model = FVSeatItem()
                    model.col = Int32((dataController.model.data.selectedCol))!
                    model.row = Int32((dataController.model.data.selectedRow))!
                    model.seatStatus = .seatsStateSelected
                    model.seatName = (dataController.model.data.selectedName)
                    model.seatId = Int32((dataController.model.data.selectedSeatId))!
                    selectedModel = model
                    selectedDic[model.seatId] = model
                }
                break
            }
        }
        dataArray = dataController.model.data.seats ?? [SeatItemModel]()
        if dataController.model.data.maxRow != "" && dataController.model.data.maxCol != ""{
            seatMaxX = Int((dataController.model.data.maxRow))!
            seatMaxY = Int((dataController.model.data.maxCol))!
        }
        
        
        
        loadData()
        picker.reloadData()
    }
}
