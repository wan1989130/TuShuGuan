//
//  DictionaryDataModel.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/5/5.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class DictionaryDataModel: BaseModel {
    var data:Array<DictionaryItemModel> = [DictionaryItemModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class DictionaryItemModel: BaseModel {
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name    <- map["value"]
    }
}
