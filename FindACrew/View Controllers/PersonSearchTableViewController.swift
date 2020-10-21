//
//  PersonSearchTableViewController.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PersonSearchTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let personController = PersonController()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personController.people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath) as! PersonTableViewCell
        let person = personController.people[indexPath.row]
        
        cell.person = person
        
        return cell
    }
}

extension PersonSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let term = searchBar.text else { return }
        
        searchBar.resignFirstResponder()//Use to hide keyboard upon return pressed
        
        self.personController.searchForPeople(searchTerm:  term) {
        DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
