//
//  Ext+TableView.swift
//  Vero-TaskApp
//
//  Created by MacBook on 30/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import UIKit

extension UITableView {
    
    func delegateRegister(sender: NSObject, cell: UITableViewCell.Type) {
        self.delegate = sender as? UITableViewDelegate
        self.dataSource = sender as? UITableViewDataSource
        self.registerCell(id: cell)
    }
    
    
    func dequeueTVCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
    
    func registerCell(id: UITableViewCell.Type) {
        let _id = String(describing: id)
        self.register(UINib(nibName: _id, bundle: nil), forCellReuseIdentifier: _id)
    }
}
