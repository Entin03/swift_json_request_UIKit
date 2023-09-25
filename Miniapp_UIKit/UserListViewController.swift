//
//  UserListViewController.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 21..
//
import UIKit

class UserListViewController: UITableViewController {
    private let viewModel = UserListViewModel(networkManager: NetworkManager.shared)
    private var filteredUsers: [User] = []
    private var isSearchActive = false
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(rgb: 0xA1CCD1)
        setupUI()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        title = "Users"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.fetchUsers {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredUsers.count : viewModel.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        
        // Az alapértelmezett stílusú cella használata
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        // A cella tartalmának beállítása
        cell.textLabel?.text = user.name
        cell.textLabel?.textColor = UIColor(rgb: 0x27374D)
        
        cell.detailTextLabel?.text = user.email
        cell.detailTextLabel?.textColor = UIColor(rgb: 0x526D82)
        
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(rgb: 0x61677A).withAlphaComponent(0.2)
        cell.textLabel?.textColor = UIColor(rgb: 0x27374D)
        
        let cornerRadius: CGFloat = 30
            if indexPath.row == 0 {
                // Első cella: bal felső és jobb felső sarkok lekerekítése
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == viewModel.users.count - 1 {
                // Utolsó cella: bal alsó és jobb alsó sarkok lekerekítése
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                // Köztes cellák: ne legyenek lekerekített sarkok
                cell.layer.maskedCorners = []
            }
        cell.layer.cornerRadius = cornerRadius
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        let postViewController = PostListViewController(user: user, networkManager: NetworkManager.shared)
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    func setupUI() {
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        if !searchText.isEmpty {
            filterContentForSearchText(searchText)
        }
    }

    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            // Ha a keresőszöveg üres, megjelenítjük az összes felhasználót
            filteredUsers = viewModel.users
        } else {
            // Keresés a felhasználók között a név alapján
            filteredUsers = viewModel.users.filter { user in
                user.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        tableView.reloadData()
    }
}
