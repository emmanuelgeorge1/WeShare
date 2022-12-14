//
//  DashboardTableViewController.swift
//  WeShare
//
//  Created by Emmanuel George on 04/09/22.
//
import UIKit
import SwipeCellKit

class DashboardTableViewController: UITableViewController,SwipeTableViewCellDelegate {
    var posts = [PostData]()
    var postTitle = ""
    var postBody = ""
    var roundButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        roundButton.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
        roundButton.backgroundColor = UIColor.systemBlue
        roundButton.tintColor = .white
        roundButton.layer.shadowRadius = 10
        roundButton.layer.shadowOpacity = 0.4
        let image = UIImage(systemName: K.ImageName.postButtonIcon,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium ))
        roundButton.setImage(image, for: .normal)
        roundButton.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.view.addSubview(roundButton)
        NSLayoutConstraint.activate([
            roundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            roundButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
            roundButton.widthAnchor.constraint(equalToConstant: 65),
            roundButton.heightAnchor.constraint(equalToConstant: 65)])
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard roundButton.superview != nil else {  return }
        DispatchQueue.main.async {
            self.roundButton.removeFromSuperview()
        }
    }
    func fetchPosts(){
        RestServices.shared.fetchPosts { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch post:",err)
            case .success(let posts):
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    @objc private func buttonTaped(){
        print("button pressed")
        let alert = UIAlertController(title: "Title of the Post", message: "Message", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title of the Post"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Body of the message"
        }
        alert.addAction(UIAlertAction(title: "Post", style: .cancel, handler: { [weak alert] (_) in
            if let textField = alert?.textFields?[0], let userText = textField.text {
                self.postTitle = userText
            }
            if let textField = alert?.textFields?[0], let userText = textField.text {
                self.postBody = userText
            }
            RestServices.shared.createPost(title: self.postTitle, body:self.postBody ) { err in
                if let err = err{
                    print("Falied to create cell \(err)")
                }
                else{
                    print("Sucessfully cerated post ")
                    self.tableView.reloadData()
                }
            }
        }))
        let cancel = UIAlertAction(title:"Cancel", style: .default) { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = K.appName
        label.textAlignment = .center
        self.navigationItem.titleView = label
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.dashboardCellId, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title.capitalized
        cell.detailTextLabel?.text = post.body.capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            let post = self.posts[indexPath.row]
            RestServices.shared.deletePost(id: post.id) { (err) in
                if let err = err{
                    print("Falied to delete cell\(err)")
                }
                else{
                    print("Sucessfully deleted ")
                }
            }
            self.posts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        // customize the action appearance
        deleteAction.image = UIImage(systemName: K.ImageName.deleteIcon)
        return [deleteAction]
    }
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.NavigationId.detailedTableSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedViewController {
            destination.post = posts[tableView.indexPathForSelectedRow!.row]
        }
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        displayAlert(withTitle: "SIGN OUT ", message: "Are you sure you want to sign out? ")
    }
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let logout = UIAlertAction(title: "Yes", style: .destructive) { (action: UIAlertAction!) in
            AuthViewModel.shared.logOut()
                self.navigationController?.popToRootViewController(animated: true)
        }
        let cancel = UIAlertAction(title:"No", style: .cancel) { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(logout)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
