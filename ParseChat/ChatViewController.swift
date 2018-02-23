//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Hoang on 2/21/18.
//  Copyright © 2018 Hoang. All rights reserved.
//

import Parse
import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fetchMessages), userInfo: nil, repeats: true)
    }
    
    @objc func fetchMessages() {
        let query = Message.query()
        query?.addDescendingOrder("createdAt")
        query?.includeKey("user")
        
        //query?.limit = 20
        
        query?.findObjectsInBackground(block: { (messages, error) in
            if let messages = messages as? [Message] {
                self.messages = messages
            }
            else {
                print(error?.localizedDescription)
            }
            self.tableView.reloadData()
        })
    }
    
    @IBAction func sendPresssed(_ sender: UIButton) {
        let message = PFObject(className: "Message")
        message["text"] = textfield.text ?? ""
        message["user"] = PFUser.current()
        
        message.saveInBackground { (success, error) in
            if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.chatLabel.text = message.text
        
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "🤖"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}


class ChatCell: UITableViewCell {
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
}
