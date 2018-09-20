//
//  HomeViewModel3.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/20.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

class HomeViewModel3: NSObject {

    func g() {
        NetworkTool
            .request(HomePageApi.QueryInfoList(isCarousel: 1, pageIndex: 1, pageSize: 10))
            .mapArray(Model_HomeNews.self)
            .subscribe(onNext: { (models) in
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            
            
        
        
    }
}
