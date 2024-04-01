//
//  LoadScreenViewController.swift
//  TaskList
//
//  Created by Brandon Yen on 4/1/24.
//

import UIKit

class LoadScreenViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitName(_ sender: Any) {
        performSegue(withIdentifier: "toTaskList", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TaskListViewController {
            let destinationVC = segue.destination as! TaskListViewController
            destinationVC.name = nameTextField.text!
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
