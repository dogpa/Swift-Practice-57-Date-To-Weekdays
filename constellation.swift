//
//  constellation.swift
//  Swift Practice # 57 Date To Weekdays
//
//  Created by CHEN PEIHAO on 2021/8/10.
//

import Foundation


class Constellation {
    //自定義三個型別內容個為字串 星座名字 星座開始的日期 星座結束的日期
    var name: String       //星座名稱
    var startDate: String //星座開始日
    var stopDate: String  //星座結束日
    
    //初始化數值自己的初始數值等於上面的定義好的數值
    init(name: String, startDate: String, stopDate: String) {
        self.name = name
        self.startDate = startDate
        self.stopDate = stopDate
    }
    
    
    //建立function來判斷需要的值 帶入的參數值為DateComponents格式 並回傳布林值
    func CheckDateInterval(dateComponent: DateComponents) -> Bool {
        //先嘗試取值若有執行下面的程式碼
        //日期跟年份都透過預計傳入的參數dateComponent.date or .year去取得值
        if let date = dateComponent.date, let year = dateComponent.year {
            //定義一個字串start為取得的年份加上自身的星座開始日期
            let start = "\(year)/\(self.startDate)"
            //定義一個字串end為取得年份加上自身的星座結束日期
            let end = "\(year)/\(self.stopDate)"

            //定義dateFormatter取得DateFormatter()
            let dateFormatter = DateFormatter()
            //定義日期格式為"yy/MM/dd"
            dateFormatter.dateFormat = "yy/MM/dd"
            
            //如果起始日大於結束日（摩羯座）
            if startDate > stopDate {
                if let start1 = dateFormatter.date(from: start), let end1 = dateFormatter.date(from: "\(year)/12/31"), let start2 = dateFormatter.date(from: "\(year)/01/01"), let end2 = dateFormatter.date(from: end){
                    return DateInterval(start: start1, end: end1).contains(date) || DateInterval(start: start2, end: end2).contains(date)
                }
            } else { //其餘星座
                if let start = dateFormatter.date(from: start), let end = dateFormatter.date(from: end) {
                    return DateInterval(start: start, end: end).contains(date)
                }
            }
        }
        return false
    }
}
