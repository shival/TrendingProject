//
//  ProjectsViewModel.swift
//  TrendingProject
//
//  Created by Shival Pandya on 8/20/18.
//  Copyright © 2018 Shival Pandya. All rights reserved.
//

import Foundation
import PKHUD

class ProjectsViewModel {
    
    //Closures
    var refreshUI: (()->())?
    var showErrorAlert: ((String) -> ())?
    
    var projectModel: ProjectsModel? {
        didSet {
            //Update UI
            refreshUI?()
        }
    }
    
    var itemsArray: [ItemData]? {
        guard let itemsArray = projectModel?.items else { return nil }
        return itemsArray
    }
}

// MARK: - API Calls
extension ProjectsViewModel {
    
    func getTrendingProjects() {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        Webservice.genericRequest(parameters: nil, urlString: ApiURL.swiftTrendingProjects, httpMethod: nil) { [weak self] (projects: ProjectsModel?, err) in
            PKHUD.sharedHUD.hide()
            if err != nil {
                //Show error
                if let error = err?.description {
                    self?.showErrorAlert?(error)
                }
                return
            }
            
            guard let projectsModel = projects else {
                self?.showErrorAlert?("Unable to load.")
                return
            }
            self?.projectModel = projectsModel
        }
    }
}
