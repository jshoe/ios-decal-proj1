//
//  ViewController.swift
//  Tasks
//
//  Created by Jonathan Sheu on 10/10/15.
//  Copyright © 2015 Jonathan Sheu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var taskTextView: UITextField!
    @IBOutlet var allTasksListView: UITableView!
    @IBOutlet var isDoneCount: UILabel!
    
    var checkmark = UITableViewCellAccessoryType.Checkmark
    
    @IBAction func newTaskButton(sender: UIButton) {
        taskController.addTask(taskTextView.text!)
        self.view.endEditing(true)
        taskTextView.text = ""
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func loadTableView(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        allTasksListView?.reloadData()
        isDoneCount?.text = String(taskController.countCompletedTasks())
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskController.removePastTasks()
        return taskController.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row: UITableViewCell = UITableViewCell()
        row.textLabel!.text = taskController.tasks[indexPath.row].name
        if (taskController.tasks[indexPath.row].isDone) { row.accessoryType = checkmark }
        return row
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        row.selectionStyle = UITableViewCellSelectionStyle.None
        var doneFlag = taskController.tasks[indexPath.row].isDone
        if (doneFlag) { row.accessoryType = UITableViewCellAccessoryType.None }
        else { row.accessoryType = checkmark }
        doneFlag = !doneFlag
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){ // swipe to delete
            taskController.tasks.removeAtIndex(indexPath.row)
            viewWillAppear(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
