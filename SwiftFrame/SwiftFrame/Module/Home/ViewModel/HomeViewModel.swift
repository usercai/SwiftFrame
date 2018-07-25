//
//  HomeViewModel.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
//第一种上拉刷新下拉刷新实现方法
class HomeViewModel : BaseViewModel {
    //表格数据序列
    let tableData = BehaviorRelay<[Model_HomeNews]>(value: [])
    
    //停止刷新状态序列
    var endHeaderRefreshing: Driver<Bool> = Driver.just(false)
    //停止尾部刷新状态
    var endFooterRefreshing: Driver<Bool> = Driver.just(false)
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(input: (
        headerRefresh: Driver<Void>,
        footerRefresh: Driver<Void>),
        disposeBag:DisposeBag) {
        
        super.init()
        
        //网络请求服务
        let networkService = homePageTool.rx.request(HomePageApi.QueryInfoList(isCarousel: 0, pageIndex: 1, pageSize: 10)).asObservable().mapArray(Model_HomeNews.self).asDriver(onErrorJustReturn: [])
        
        
        
        //生成下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化完毕时会自动加载一次数据
            .flatMapLatest{ _ in
                
                return networkService} //也可考虑改用flatMapFirst
        
        
        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{ _ in  //也可考虑使用flatMapFirst
                return networkService }
        
        //生成停止刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }

        
        //下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            
            self.tableData.accept(items)
        }).disposed(by: disposeBag)
        


        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            self.tableData.accept(self.tableData.value + items )
        }).disposed(by: disposeBag)

        

    }
}
