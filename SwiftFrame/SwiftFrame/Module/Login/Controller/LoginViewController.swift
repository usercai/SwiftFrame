//
//  LoginViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.text = KeyChainTool.getUserAccount()
        self.passwordTextField.text = KeyChainTool.getPassWord()
        
        let viewmodel = LoginViewModel(input: (username: usernameTextField.rx.text.orEmpty.asDriver(), password: passwordTextField.rx.text.orEmpty.asDriver(), type: "0", loginTap: LoginBtn.rx.tap.asSignal()), dependency: (networkService: LoginNetWorkService(), signupService: LoginService()))
        
        viewmodel.LoginEnabled
            .drive(onNext: { [weak self] valid in
            self?.LoginBtn.isEnabled = valid
            self?.LoginBtn.alpha = valid ? 1.0 : 0.3
        }).disposed(by: dis)
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = UIColor.black
        
        viewmodel.isLoginLoding.map{!$0}
            .drive(hud.rx.isHidden)
            .disposed(by: dis)
        
        viewmodel.LoginResult
            .drive(onNext: { result in
                if result == true{
                    let vc = MainViewController()
                    UIApplication.shared.keyWindow?.rootViewController = vc
                }else{
                    MBProgressHUD.showError("用户名密码错误")
                }

            }).disposed(by: dis)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
