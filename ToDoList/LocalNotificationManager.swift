//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by Alexander Falcone on 3/29/20.
//  Copyright © 2020 Alexander Falcone. All rights reserved.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    
    static func authorizeLocalNotificiations(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notificaiton granted")
            } else {
                print("The User has denied notifications")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive alerts for reminderes, open the Settings app, select To Do List > Notifications > Allow Notifications.")
                }
                
            }
        }
    }
    
    static func isAuthroized(completed: @escaping (Bool)->() ) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Notificaiton granted")
                completed(true)
            } else {
                print("The User has denied notifications")
                completed(false)
            }
        }
    }
    
    
    
    static func setCalendarNotificaiton(title: String, subTitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
           let content = UNMutableNotificationContent()
           content.title = title
           content.subtitle = subTitle
           content.body = body
           content.sound = sound
           content.badge = badgeNumber
           
           //Create Trigger
           var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
           dateComponents.second = 00
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
           
           // Create Request
           let notificationID = UUID().uuidString
           let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
           
           //register Request
           UNUserNotificationCenter.current().add(request) { (error) in
               if let error = error {
                   print("ERROR: \(error.localizedDescription)")
               } else {
                   print("Notification Scheduled \(notificationID), title: \(content.title)")
               }
           }
           
           return notificationID
       }
    
    
}
