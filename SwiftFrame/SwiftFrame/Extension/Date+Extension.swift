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
    
    /**
     
     获取指定时间下一个月的时间
     
     */
    
    func getNextDate() ->Date {
        let calendar = Calendar.current
        var com = calendar.dateComponents([.year,.month,.day], from: self)
        com.month! += 1
        com.day = 1
        if com.month == Date().month {
            com.day = Date().day
        }
        return calendar.date(from: com)!
    }

    /**
     
     获取指定时间上一个月的时间
     
     */
    
    func getLastDate() -> Date {
        
        let calendar = Calendar.current
        var com = calendar.dateComponents([.year,.month,.day], from: self)
        com.month! -= 1
        com.day = 1
        if com.month == Date().month {
            com.day = Date().day
        }
        return calendar.date(from: com)!
        
    }
    
    /// 生成一个时间
    ///
    /// - Parameters:
    ///   - year: 年
    ///   - Month: 月
    ///   - Day: 日
    static func initDate(year:Int,Month:Int,Day:Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = String.init(format: "%d-%d-%d", year,Month,Day)
        return formatter.date(from: dateStr) ?? Date()
    }
}


extension Date {
    /// The year.
    public var year: Int {
        return dateComponents.year!
    }
    
    /// The month.
    public var month: Int {
        return dateComponents.month!
    }
    
    /// The day.
    public var day: Int {
        return dateComponents.day!
    }
    
    /// The hour.
    public var hour: Int {
        return dateComponents.hour!
    }
    
    /// The minute.
    public var minute: Int {
        return dateComponents.minute!
    }
    
    /// The second.
    public var second: Int {
        return dateComponents.second!
    }
    
    /// The nanosecond.
    public var nanosecond: Int {
        return dateComponents.nanosecond!
    }
    
    /// The weekday.
    public var weekday: Int {
        return dateComponents.weekday!
    }
    
