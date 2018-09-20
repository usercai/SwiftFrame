//
//  NetworkSection.swift
//  SwiftFrame
//
//  Created by msxf on 2018/9/20.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxDataSources

//自定义Section
struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
