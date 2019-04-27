//
//  HomeDataController.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/25.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class HomeDataController: BaseDataController {
    var model:ApplyModel!
    var toolArray:Array<ApplyToolModel> = [ApplyToolModel]()
    //首页
    func getApps(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getApps(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<ApplyModel>().map(JSONObject: result)
                if model != nil{
                    self.toolArray = model!.data
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