    private var dateComponents: DateComponents {
        return calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday], from: self)
    }
    
    // Returns user's calendar to be used to return `DateComponents` of the receiver.
    private var calendar: Calendar {
        return .current
    }
    
    /// Creates a new instance with specified date components.
    ///
    /// - parameter era:        The era.
    /// - parameter year:       The year.
    /// - parameter month:      The month.
    /// - parameter day:        The day.
    /// - parameter hour:       The hour.
    /// - parameter minute:     The minute.
    /// - parameter second:     The second.
    /// - parameter nanosecond: The nanosecond.
    /// - parameter calendar:   The calendar used to create a new instance.
    ///
    /// - returns: The created `Date` instance.
    public init(era: Int?, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, on calendar: Calendar) {
        let now = Date()
        var dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: now)
        dateComponents.era = era
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        dateComponents.nanosecond = nanosecond
        
        let date = calendar.date(from: dateComponents)
        self.init(timeInterval: 0, since: date!)
    }
    
    /// Creates a new instance with specified date componentns.
    ///
    /// - parameter year:       The year.
    /// - parameter month:      The month.
    /// - parameter day:        The day.
    /// - parameter hour:       The hour.
    /// - parameter minute:     The minute.
    /// - parameter second:     The second.
    /// - parameter nanosecond: The nanosecond. `0` by default.
    ///
    /// - returns: The created `Date` instance.
    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0) {
        self.init(era: nil, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, on: .current)
    }
    
    /// Creates a new Instance with specified date components
    ///
    /// - parameter year:  The year.
    /// - parameter month: The month.
    /// - parameter day:   The day.
    ///
    /// - returns: The created `Date` instance.
    public init(year: Int, month: Int, day: Int) {
        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    
    /// Creates a new instance representing today.
    ///
    /// - returns: The created `Date` instance representing today.
    public static func today() -> Date {
        let now = Date()
        return Date(year: now.year, month: now.month, day: now.day)
    }
    
    /// Creates a new instance representing yesterday
    ///
    /// - returns: The created `Date` instance representing yesterday.
    public static func yesterday() -> Date {
        return (today() - 1.day)!
    }
    
    /// Creates a new instance representing tomorrow
    ///
    /// - returns: The created `Date` instance representing tomorrow.
    public static func tomorrow() -> Date {
        return (today() + 1.day)!
    }
    
    /// Creates a new instance added a `DateComponents`
    ///
    /// - parameter left:  The date.
    /// - parameter right: The date components.
    ///
    /// - returns: The created `Date` instance.
    public static func + (left: Date, right: DateComponents) -> Date? {
        return Calendar.current.date(byAdding: right, to: left)
    }
    
    /// Creates a new instance subtracted a `DateComponents`
    ///
    /// - parameter left:  The date.
    /// - parameter right: The date components.
    ///
    /// - returns: The created `Date` instance.
    public static func - (left: Date, right: DateComponents) -> Date? {
        return Calendar.current.date(byAdding: -right, to: left)
    }
    
    /// Creates a new instance by changing the date components
    ///
    /// - Parameters:
    ///   - year: The year.
    ///   - month: The month.
    ///   - day: The day.
    ///   - hour: The hour.
    ///   - minute: The minute.
    ///   - second: The second.
    ///   - nanosecond: The nanosecond.
    /// - Returns: The created `Date` instnace.
    public func changed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) -> Date? {
        var dateComponents = self.dateComponents
        dateComponents.year = year ?? self.year
        dateComponents.month = month ?? self.month
        dateComponents.day = day ?? self.day
        dateComponents.hour = hour ?? self.hour
        dateComponents.minute = minute ?? self.minute
        dateComponents.second = second ?? self.second
        dateComponents.nanosecond = nanosecond ?? self.nanosecond
        
        return calendar.date(from: dateComponents)
    }
    
    /// Creates a new instance by changing the year.
    ///
    /// - Parameter year: The year.
    /// - Returns: The created `Date` instance.
    public func changed(year: Int) -> Date? {
        return changed(year: year, month: nil, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil)
    }
    
    /// Creates a new instance by changing the month.
    ///
    /// - Parameter month: The month.
    /// - Returns: The created `Date` instance.
    public func changed(month: Int) -> Date? {
        return changed(year: nil, month: month, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil)
    }
    
    /// Creates a new instance by changing the day.
    ///
    /// - Parameter day: The day.
    /// - Returns: The created `Date` instance.
    public func changed(day: Int) -> Date? {
        return changed(year: nil, month: nil, day: day, hour: nil, minute: nil, second: nil, nanosecond: nil)
    }
    
    /// Creates a new instance by changing the hour.
    ///
    /// - Parameter hour: The hour.
    /// - Returns: The created `Date` instance.
    public func changed(hour: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: hour, minute: nil, second: nil, nanosecond: nil)
    }
    
    /// Creates a new instance by changing the minute.
    ///
    /// - Parameter minute: The minute.
    /// - Returns: The created `Date` instance.
    public func changed(minute: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: nil, minute: minute, second: nil, nanosecond: nil)
    }
    
    /// Creates a new instance by changing the second.
    ///
    /// - Parameter second: The second.
    /// - Returns: The created `Date` instance.
    public func changed(second: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: second, nanosecond: nil)
    }
    
    /// Creates a new instance by changing the nanosecond.
    ///
    /// - Parameter nanosecond: The nanosecond.
    /// - Returns: The created `Date` instance.
    public func changed(nanosecond: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nanosecond)
    }
    
    /// Creates a new instance by changing the weekday.
    ///
    /// - Parameter weekday: The weekday.
    /// - Returns: The created `Date` instance.
    public func changed(weekday: Int) -> Date? {
        return self - (self.weekday - weekday).days
    }
    
    /// Creates a new instance by truncating the components
    ///
    /// - Parameter components: The components to be truncated.
    /// - Returns: The created `Date` instance.
    public func truncated(_ components: [Calendar.Component]) -> Date? {
        var dateComponents = self.dateComponents
        
        for component in components {
            switch component {
            case .month:
                dateComponents.month = 1
            case .day:
                dateComponents.day = 1
            case .hour:
                dateComponents.hour = 0
            case .minute:
                dateComponents.minute = 0
            case .second:
                dateComponents.second = 0
            case .nanosecond:
                dateComponents.nanosecond = 0
            default:
                continue
            }
        }
        
        return calendar.date(from: dateComponents)
    }
    
    /// Creates a new instance by truncating the components
    ///
    /// - Parameter component: The component to be truncated from.
    /// - Returns: The created `Date` instance.
    public func truncated(from component: Calendar.Component) -> Date? {
        switch component {
        case .month:
            return truncated([.month, .day, .hour, .minute, .second, .nanosecond])
        case .day:
            return truncated([.day, .hour, .minute, .second, .nanosecond])
        case .hour:
            return truncated([.hour, .minute, .second, .nanosecond])
        case .minute:
            return truncated([.minute, .second, .nanosecond])
        case .second:
            return truncated([.second, .nanosecond])
        case .nanosecond:
            return truncated([.nanosecond])
        default:
            return self
        }
    }
    
    /// Creates a new `String` instance representing the receiver formatted in given date style and time style.
    ///
    /// - parameter dateStyle: The date style.
    /// - parameter timeStyle: The time style.
    ///
    /// - returns: The created `String` instance.
    public func stringIn(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        
        return dateFormatter.string(from: self)
    }
    
    @available(*, unavailable, renamed: "stringIn(dateStyle:timeStyle:)")
    public func string(inDateStyle dateStyle: DateFormatter.Style, andTimeStyle timeStyle: DateFormatter.Style) -> String {
        return stringIn(dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    /// Creates a new `String` instance representing the date of the receiver formatted in given date style.
    ///
    /// - parameter dateStyle: The date style.
    ///
    /// - returns: The created `String` instance.
    public func dateString(in dateStyle: DateFormatter.Style) -> String {
        return stringIn(dateStyle: dateStyle, timeStyle: .none)
    }
    
    /// Creates a new `String` instance representing the time of the receiver formatted in given time style.
    ///
    /// - parameter timeStyle: The time style.
    ///
    /// - returns: The created `String` instance.
    public func timeString(in timeStyle: DateFormatter.Style) -> String {
        return stringIn(dateStyle: .none, timeStyle: timeStyle)
    }
}
