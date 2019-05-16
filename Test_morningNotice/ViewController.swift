//
//  ViewController.swift
//  Test_morningNotice
//
//  Created by 神原良継 on 2019/05/14.
//  Copyright © 2019 YoshitsuguKambara. All rights reserved.
//

import UIKit
import UserNotifications



// アクションをenumで宣言
enum ActionIdentifier1: String {
    case actionMorning
}

// アクションをenumで宣言

enum ActionIdentifier: String {
    case actionOne
    case actionTwo
    case actionThree
}

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    
    var morning: Int = 0
    
    var one: Float = 0.0
    var two: Float = 0.0
    var three: Float = 0.0
    
    var resultOne: String = ""
    var resultTwo: String = ""
    var resultThree: String = ""
    var Result: String = ""
    
    
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var labelResult: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // アクション設定
        let actionMorning = UNNotificationAction(identifier: ActionIdentifier1.actionMorning.rawValue,
                                             title: "起きた！",
                                             options: [.foreground])
    
        
        let category1 = UNNotificationCategory(identifier: "category_morning",
                                              actions: [actionMorning],
                                              intentIdentifiers: [],
                                              options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category1])
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        
        let content1 = UNMutableNotificationContent()
        content1.title = "起きましたか？"
        content1.body = "起きたらタップしてください！"
        content1.sound = UNNotificationSound.default
        
        // categoryIdentifierを設定
        content1.categoryIdentifier = "category_morning"
        
        //🙅‍♀️ 60秒ごとに繰り返し通知
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        //毎朝6時に送信する
        let date = DateComponents(hour:19, minute:17, second:33)
        let trigger1 = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        
        
        let request1 = UNNotificationRequest(identifier: "notification1",
                                            content: content1,
                                            trigger: trigger1)
        
        // 通知登録
        UNUserNotificationCenter.current().add(request1, withCompletionHandler: nil)
        
    }
    
    // アクションを選択した際に呼び出されるメソッド
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: () -> Swift.Void) {
        
        
        // 「おきた！」がタップされたあと、、、
        switch response.actionIdentifier {
            
        case ActionIdentifier1.actionMorning.rawValue:
            
            let actionOne = UNNotificationAction(identifier: ActionIdentifier.actionOne.rawValue,
                                                 title: "投資",
                                                 options: [.foreground])
            let actionTwo = UNNotificationAction(identifier: ActionIdentifier.actionTwo.rawValue,
                                                 title: "消費",
                                                 options: [.foreground])
            let actionThree = UNNotificationAction(identifier: ActionIdentifier.actionThree.rawValue,
                                                   title: "浪費",
                                                   options: [.foreground])
            
            let category = UNNotificationCategory(identifier: "category_select",
                                                  actions: [actionOne, actionTwo, actionThree],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            
            
            let content = UNMutableNotificationContent()
            content.title = "この１時間はどうでしたか？"
            content.body = "時間の使い方を選択してください"
            content.sound = UNNotificationSound.default
            
            // categoryIdentifierを設定
            content.categoryIdentifier = "category_select"
            
            // 60秒ごとに繰り返し通知
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            //let date = DateComponents(hour:9, minute:0)
            //let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            
            
            let request = UNNotificationRequest(identifier: "notification",
                                                content: content,
                                                trigger: trigger)
            
            // 通知登録
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            print("test1")
            @available(iOS 10.0, *)
            func userNotificationCenter(_ center: UNUserNotificationCenter,
                                        didReceive response: UNNotificationResponse,
                                        withCompletionHandler completionHandler: () -> Swift.Void) {
                
                // 選択されたアクションごとに処理を分岐
                
                print("test2")
                switch response.actionIdentifier {
                    
                case ActionIdentifier.actionOne.rawValue:
                    print("test3")
                    // 具体的な処理をここに記入
                    // 変数oneをカウントアップしてラベルに表示
                    one = one + 1.0
                    label1.text = String(one)
                    
                case ActionIdentifier.actionTwo.rawValue:
                    // 具体的な処理をここに記入
                    two = two + 1.0
                    label2.text = String(two)
                    
                case ActionIdentifier.actionThree.rawValue:1
                    three = three + 1.0
                    label3.text = String(three)
                    
                default:
                    ()
                }
                
                completionHandler()
            }
            
            
       
            
      
            
        default:
            ()
        }
        
        completionHandler()
    }
    
    
    @IBAction func result(_ sender: Any) {
        resultOne = String(Int((one / (one + two + three)) * 10))
        resultTwo = String(Int((two / (one + two + three)) * 10))
        resultThree = String(Int((three / (one + two + three)) * 10))
        
        Result = resultOne + ":" + resultTwo + ":" + resultThree
        
        labelResult.text = Result
        
    }
    
    
    
    
}
