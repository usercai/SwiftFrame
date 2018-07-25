//
//  BaseViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {

    let dis = DisposeBag()
    
    lazy var tableView:UITableView = {
        
        let table = UITableView()
        table.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight)
        table.tableFooterView = UIView(frame: CGRect.zero)
        view.addSubview(table)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return table
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
