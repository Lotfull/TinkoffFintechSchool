//
//  ChatsListViewController.swift
//  TinkoffChat
//
//  Created by Kam Lotfull on 05.10.17.
//  Copyright © 2017 Kam Lotfull. All rights reserved.
//

import UIKit
import CoreData

class ChatsListViewController: UIViewController, ChatsListDelegate {
    
//    var coreDataStack: CoreDataStack!
//
//    // MARK: - ChatsListDelegate
//    func updateUI(with chats: [[Chat]]) {
//        DispatchQueue.main.async {
//            self.chats = chats
//            self.updateChatsList()
//        }
//    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var model: IChatsListModel!
    
    var chats = [[Chat]]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func initWith(model: IChatsListModel) -> ChatsListViewController {
        let chatsListVC = UIStoryboard(name: "ChatsList", bundle: nil).instantiateViewController(withIdentifier: "ChatsListViewController") as! ChatsListViewController
        chatsListVC.model = model
        return chatsListVC
    }
    
    let chatsTableViewCellName = "ChatCell"
    let chatsTableViewCellID = "ChatCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: chatsTableViewCellName, bundle: nil)
        model.setup(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        model.newChatsFetch()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = chats[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatAssembly().chatViewController()
        chatVC.chat = chat
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @IBAction func presentProfile(_ sender: Any) {
        let profileVC = ProfileAssembly().profileViewController()
        let navigationController = UINavigationController.init(rootViewController: profileVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func updateChatsList() {
        tableView.reloadData()
    }
    
    private let sectionName = ["Online", "History"]
}

