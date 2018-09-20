//
//  MeViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var headerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        kUserInfo.name.bind(to: name.rx.text).disposed(by: dis)
//        name.rx.text.orEmpty.bind(to: kUserInfo.name).disposed(by: dis)

        _ = self.name.rx.textInput <-> kUserInfo.name
        kUserInfo.name.subscribe(onNext: { (name) in
            print(name)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: dis)
        
        btn.addClick { [unowned self](btn) in
//            let view = DropDownView(frame: CGRect(x: 0, y: self.btn.c_maxY() + 5, width: kWidth, height: kHeight - self.btn.c_maxY() - 5))
//            self.view.addSubview(view)
//            view.show(dataSource: ["1","2","3"], didSelect: { (row, text) in
//
//            })
            NetworkTool.request(HomePageApi.QueryInfoList(isCarousel: 1, pageIndex: 1, pageSize: 10)).subscribe(onNext: { (data) in

            }, onError: { (error) in
                CLog(error)
            }, onCompleted: {
                CLog("completed")
            }, onDisposed: {
                CLog("disposed")
            }).disposed(by: self.dis)
//
        

        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        HUDTool.hiddenLoading()
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
