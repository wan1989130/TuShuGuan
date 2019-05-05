//
//  SelectClassAndProfessionDataController.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/5/5.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectClassAndProfessionDataController: BaseDataController {

    var type = ""//0班级1专业
    var model:DictionaryDataModel = DictionaryDataModel()
    func getData(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        if type == "0"{
            MSDataProvider.queryDictClass(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
                if isSuccess{
                    let model = Mapper<DictionaryDataModel>().map(JSONObject: result)
                    if model != nil{
                        self.model = model!
                        completionBlock(true, nil)
                    }else{
                        completionBlock(false, nil)
                    }
                }else{
                    completionBlock(false, nil)
                }
                
            }
        }else if type == "1"{
            MSDataProvider.queryDictMajor(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
                if isSuccess{
                    let model = Mapper<DictionaryDataModel>().map(JSONObject: result)
                    if model != nil{
                        self.model = model!
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
}
