//
//  ProjectsModel.swift
//  TrendingProject
//
//  Created by Shival Pandya on 8/20/18.
//  Copyright © 2018 Shival Pandya. All rights reserved.
//

import Foundation


struct ProjectsModel: Decodable {
    let total_count: Int?
    let items: [ItemData]?
}

struct ItemData: Decodable {
    let id: Int?
    let name: String?
    let full_name: String?
    let description: String?
    let stargazers_count: Int?
    let language: String?
    let forks_count: Int?
    let owner: Owner?
}

struct Owner: Decodable {
    let id: Int?
    let avatar_url: String?
    let url: String?
}
