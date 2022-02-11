//
//  ChatViewController.swift
//  RocketChat
//
//  Created by Aurelio Le Clarke on 09.02.2022.
//


import UIKit
import Firebase
    
class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("There is a error retrieving a data from Firestore \(e)")
            }else {
                if let queryDocuments =  querySnapshot?.documents {
                    for doc in queryDocuments {
                       let data =  doc.data()
                        if let MessageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField]as? String {
                            let newMessage = Message(sender: MessageSender, body: messageBody)
                            self.messages.append(newMessage)
                           
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                          
                            
                        }
                    }
                }
            }
        }
    }
    
   

   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        title = K.appName
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier )
    loadMessages()
        
    }
    
    
    
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970])
                    { (error) in
                if let e  = error {
                    print("There is issue saving a data to Firestore \(e)")
                }else {
                    print("Successfully saved a data")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                    
                }
            }
        }
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            navigationController?.popToRootViewController(animated: true)
            
            try Auth.auth().signOut()
        }  catch let  signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell  = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.lightGray
        }
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}
