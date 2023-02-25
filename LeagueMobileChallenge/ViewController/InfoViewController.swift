//
//  InfoViewController.swift
//  LeagueMobileChallenge
//
//  Created by Gurpreet Kaur on 24/02/23.
//  Copyright © 2023 Kelvin Lau. All rights reserved.
//

import UIKit
import SDWebImage

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var infoTableView: UITableView!
    
    let spinner = UIActivityIndicatorView(style: .gray)
    var postsData = [Posts]()
    var usersData = [Users]()
    var infoMergedData: [Info] = []
    private var isWaiting = false {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.rowHeight = UITableView.automaticDimension
        infoTableView.estimatedRowHeight = 200.0
        infoTableView.backgroundView = spinner
        
        // API calling
        self.fetchAPIData()
        
    }
    
    // MARK: - API call and data handling
    func fetchAPIData() {
        // Step1: Call user token API
        self.isWaiting = true
        APIController.shared.fetchUserToken(userName: "", password: "") { token, error in
            if (token != nil)
            {
                // Step2: Call users API
                let decoder = JSONDecoder()
                APIController.shared.fetchUsers { users, error in
                    if (error == nil) {
                    guard let users = users else { return }
                    do {
                        let usersModel = try decoder.decode([Users].self, from: users as! Data)
                        self.usersData.append(contentsOf: usersModel)
                        // Step3: Call posts API
                        APIController.shared.fetchPosts { posts, error in
                            if (error == nil) {
                                do {
                                    let postsModel = try decoder.decode([Posts].self, from: posts as! Data)
                                    self.postsData.append(contentsOf: postsModel)
                                    
                                    // Merge Users and Posts data into Info
                                    for usersModel in self.usersData {
                                        if let postsModel = self.postsData.first(where: { $0.id == usersModel.id }) {
                                            let infoModel = Info( id: usersModel.id, username: usersModel.username, avatar: usersModel.avatar, title: postsModel.title, body: postsModel.body)
                                            self.infoMergedData.append(infoModel)
                                        }
                                    }
                                    DispatchQueue.main.async {
                                        self.infoTableView.reloadData()
                                    }
                                } catch {
                                    debugPrint(error.localizedDescription)
                                }
                            } else {
                                self.infoTableView.isHidden = true
                                self.errorLabel.isHidden = false
                            }
                        }
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                    } else {
                        self.infoTableView.isHidden = true
                        self.errorLabel.isHidden = false
                    }
                }
            } else {
                self.spinner.stopAnimating()
                self.infoTableView.isHidden = true
                self.errorLabel.isHidden = false
            }
        }
        // Step4: Update the UI
        self.isWaiting = false
    }
    
    private func updateUI() {
        if !self.isWaiting {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
    
    
    // MARK: - Table view delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoMergedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        let infoModel = infoMergedData[indexPath.row]
        
        cell.username.text = infoModel.username
        cell.title.text = infoModel.title
        cell.bodyLabel.text = infoModel.body
        cell.avatarImage.sd_setImage(with: URL(string: infoModel.avatar))
        
        return cell
    }
}

