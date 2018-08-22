//
//  DetailViewController.swift
//  TrendingProject
//
//  Created by Shival Pandya on 8/21/18.
//  Copyright © 2018 Shival Pandya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var authorImage: CachedImageView!
    @IBOutlet weak var numberOfStars: UILabel!
    @IBOutlet weak var numberOfForks: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    var itemData: ItemData? {
        didSet {
            if let apptitle = itemData?.name {
                title = apptitle
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authorImage.layer.cornerRadius = 50
        authorImage.layer.masksToBounds = true
        // Update UI
        updateUI()
    }

    private func updateUI() {
        
        if let login = itemData?.owner?.login {
            userNameLabel.text = login
        }
        
        if let starCount = itemData?.stargazers_count {
            numberOfStars.text = "\(starCount) Stars"
        }
        
        if let forkCount = itemData?.forks_count {
            numberOfForks.text = "\(forkCount) Forks"
        }
        
        if let description = itemData?.description {
            repoDescription.text = description
        }
        
        if let imageURL = itemData?.owner?.avatar_url {
            authorImage.loadImageUsingURLString(urlString: imageURL)
        }
    }
}
