//
//  SaveSeatDataModel.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/30.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SaveSeatDataModel: BaseModel {
    var data = SaveSeatModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class SaveSeatModel:BaseModel{
    var checkVal = ""//0通过1不允许重复选座2已经被占用
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        checkVal    <- map["checkVal"]
    }
}
