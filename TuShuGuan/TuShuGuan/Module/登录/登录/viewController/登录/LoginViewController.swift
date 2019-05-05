//
//  LoginViewController.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/10.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var bgView: UIView!
    //注册
    @IBAction func registerClick(_ sender: Any) {
        pushViewController("PersonRegisterViewController")
    }
   
    @IBOutlet var loginBtn: UIButton!
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    //用户名
    @IBOutlet weak var userNameTextField: UITextField!
    
    var dataController:LoginDataController!
    
    
    //忘记密码
    @IBOutlet var forgetPasswordBtn: UIButton!
  
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        initData()
        initUI()
        self.view.backgroundColor = UIColor(hexString: "ECF5FE")
    }

//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//    }
    @IBAction func forgetPwdButtonClicked(_ sender: UIButton) {

//        pushViewController("ForgetPwdViewController")
    }
 
   

    
   
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
//        self.showMainTab()
//        return
        closeKeyboard()

        if !checkFun(){
            return
        }
//        self.showMainTab()
        let parameter:NSMutableDictionary = [
            "loginid":userNameTextField.text!,
            "password":passwordTextField.text!,

        ]
        weak var weakSelf = self
        dataController.login(parameter: parameter) { [weak self](isSucceed, info) in
            if isSucceed {
                MyConfig.shared().phone = (self?.userNameTextField.text!)!
                
                MyConfig.shared().userName = (self?.passwordTextField.text!)!
//                weakSelf?.showMainTab()
                weakSelf?.pushViewController("SeatNewViewController")
            }else {

            }
        }
    }
    
    func checkFun() -> Bool{

        
        if String.isNilOrEmpty(userNameTextField.text){
            LHAlertView.showTipAlertWithTitle("用户名不能为空")
            return false
        }
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        return true
    }
}

extension LoginViewController{
    //跳转至主页
    fileprivate func showMainTab(){
        
        let tabbarVC = HomeViewController.loadViewController("HomeViewController")
        let navVc = BaseNavigationViewController.init(rootViewController: tabbarVC)
        UIApplication.shared.keyWindow?.rootViewController = navVc
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    
    fileprivate func initData(){
        dataController = LoginDataController(delegate: self)
        
    }
    
    fileprivate func initUI(){
        bgView.layer.cornerRadius = 5
        bgView.layer.borderColor = UIColor(hexString: "005191")?.cgColor
        bgView.layer.borderWidth = 1
        
     
        if MyConfig.shared().phone != "" && MyConfig.shared().phone != ""{
            userNameTextField.text = MyConfig.shared().phone
        }
    }
   
}
extension LoginViewController{
   
   
    
}
