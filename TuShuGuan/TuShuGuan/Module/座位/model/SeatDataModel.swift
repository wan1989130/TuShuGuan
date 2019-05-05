//
//  SeatDataModel.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/29.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SeatDataModel: BaseModel {
    var data = SeatModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class SeatModel:BaseModel{
    var maxCol = ""
    var maxRow = ""
    var selectedSeatId = ""
    var selectedName = ""
    var selectedStatus = ""
    var selectedRow = ""
    var selectedCol = ""
    var seats = [SeatItemModel]()
    
    var status:FVSeatState = .seatsStateAvailable
    override func mapping(map: Map) {
        super.mapping(map: map)
        maxCol    <- map["maxCol"]
        maxRow    <- map["maxRow"]
        if map["selectedSeatId"].currentValue is String{
            selectedSeatId <- map["selectedSeatId"]
        }else{
            selectedSeatId <- (map["selectedSeatId"],transfromOfCustomFunction())
        }
        selectedName    <- map["selectedName"]
        selectedStatus    <- map["selectedStatus"]
        selectedRow    <- map["selectedRow"]
        selectedCol    <- map["selectedCol"]
        seats    <- map["seats"]
        if selectedStatus == "0"{
            status = .seatsStateAvailable
        }else if selectedStatus == "1"{
            status = .seatsStateUnavailable
        }else if selectedStatus == "2"{
            status = .seatsStateSellOut
        }else if selectedStatus == "3"{
            status = .seatsStateSelected
        }
    }
    
}
class SeatItemModel:BaseModel{
    var col = ""
    var row = ""
    var seatId = ""
    var tempStatus = ""
    var status:FVSeatState = .seatsStateAvailable
    var newStatus = ""//0可选1已选
    override func mapping(map: Map) {
        super.mapping(map: map)
        col    <- map["col"]
        seatId    <- map["seatId"]
        row    <- map["row"]
        tempStatus    <- map["tempStatus"]
       
        if tempStatus == "0"{
            status = .seatsStateAvailable
        }else if tempStatus == "1"{
            status = .seatsStateUnavailable
        }else if tempStatus == "2"{
            status = .seatsStateSellOut
        }else if tempStatus == "3"{
            status = .seatsStateSelected
        }
        newStatus    <- map["status"]
    }
}
