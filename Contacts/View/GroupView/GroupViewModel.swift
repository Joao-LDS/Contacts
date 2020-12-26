//
//  GroupViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation


class GroupViewModel: FormViewModelDelegate {
    
    // MARK: - Properties
    let coreData = CoreDataStack.shared
    var groups: [Group] = []
    
    // MARK: - FormViewModelDelegate
    var selectedGroup: Group?
    
    // MARK: - Init
    init(viewModel: FormViewModel) {
        viewModel.delegate = self
    }
    
    // MARK: - Func
    func addGroupWith(name: String) {
        if name != Constants.String.empty {
            let group = Group(context: coreData.context)
            group.name = name
            coreData.save()
            loadGroups()
        }
    }
    
    func loadGroups() {
        self.groups = coreData.fetchGroups() ?? []
    }
    
    func editGroup(At index: Int, with name: String) {
        let group = groups[index]
        group.name = name
        coreData.save()
    }
    
}
