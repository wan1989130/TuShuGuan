//
//  HomeViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/21.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataController:HomeDataController!
    var isWrite = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        initData()
        initUI()
    }
    
    deinit {
        print("其它信息页面销毁")
    }
    
}
extension HomeViewController{
    fileprivate func initUI(){
        self.view.backgroundColor = viewBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register("HomeTableViewCell")
        loadRightBarButtonItem()
      
        
    }
    fileprivate func initData(){
        dataController = HomeDataController(delegate: self)
        
        
    }
    func loadRightBarButtonItem(){
        let rightBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(rightBarButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func rightBarButtonClicked(sender: UIBarButtonItem){
        MyConfig.shared().token = ""
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navController = BaseNavigationViewController(rootViewController: loginVC)
        UIApplication.shared.keyWindow?.rootViewController = navController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = HomeTableViewCell.loadCell(tableView)
        
            
        
            return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewController("SeatViewController")
    }
}
