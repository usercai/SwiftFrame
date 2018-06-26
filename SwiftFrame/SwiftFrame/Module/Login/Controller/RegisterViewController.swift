//
//  RegisterViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var usermodel:UserModel = UserModel()
    let dis = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        usermodel.name.asObservable().bind(to: nameTextField.rx.text).disposed(by: dis)
        nameTextField.rx.text.orEmpty.bind(to: usermodel.name).disposed(by: dis)

        usermodel.name.asObservable().subscribe { (str) in
            print(str.element)
        }.disposed(by: dis)
        
        
        
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
