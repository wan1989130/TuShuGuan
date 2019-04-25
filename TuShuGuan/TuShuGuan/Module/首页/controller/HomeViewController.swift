//
//  HomeViewController.swift
//  SocialSecurity
//
//  Created by 王岩 on 2018/12/21.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataController:HomeDataController!
    
    
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(ScreenWidth)/4,height:(ScreenWidth)/4)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        //注册一个cell
        
        collectionView.register(UINib.init(nibName: "ApplyViewControllerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ApplyViewControllerCollectionViewCell")
        collectionView?.backgroundColor = UIColor.clear
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
//MARK: - Private
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    //每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 10
        
    }
    //分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplyViewControllerCollectionViewCell", for: indexPath) as! ApplyViewControllerCollectionViewCell
//        cell.update(model: dataArray[indexPath.row])
//        if indexPath.row > 2{
//            cell.topLabel.isHidden = true
//        }else{
//            cell.topLabel.isHidden = false
//        }
//        if indexPath.row % 3 > 0{
//            cell.leftLabel.isHidden = true
//        }else{
//            cell.leftLabel.isHidden = false
//        }
//        if indexPath.row == 1{
//            cell.nameLabel.font = UIFont.systemFont(ofSize: 16)
//            cell.nameLabel.textColor = UIColor.red
//        }else{
//            cell.nameLabel.font = UIFont.systemFont(ofSize: 13)
//            cell.nameLabel.textColor = UIColor(hexString: "555555")
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        pro.collectionIndexClick(index: indexPath.row)
        pushViewController("SeatViewController")
    }
}
