//
//  Date+Extension.swift
//  SwiftFrame
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 thc. All rights reserved.
//

import Foundation
import UIKit

/*
 DateFormatter的功能,将日期字符串转日期,将日期转成字符串, DateFormatter()频繁创建和释放会影响性能,只需要全局创建一个即可以; 在oc中可以将其创建成一个单例
 Calendar: 日历, 判断当前的日子是否今天昨天明天周末; 获取日期中间的元素(年, 月, 日, 时...)
 Date: 所有和秒相关的操作, 都和Date有关
 */

let dateFormat = DateFormatter()
let calendar = Calendar.current

extension Date{
    
    func c_string() -> String{
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        let str = dateFormat.string(from: self)
        return str
    }
    
    /// 传入服务器返回的时间字符串, 直接返回需求的时间字符串
    static func c_requiredTimeStr(TimeStr: String) -> String {
        let date = Date.c_timeStrToDate(sinaTime: TimeStr)
        return date.c_dateToRequiredTimeStr()
    }
    
    /// 1. 服务器返回的时间字符串转成Date对象
    //Date在swift是一个结构体, 在结构中, 类方法(静态方法)用static来修饰
    static func c_timeStrToDate(sinaTime: String) -> Date {
        
        let formatStr = "EEE MMM dd HH:mm:ss zzz yyyy"
        dateFormat.locale = Locale(identifier: "str")
        dateFormat.dateFormat = formatStr
        
        return dateFormat.date(from: sinaTime)!
    }
    
    /// 2. 将Date对象转成app需要的时间格式的字符串
    func c_dateToRequiredTimeStr() -> String {
        let seconds: Int64 = Int64(Date().timeIntervalSince(self))
        
        //判断是否是一分钟以内
        if seconds < 60 {
            return "刚刚"
        }
        
        //大于一分钟, 小于1小时
        if seconds < 3600 {
            return "\(seconds/60)分钟前"
        }
        
        //大于一小时, 小于1天
        if seconds < 3600 * 24 {
            return "\(seconds/3600)小时前"
        }
        
        //判断是否是昨天: 昨天 05: 05
        var formatStr = ""
        if calendar.isDateInYesterday(self) {
            formatStr = "昨天 HH:mm"
        } else {
            //判断是否是今年, 比昨天更早: `03-15 05: 05`
            //通过calendar取到时间元素
            let dateYear = calendar.component(.year, from: self) //self也就是新浪数据的时间年份
            let thisYear = calendar.component(.year, from: Date()) //当前时间的年份
            
            //今年
            if dateYear == thisYear {
                formatStr = "MM-dd HH:mm"
            }
                //往年
            else{
                formatStr = "yyyy-MM-dd HH:mm"
            }
        }
        
        dateFormat.locale = Locale(identifier: "str")
        dateFormat.dateFormat = formatStr
        
        return dateFormat.string(from: self)
    }
    
    //MARK: - 获取日期各种值
    //MARK: 年
    func year() ->Int {
        
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.year!
    }
    //MARK: 月
    func month() ->Int {

        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.month!
        
    }
    //MARK: 日
    func day() ->Int {
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        return com.day!
        
    }
    //MARK: 星期几
    func weekDay()->Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 当月天数
    func countOfDaysInMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    func firstWeekDay() ->Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    
    //MARK: - 日期的一些比较
    //是否是今天
    func isToday()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }

}
