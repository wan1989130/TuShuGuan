//
//  PersonRegisterViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonRegisterViewController: BaseViewController {
    
    @IBOutlet weak var numerTextField: UITextField!
    @IBOutlet weak var idCardTextField: UITextField!
    var headImage:UIImage!
    @IBOutlet weak var headButton: UIButton!
    @IBOutlet var getCodeButton: UIButton!
    //验证码
    @IBOutlet weak var codeTextField: UITextField!
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
        if !checkPhone(){
            return
        }
        loadGetVercode()
        
        
    }
    
    var alert:UIAlertController!
    
    @IBAction func photoClick(_ sender: UIButton) {
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerClick(_ sender: Any) {
        closeKeyboard()
        if checkFun(){
            addUser()
        }
        
    }
 
    
   

    
  
    //手机号
    @IBOutlet weak var phoneTextField: UITextField!
    //用户名
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var classNameTextField: UITextField!
    
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    //确认密码
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var dataController:PersonRegisterDataController!
    
    
    
   
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "创建账号"
        
        initData()
        initUI()
    }
    
    
    
}
extension PersonRegisterViewController{
    fileprivate func initUI(){
       initAlert()
        
    }
    fileprivate func initData(){
        dataController = PersonRegisterDataController(delegate: self)
        
        
    }
    fileprivate func initAlert(){
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.view.tintColor = UIColor.black
        weak var weakSelf = self
        //通过拍照上传图片
        let takingPicAction:UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = weakSelf
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                weakSelf?.present(imagePicker, animated: true, completion: nil)
            }
        }
        //从手机相册中选择上传图片
        let okAction:UIAlertAction = UIAlertAction(title: "相册", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = weakSelf
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                weakSelf?.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
        }
        alert.addAction(takingPicAction)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
    //压缩图片
    fileprivate func imageWithImageSimple(image:UIImage,newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }
}
extension PersonRegisterViewController{
    
    fileprivate func checkPhone() -> Bool{
        if !(phoneTextField.text?.isLegalMobile())!{
            return false
        }
        return true
    }
    fileprivate func checkFun() -> Bool{
        if String.isNilOrEmpty(phoneTextField.text){
            LHAlertView.showTipAlertWithTitle("手机号不能为空")
            return false
        }
        if String.isNilOrEmpty(codeTextField.text){
            LHAlertView.showTipAlertWithTitle("验证码不能为空")
            return false
        }
        if String.isNilOrEmpty(userNameTextField.text){
            LHAlertView.showTipAlertWithTitle("用户名不能为空")
            return false
        }
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        if String.isNilOrEmpty(confirmPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("确认密码不能为空")
            return false
        }
        if confirmPasswordTextField.text != passwordTextField.text{
            LHAlertView.showTipAlertWithTitle("密码与验证码不一致")
            return false
        }
        if String.isNilOrEmpty(classNameTextField.text){
            LHAlertView.showTipAlertWithTitle("班级不能为空")
            return false
        }
        if String.isNilOrEmpty(professionTextField.text){
            LHAlertView.showTipAlertWithTitle("专业不能为空")
            return false
        }
        if String.isNilOrEmpty(idCardTextField.text){
            LHAlertView.showTipAlertWithTitle("身份证号不能为空")
            return false
        }
        if !idCardTextField.text!.isLegalIdCard(){
            return false
        }
        if headImage == nil{
            LHAlertView.showTipAlertWithTitle("个人照片不能为空")
            return false
        }
        if String.isNilOrEmpty(numerTextField.text){
            LHAlertView.showTipAlertWithTitle("学号不能为空")
            return false
        }
        return true
    }
    
    
    //获取验证码
    fileprivate func loadGetVercode(){
        let countDown = TCCountDown()//实例化
        countDown.getCodeButton = self.getCodeButton
        countDown.isCounting = true//开启倒计时
        let parameter:NSMutableDictionary = [
            "phone":phoneTextField.text!,
            "type":"0"
        ]
        dataController.getCode(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
               
                let countDown = TCCountDown()//实例化
                countDown.getCodeButton = self.getCodeButton
                countDown.isCounting = true//开启倒计时
            }else {
            }
        }
    }
  //添加注册的新用户
    fileprivate func addUser(){
        let imageData:Data = headImage.jpegData(compressionQuality: 0.5)!
        var imageBase64String = imageData.base64EncodedString()
        let parameter:NSMutableDictionary = [
            "name":userNameTextField.text!,
            "password":passwordTextField.text!,
            "college":classNameTextField.text!,
            "major":professionTextField.text!,
            "valigatecode":codeTextField.text!,
            "base64Str":imageBase64String,
            "idcard":idCardTextField.text!,
            "phone":phoneTextField.text!,
            "":numerTextField.text!
            
            ]
        dataController.register(parameter: parameter) { [weak self](isSucceed, info) in
            if isSucceed {
                MyConfig.shared().phone = (self?.userNameTextField.text!)!
                MyConfig.shared().userName = (self?.passwordTextField.text!)!
               self?.showMainTab()
            }
        }
    }
    //跳转至主页
    fileprivate func showMainTab(){
        self.navigationController?.popViewController(animated: true)
//        let tabbarVC = HomeViewController.loadViewController("HomeViewController")
//        let navVc = BaseNavigationViewController.init(rootViewController: tabbarVC)
//        UIApplication.shared.keyWindow?.rootViewController = navVc
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
//        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
}

extension PersonRegisterViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage:UIImage = info[.originalImage] as! UIImage
        
        chosenImage = self.imageWithImageSimple(image: chosenImage, newSize: CGSize(width: chosenImage.size.width * 0.5, height: chosenImage.size.height * 0.5))
        //调用接口
        
        picker.dismiss(animated: true){ [weak self] () in
            self?.headButton.setImage(chosenImage, for: .normal)
            self?.headImage = chosenImage
        }
    }
    
}
