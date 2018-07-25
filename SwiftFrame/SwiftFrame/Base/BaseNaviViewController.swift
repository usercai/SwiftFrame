//
//  BaseNaviViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

class BaseNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavi()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initNavi() {
        
        let bar = self.navigationBar
        bar.tintColor = UIColor.white
        bar.isTranslucent = false
        bar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:UIColor.white]
        bar.barTintColor = TINTCOLOR

    }
    
}


