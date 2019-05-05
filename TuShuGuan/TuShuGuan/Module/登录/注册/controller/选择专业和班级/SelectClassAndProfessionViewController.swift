//
//  SelectClassAndProfessionViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/20.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectClassAndProfessionViewController: BaseViewController {
    
    
   
    @IBOutlet var tableView: UITableView!
    
    var selectIndexId = ""
    var selectIndex = 0
    var dataController:SelectClassAndProfessionDataController!
    var block:SelectBlcok!
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        getData()
    }
    deinit{
        print("sssss")
    }
    
    
}
extension SelectClassAndProfessionViewController{
    fileprivate func initUI(){
        weak var weakSelf = self
        self.view.backgroundColor = UIColor.white
        tableView.delegate = weakSelf
        tableView.dataSource = weakSelf
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("SelectTableViewCell")
        
        
    }
    fileprivate func initData(){
        dataController = SelectClassAndProfessionDataController(delegate: self)
        if senderParam != nil{
            let dic = senderParam as! NSMutableDictionary
            if dic["type"] != nil{
                dataController.type = dic["type"] as! String
                if dataController.type == "0"{
                    title = "选择班级"
                }else if dataController.type == "1"{
                    title = "选择专业"
                }
            }
            if dic["block"] != nil{
                block = (dic["block"] as! SelectBlcok)
            }
           
            
            
        }
        
    }
}
extension SelectClassAndProfessionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.model.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectTableViewCell.loadCell(tableView)
        cell.update(model: dataController.model.data[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       block(dataController.model.data[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
}

extension SelectClassAndProfessionViewController{
    fileprivate func getData(){
        let parameter:NSMutableDictionary = [
            :
        ]
        dataController.getData(parameter: parameter) { [weak self](isSucceed, info) in
            if isSucceed {
             self?.tableView.reloadData()
            }
        }
    }
}
