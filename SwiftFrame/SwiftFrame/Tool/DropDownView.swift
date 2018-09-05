//
//  DropDownView.swift
//  SwiftFrame
//
//  Created by mac on 2018/8/29.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

class DropDownView: UIView {

    lazy var tableView:UITableView = {
        
        let table = UITableView()
        table.frame = CGRect(x: 0, y: 0, width: kWidth, height: 0)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.rowHeight = 35
        return table
        
    }()
    typealias DropDownSelectClick = (Int,String)->Void
    var didSelectRow:DropDownSelectClick?
    
    private var dataArray:[String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.backgroundColor = UIColor.black.alpha(alpha: 0.5)
        self.addSubview(self.tableView)
        self.addTapGesture { [unowned self](tap) in
            self.isHidden = true
        }
    }
    
    func show(dataSource:[String],didSelect:DropDownSelectClick?) {
        
        self.didSelectRow = didSelect
        UIView.animate(withDuration: 0.4, animations: {
            var frame = self.tableView.frame
            frame.size = CGSize(width: kWidth, height: CGFloat(35*dataSource.count))
            self.tableView.frame = frame
            self.dataArray = dataSource
            self.tableView.reloadData()
        }) { (finish) in
//            UIView.animate(withDuration: 2.0, animations: {
//                self.alpha -= 0.9;
//            })
        }
    }
    
    func hidden() {
        
        self.removeFromSuperview()
    }
    
}

extension DropDownView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = self.dataArray[indexPath.row]
        self.didSelectRow!(indexPath.row,str)
    }
    
}
