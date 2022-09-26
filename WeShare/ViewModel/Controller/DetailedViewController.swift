//
//  DetailedViewController.swift
//  WeShare
//
//  Created by Emmanuel George on 05/09/22.
//

import UIKit

class DetailedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var post : PostData?
    var comment = [PostComment]()
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(PostCommentTableViewCell.nib(), forCellReuseIdentifier: PostCommentTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        fetchPostComments()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    fileprivate func fetchPostComments(){
        RestServices.shared.fetchComments(userId:post!.userId) { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch post:",err)
            case .success(let comment):
                self.comment = comment
                self.tableView.reloadData()
            }
        }
    }
    func sortingData(array:[PostComment]) -> [PostComment] {
        return array.sorted(by: {$0.id > $1.id})
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortingData(array: comment).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTableViewCell.identifier, for: indexPath) as! PostCommentTableViewCell
            let data = sortingData(array:comment)[indexPath.row]
            cell.nameLabel.text = data.name
            cell.emailLabel.text = data.email
            cell.commentLabel.text = data.body
            return cell
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: PostTableViewCell.identifier)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 18.0)
            cell?.textLabel?.numberOfLines = 0
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.textLabel?.text = post!.title.capitalized
            cell?.detailTextLabel?.text = post!.body.capitalized
        }
        return cell!
    }

}
