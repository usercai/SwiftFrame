//
//  HomeViewModel2.swift
//  SwiftFrame
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import HandyJSON

class HomeViewModel2: BaseViewModel {
    
    /// 存放数据
    let models = BehaviorRelay<[Model_HomeNews]>(value: [])
    
    struct Input {
        
    }
    
    struct Out {
        //数据
        let sections:Driver<[Section_HomeView]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        //Subjects 既是订阅者，也是 Observable：
        let requestCommond = PublishSubject<Bool>()
        let refreshStatus = BehaviorRelay<RefreshStatus>(value: .none)
        
        init(sections:Driver<[Section_HomeView]>) {
            self.sections = sections
        }
    }

    
    func getHomeNews() -> HomeViewModel2.Out {
        let sections = models.asObservable().map { (models) -> [Section_HomeView] in
            return [Section_HomeView(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = Out(sections: sections)
        
        output.requestCommond.subscribe(onNext: { (isReloadData) in
            self.pageIndex = isReloadData ? 1 : self.pageIndex + 1
            output.refreshStatus.accept(RefreshStatus.Loading)
            homePageTool.rx.request(HomePageApi.QueryInfoList(isCarousel: 0, pageIndex: self.pageIndex, pageSize: 10))
                .asObservable().mapArray(Model_HomeNews.self)
                .subscribe(onNext: { (models) in
                    
                    if models.count == 0 && !isReloadData {output.refreshStatus.accept(RefreshStatus.noMoreData) }
                    self.models.accept(isReloadData ? models : self.models.value + models)
                    
                }, onError: { (error) in
                    self.pageIndex -= 1
                    output.refreshStatus.accept(isReloadData ? RefreshStatus.endHeaderRefresh : .endFooterRefresh)
                    
                }, onCompleted: {
                    output.refreshStatus.accept(isReloadData ? RefreshStatus.endHeaderRefresh : .endFooterRefresh)
                }, onDisposed: nil).disposed(by: self.dis)
        }).disposed(by: dis)
        
        return output
        
    }
    
    func getCycleView() -> Driver<[Model_HomeNews]>{
        return homePageTool.rx.request(HomePageApi.QueryInfoList(isCarousel: 1, pageIndex: 1, pageSize: 10))
        .asObservable().mapArray(Model_HomeNews.self).asDriver(onErrorJustReturn: [])
    }
    
}
