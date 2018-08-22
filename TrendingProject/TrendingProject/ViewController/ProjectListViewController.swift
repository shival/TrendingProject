//
//  ViewController.swift
//  TrendingProject
//
//  Created by Shival Pandya on 8/20/18.
//  Copyright © 2018 Shival Pandya. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController {

    struct CellIdentifier {
        static let productListIdentifier = "cellID"
    }
    
    @IBOutlet weak var repoSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProjectsViewModel()
    var repoArray = [ItemData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Github Trends"
        
        //Register all closures
        setupClosures()
        
        //Dynamic tableViewcell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 89
        
        //API call
        viewModel.getTrendingProjects()
    }

    private func setupClosures() {
        
        //Show error alert closure
        viewModel.showErrorAlert = { [weak self] errorString in
            Alert.showAlert(title: "Error", message: errorString, vc: self!, buttonsTitleArray: ["OK"])
        }
        
        //Refresh UI closure
        viewModel.refreshUI = { [weak self] in
            if let itemArray = self?.viewModel.itemsArray {
                self?.repoArray = itemArray
            }
            
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDatasource
extension ProjectListViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.productListIdentifier, for: indexPath) as! ProjectListCell
        
        cell.configCell(projectItem: repoArray[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.itemData = repoArray[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UISearchBar Delegates
extension ProjectListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let itemData = viewModel.itemsArray, let text = searchBar.text {

            // filter searched text repo
            repoArray = itemData.filter({ (value) -> Bool in
                return (value.name?.lowercased().contains(text.lowercased()))!
            })

            tableView.reloadData()
        }
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        view.endEditing(true)
        
        //Assign values to array
        if let itemData = viewModel.itemsArray {
            repoArray = itemData
            tableView.reloadData()
        }
    }
}
