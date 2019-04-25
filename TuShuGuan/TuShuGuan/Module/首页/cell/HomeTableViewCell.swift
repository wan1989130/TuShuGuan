//
//  HomeTableViewCell.swift
//  TuShuGuan
//
//  Created by 王岩 on 2019/4/25.
//  Copyright © 2019 王岩. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> HomeTableViewCell{
        let cellId:String = "HomeTableViewCellId"
        var cell:HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? HomeTableViewCell
        
        if (cell == nil || !cell!.isKind(of: HomeTableViewCell.self)){
            cell = HomeTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
