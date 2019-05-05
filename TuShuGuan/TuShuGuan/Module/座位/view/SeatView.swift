//
//  SeatView.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/30.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit

class SeatView: UIView {
    var scrollView: UIScrollView!
    
    
    var selectedIndex = -1
    var model:SeatDataModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
       
      
    }
    func initView(){
        for i in 1..<98{
            let imageView:UIImageView = self.viewWithTag(i) as! UIImageView
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = true
            imageView.frame = CGRect(x: imageView.frame.minX, y: imageView.frame.minY, width: 30, height: 30)
            imageView.image = UIImage.init(named: "mr")
            imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click(tap:))))
            
        }
        for i in 1000..<1015{
            let view:UIView = self.viewWithTag(i) as! UIView
            view.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            view.layer.borderWidth = 1
        }
    }
    func resetView(){
        if model.data.selectedSeatId != "" && model.data.selectedStatus == "1"{
            let imageView:UIImageView = self.viewWithTag(Int(model.data.selectedSeatId)!) as! UIImageView
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage.init(named: "mr")
            model.data.selectedStatus = "0"
        }
        
    }
    func update(model:SeatDataModel){
        initView()
        self.model = model
        if model.data.selectedSeatId != ""{
            selectedIndex = Int(model.data.selectedSeatId)!
            let imageView:UIImageView = self.viewWithTag(selectedIndex) as! UIImageView
            imageView.image = UIImage.init(named: "yx")
            
        }
        if model.data.seats.count > 0{
            for item in model.data.seats{
                if item.seatId != model.data.selectedSeatId{
                    let imageView:UIImageView = self.viewWithTag(Int(item.seatId)!) as! UIImageView
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = UIImage.init(named: "bkx")
                }
                
            }
        }
        
    }
 
    @objc func click(tap:UITapGestureRecognizer){
        let tag = tap.view?.tag
        
        if tag != nil{
            if model.data.seats.count > 0{
                for item in model.data.seats{
                    if item.seatId == String(tag!){
                        return
                    }
                }
            }
            if selectedIndex == -1{//第一次
                let imageView:UIImageView = self.viewWithTag(tag!) as! UIImageView
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage.init(named: "yx")
                selectedIndex = tag!
                model.data.selectedStatus = "1"
                
            }else
            if tag != selectedIndex && selectedIndex != -1{
                let imageView:UIImageView = self.viewWithTag(selectedIndex) as! UIImageView
                imageView.contentMode = .scaleAspectFit
                
                let imageViewNew:UIImageView = self.viewWithTag(tag!) as! UIImageView
                imageViewNew.contentMode = .scaleAspectFit
           
                    imageView.image = UIImage.init(named: "mr")
                      imageViewNew.image = UIImage.init(named: "yx")
                
                selectedIndex = tag!
                model.data.selectedStatus = "1"
            }else if tag == selectedIndex{
                let imageView:UIImageView = self.viewWithTag(selectedIndex) as! UIImageView
                imageView.contentMode = .scaleAspectFit
                

                if model.data.selectedStatus == "0"{
                    imageView.image = UIImage.init(named: "yx")
                    model.data.selectedStatus = "1"
                }else if model.data.selectedStatus == "1"{
                    imageView.image = UIImage.init(named: "mr")
                    model.data.selectedStatus = "0"
                }
                selectedIndex = tag!
            }
            
         model.data.selectedSeatId = String(tag!)
            
        }
       
        
    }

}
