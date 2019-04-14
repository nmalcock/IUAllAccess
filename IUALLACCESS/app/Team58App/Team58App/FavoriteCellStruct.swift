//
//  FavoriteCellStruct.swift
//  ContactsLBTA
//
//  Created by Becky Poplawski on 3/25/19.
//  Copyright © 2019 Lets Build That App. All rights reserved.
//

import Foundation

struct ExpandableTeams {
    var isExpanded: Bool
    var teams: [Favorite]
}

struct Favorite {
    var indexPathTapped: Bool
}
