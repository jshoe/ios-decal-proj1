//
//  Main.swift
//  Tasks
//
//  Created by Jonathan Sheu on 10/10/15.
//  Copyright © 2015 Jonathan Sheu. All rights reserved.
//

import Foundation
import UIKit

var taskController: TaskController = TaskController()

struct task {
    var name = ""
    var isDone = false
    var start_date = NSDate()
}

class TaskController: NSObject {
    var tasks = [task]()
    
    func addTask(name: String){
        let date = NSDate()
        tasks.append(task(name:name, isDone:false, start_date:date))
    }

    func removePastTasks(){
        var n = tasks.count
        var i = 0
        while (i < tasks.count){
            let hours = (NSDate().timeIntervalSinceDate(tasks[i].start_date)) / 3600
            if (Int(hours) >= 24){
                tasks.removeAtIndex(i)
                n -= 1
            }
            i += 1
        }
    }
    
    func countCompletedTasks() -> Int{
        var n = 0
        if tasks.count > 0 {
            for i in 0...tasks.count-1 {
                let hours = (NSDate().timeIntervalSinceDate(tasks[i].start_date)) / 3600
                if (tasks[i].isDone && Int(hours) <= 24) { n += 1 }
            }
        }
        return n
    }
}
