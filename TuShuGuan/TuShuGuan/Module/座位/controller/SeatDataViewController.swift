//
//  HomeDataController.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/25.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SeatDataViewController: BaseDataController {
    
    var model:SeatDataModel!
    //首页
    func querySelectSite(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.querySelectSite(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<SeatDataModel>().map(JSONObject: result)
                if model != nil{
                   
                    self.model = model
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
                
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
