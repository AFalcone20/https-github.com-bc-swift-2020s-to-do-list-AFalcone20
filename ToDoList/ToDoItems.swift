//
//  ToDoItems.swift
//  ToDoList
//
//  Created by Alexander Falcone on 3/28/20.
//  Copyright © 2020 Alexander Falcone. All rights reserved.
//

import Foundation
import UserNotifications


class ToDoItems {
    var itemsArray: [ToDoItem] = []
    
    
    func saveData ()  {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(itemsArray)
        do{
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("bad \(error.localizedDescription)")
        }
        setNotification()
    }
    
    func loadData(completed: @escaping ()->()) {
           let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
           let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")

           guard let data = try? Data(contentsOf: documentURL) else {return}
           let jsonDecoder = JSONDecoder()
           do {
               itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
        
           } catch {
               print("bad \(error.localizedDescription)")
           }
            completed()
       }
    
    
    func setNotification() {
        guard itemsArray.count > 0 else {
            return
        }
        
        //Remove all notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        //Re-create
        for index in 0..<itemsArray.count {
            if itemsArray[index].reminderSet {
                let toDoItem = itemsArray[index]
                itemsArray[index].notificationID = LocalNotificationManager.setCalendarNotificaiton(title: toDoItem.name, subTitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
            }
        }
    }
    
    
}
