//
//  MSDataProvider+Login.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation

extension MSDataProvider{
    
    
    //座位
    class func querySelectSite(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.getDataForDelegate(delegate, path: "querySelectSite", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
    
    
    
    
}
