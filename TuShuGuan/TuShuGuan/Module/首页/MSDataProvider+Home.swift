//
//  MSDataProvider+Login.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation

extension MSDataProvider{
   
    
    //首页
    class func getApps(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "userAuthority", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
   
    
    
    
}
