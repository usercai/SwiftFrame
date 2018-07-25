//
//  Model_HomeNews.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxDataSources

class Model_HomeNews: BaseModel {
    var NoticeID:Int = 0
    var Title:String = ""
    var Contents:String = ""
    var Summary:String = ""
    var Author:String = ""
    var CreateDateTime:String = ""
    var Picture:String = ""
    var NoticeType:Int = 0
    var IsCarousel:Int = 0
}

struct Section_HomeView {
    var items : [Item]
}

extension Section_HomeView : SectionModelType{
    
    typealias Item = Model_HomeNews
    
    init(original: Section_HomeView, items: [Model_HomeNews]) {
        self = original
        self.items = items
    }
    
}
