//
//  SeatNewViewController.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/30.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit

class SeatNewViewController: BaseViewController {

    @IBAction func confirmClick(_ sender: Any) {
        saveSelectSeat()
    }
    @IBAction func resetClick(_ sender: Any) {
        seatView.resetView()
    }
    let User_UIID = UIDevice.current.identifierForVendor?.uuidString
    var dataController:SeatDataViewController!
    var scrollView: UIScrollView!
    var seatView:SeatView!
//    var scrollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
        title = "选座"
        getSeats()
    }
   
   
  
}
extension SeatNewViewController{
    func initUI(){
        var tempHeight:CGFloat = 420
        if ScreenHeight - CGFloat(navHeight) - 40 - 80 < 420{
            tempHeight = ScreenWidth - CGFloat(navHeight) - 40 - 80
        }
        scrollView = UIScrollView.init(frame: CGRect(x: 0, y:80, width:ScreenWidth , height: tempHeight))
            
        
//        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: 620  , height: 420)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        seatView = UIView.loadViewWithName("SeatView") as! SeatView
        seatView.isUserInteractionEnabled = true
//        seatView.drawInView(scrollView)
        seatView.frame = CGRect(x: 0, y: 0, width: 620, height: 420)
//        seatView.center = scrollView.center
        scrollView.addSubview(seatView)

        self.view.addSubview(scrollView)
    }
    fileprivate func initData(){
        dataController = SeatDataViewController(delegate: self)
        
        
    }
}
extension SeatNewViewController:UIScrollViewDelegate{
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return seatView
//    }
    
    
}
extension SeatNewViewController{
    func getSeats(){
        
        let parameter:NSMutableDictionary = [
            "deviceId":User_UIID
            
        ]
        dataController.querySelectSite(parameter: parameter) { [weak self](isSucceed, info) in
            if isSucceed {
                self?.seatView.update(model: (self?.dataController.model)!)
            }
        }
    }
    
    func saveSelectSeat(){
        if dataController.model.data.selectedSeatId == ""{
            LHAlertView.showTipAlertWithTitle("请选择座位")
            return
        }
        let parameter:NSMutableDictionary = [
            "seatId":dataController.model.data.selectedSeatId,
            "status":dataController.model.data.selectedStatus,
            "deviceId":User_UIID
            
        ]
        dataController.saveSelectSeat(parameter: parameter) { [weak self](isSucceed, info) in
            if isSucceed {
                self?.isRefresh()
            }else{
                //                self?.getSeats()
            }
        }
    }
    func isRefresh(){
        
        if dataController.saveModel != nil && dataController.saveModel!.msg != nil{
            
            if dataController.saveModel.data.checkVal == "0"{
                LHAlertView.showTipAlertWithTitle(dataController.saveModel.msg!)
            }else if dataController.saveModel.data.checkVal == "1"{
                LHAlertView.showTipAlertWithTitle(dataController.saveModel.msg!)
            }else if dataController.saveModel.data.checkVal == "2"{
                LHAlertView.showTipAlertWithTitle(dataController.saveModel.msg!)
                self.getSeats()
            }
            
        }
    }
    
}
