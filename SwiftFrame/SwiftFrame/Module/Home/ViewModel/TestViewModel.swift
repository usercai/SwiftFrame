//
//  TestViewModel.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit


class TestViewModel: BaseViewModel {

    
    func homepage()  {

        homePageTool.rx.request(HomePageApi.Homepage(type: 0, platid: 1)).asObservable().mapArray(type: TestModel.self).subscribe(onNext: { (models) in
            print(models)
        }, onError: { (error) in
            
            
            print(error)
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: dis)

        
        
        
    }
}

