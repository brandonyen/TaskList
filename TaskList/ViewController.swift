//
//  ViewController.swift
//  TaskList
//
//  Created by Brandon Yen on 4/1/24.
//

import UIKit

var listSize = 0

class TaskListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerLabel: UILabel!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if name != "" {
            headerLabel.text = name + "'s Tasks"
        } else {
            headerLabel.text = "Tasks"
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func addTask(_ sender: Any) {
        listSize += 1
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: listSize - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TaskViewCell
        cell.tableView = tableView
        cell.taskButton.setImageTintColor(UIColor.opaqueSeparator)
        cell.taskTextField.text = ""
        cell.taskTextField.textColor = UIColor.label
        return cell
    }
}

class TaskViewCell: UITableViewCell {
    @IBOutlet var taskButton: UIButton!
    @IBOutlet var taskTextField: UITextField!
    var state = false
    var buttonColor: UIColor!
    var textColor: UIColor!
    var tableView: UITableView!
    
    @IBAction func completeTask(_ sender: Any) {
        if state {
            textColor = UIColor.label
            buttonColor = UIColor.opaqueSeparator
            state = false
        } else {
            textColor = UIColor.opaqueSeparator
            buttonColor = UIColor.systemGreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                if self.state {
                    let indexPath = self.tableView.indexPath(for: self)!
                    listSize -= 1
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.tableView.endUpdates()
                }
            })
            state = true
        }
        
        UIView.transition(with: taskButton, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.taskButton.setImageTintColor(self.buttonColor)
        })
        UIView.transition(with: taskTextField, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.taskTextField.textColor = self.textColor
        })
    }
}

extension UIButton {
    func setImageTintColor(_ color: UIColor) {
            let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.setImage(tintedImage, for: .normal)
            self.tintColor = color
        }
}
