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

    @IBOutlet weak var usernameTextFeild: UITextField!
    @IBOutlet weak var usernameOutlet: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordOutlet: UILabel!
    
    @IBOutlet weak var repeatedPasswordTextField: UITextField!
    @IBOutlet weak var repeatedPasswordOutlet: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var LoginLoding: UIActivityIndicatorView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
                

        let viewModel = RegisterViewModel.init(input: (username: usernameTextFeild.rx.text.orEmpty.asDriver(), password: passwordTextField.rx.text.orEmpty.asDriver(), repeatedPassword: repeatedPasswordTextField.rx.text.orEmpty.asDriver(), loginTaps: registerBtn.rx.tap.asSignal()), dependency: (networkService: RegisterNetworkService(), signupService: RegisterService()))
        
        //用户名验证结果绑定
        viewModel.validatedUsername
            .drive(usernameOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //密码验证结果绑定
        viewModel.validatedPassword
            .drive(passwordOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated
            .drive(repeatedPasswordOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.registerBtn.isEnabled = valid
                self?.registerBtn.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)
        
//        //当前是否正在注册
//        viewModel.isLoginLoding.debug()
//            .drive(LoginLoding.rx.isAnimating)
//            .disposed(by: disposeBag)
//
//        //绑定是否显示
//        viewModel.isLoginLoding.map{!$0}
//        .drive(LoginLoding.rx.isHidden)
//        .disposed(by: disposeBag)

        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        viewModel.isLoginLoding
            .map{!$0}
            .drive(hud.rx.isHidden)
            .disposed(by: disposeBag)
        
        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { [unowned self] result in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
            })
            .disposed(by: disposeBag)

    }
    
    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
