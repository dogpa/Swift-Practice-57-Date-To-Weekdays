//
//  ViewController.swift
//  Swift Practice # 57 Date To Weekdays
//
//  Created by CHEN PEIHAO on 2021/8/10.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //選擇日期的datepicker
    @IBOutlet weak var selectDatePicker: UIDatePicker!
    //顯示星期幾的segmented Controller
    @IBOutlet weak var weekdaysSegmentController: UISegmentedControl!
    //農曆的label
    @IBOutlet weak var moondayLabel: UILabel!
    //datepicker的年份label
    @IBOutlet weak var yearsOfpickerLabel: UILabel!
    //閏年與否的label
    @IBOutlet weak var leapYeasLabel: UILabel!
    //星座顯示的PickerView
    @IBOutlet weak var zodiacPickerView: UIPickerView!
    

    //透過constellation的自訂型別指定出12星座的名聲 以及開始日期 以及結束的日期
    var constellations = [
        Constellation(name: "♈️ 熱情如火牡羊座", startDate: "3/21", stopDate: "4/19"),
        Constellation(name: "♉️ 內斂穩固金牛座", startDate: "04/20", stopDate: "05/20"),
        Constellation(name: "♊️ 百變玲瓏雙子座", startDate: "05/21", stopDate: "06/20"),
        Constellation(name: "♋️ 溫情如水巨蟹座", startDate: "06/21", stopDate: "07/22"),
        Constellation(name: "♌️ 掌握自我獅子座", startDate: "07/23", stopDate: "08/22"),
        Constellation(name: "♍️ 細緻眼界處女座", startDate: "08/23", stopDate: "09/22"),
        Constellation(name: "♎️ 平衡之木天秤座", startDate: "09/23", stopDate: "10/22"),
        Constellation(name: "♏️ 意象魔幻天蠍座", startDate: "10/23", stopDate: "11/21"),
        Constellation(name: "♐️ 天天開心射手座", startDate: "11/22", stopDate: "12/21"),
        Constellation(name: "♑️ 邏輯之星摩羯座", startDate: "12/22", stopDate: "01/19"),
        Constellation(name: "♒️ 自由意識水瓶座", startDate: "01/20", stopDate: "02/18"),
        Constellation(name: "♓️ 無敵感性雙魚座", startDate: "02/19", stopDate: "03/20")
    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    
    //透過function帶入年份判斷閏年回傳1or2的數值 1為閏 2為不是閏
    func leapYearCheck(year: Int) -> Int {
        if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0 && year % 3200 != 0){
            return 1
        }else{
            return 2
        }
    }
    
    
    
    func updateUI () {
        
        //判斷農曆
        //使用DateFormatter()功能指派給format
        let format = DateFormatter()
        //日期的顯示格式
        format.dateStyle = .long
        format.timeStyle = .none
        //月曆的顯示規格指派為農民曆模式
        format.calendar = Calendar(identifier: .chinese)
        //地點指派為台灣地區
        format.locale = Locale(identifier: "zh-TW")
        //透過選擇的selectDatePicker.date取得的日期指派給 date
        let date = selectDatePicker.date
        //透過可以使用DateFormatter()的format來顯示透過selectDatePicker.date取得的日期（字串）
        let showString = format.string(from: date)
        //將字串顯示在農民曆的label上
        moondayLabel.text = showString
        print(showString)
        
        
        //判斷星期後丟給segmented controller
        //指派dateComponent取得透過selectDatePicker.date取得的日期
        let dateComponent = Calendar.current.dateComponents(in: TimeZone.current, from: selectDatePicker.date)
        // weekdaysSegmentController的顯示位置透過現在取得的星期幾 - 1 //系統星期一為星期日所以減1
        weekdaysSegmentController.selectedSegmentIndex = dateComponent.weekday! - 1
        
        
        
        //判斷閏年
        //透過剛剛的日期格式
        if let year = dateComponent.year {
            yearsOfpickerLabel.text = "\(year)"
           
            //透過剛剛定義好的閏年function  leapYearCheck 來得到 1 or 2的回傳數字
            let oneOrTwo = leapYearCheck(year: year)
            //1為閏顯示label為閏字體紅色
            if oneOrTwo == 1 {
                leapYeasLabel.text = "是閏年"
                leapYeasLabel.textColor = .red
            //不是閏字體黑色 顯示不是閏年
            }else if oneOrTwo == 2 {
                leapYeasLabel.text = "不是閏年"
                leapYeasLabel.textColor = .black
            }
            
        }
        
        
        //判斷星座
        for (i, constellation) in constellations.enumerated() {
            if constellation.CheckDateInterval(dateComponent: dateComponent) {
                zodiacPickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        
    }
    
    @IBAction func dateChoose(_ sender: UIDatePicker) {
        updateUI()
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return constellations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return constellations[row].name
    }
    
    
}

