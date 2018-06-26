//
//  ViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    let dis = DisposeBag()
    var label:UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 40))
        label.text = "倒计时"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TestViewModel.init().homepage()

        self.view.addSubview(self.label)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

