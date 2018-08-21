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
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProjectsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Github Trends"
    }

    override func viewWillAppear(_ animated: Bool) {
        
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
            print("Data received")
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
        return viewModel.itemsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.productListIdentifier, for: indexPath) as! ProjectListCell
        if let itemData = viewModel.itemsArray {
            cell.configCell(projectItem: itemData[indexPath.row])
        }
        return cell
    }
}
