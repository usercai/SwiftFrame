//
//  HomeViewViewController2.swift
//  SwiftFrame
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 thc. All rights reserved.
//

import UIKit
import RxDataSources

class HomeViewViewController2: BaseViewController {

    let viewModel = HomeViewModel2()
    var dataSource:RxTableViewSectionedReloadDataSource<Section_HomeView>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension HomeViewViewController2{
    
    func initData()  {
        
        let out = viewModel.getHomeNews()
        
        dataSource = RxTableViewSectionedReloadDataSource(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = item.Title
            return cell
        })
        
        out.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: dis)
        
        out.refreshStatus.bind(to: self.tableView.rx.refreshing).disposed(by: dis)
        
        
        self.tableView.mj_header = HCRefresh.headerRefresh(refresh: {
            out.requestCommond.onNext(true)
        })
        self.tableView.mj_footer = HCRefresh.footerRefresh(refresh: {
            out.requestCommond.onNext(false)
        })
        self.tableView.mj_header.beginRefreshing()
        //显示hud
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = UIColor.black
        out.refreshStatus.bind(to: hud.rx.refreshing).disposed(by: dis)

    }
}
