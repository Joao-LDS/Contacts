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
        let group = Group(context: coreData.context)
        group.name = name
        coreData.save()
        loadGroups()
    }
    
    func loadGroups() {
        self.groups = coreData.fetchGroups() ?? []
    }
    
    func deleteGroup(at indexPath: IndexPath) {
        coreData.deleteObject(groups[indexPath.row])
        self.groups.remove(at: indexPath.row)
    }
    
}
