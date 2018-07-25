//
//  HomeViewController.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    //表格
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        //初始化ViewModel
        let viewModel = HomeViewModel(input: (headerRefresh:self.tableView.mj_header.rx.refreshing.asDriver(), footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver()), disposeBag: dis)

        
        //单元格数据的绑定
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) { (tableView, row, model) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = model.Title
                return cell
            }
            .disposed(by: dis)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: dis)
        
        
        viewModel.endFooterRefreshing
            .drive(self.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: dis)
    }
    
}
