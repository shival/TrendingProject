//
//  ProjectListCell.swift
//  TrendingProject
//
//  Created by Shival Pandya on 8/20/18.
//  Copyright © 2018 Shival Pandya. All rights reserved.
//

import UIKit

class ProjectListCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configCell(projectItem: ItemData) {
        projectNameLabel.text = projectItem.name
        starCountLabel.text = "Star Count: \(projectItem.stargazers_count ?? 0)"
        descriptionLabel.text = projectItem.description
    }
}
