//
//  ListView.swift
//  TableView-MVVM
//
//  Created by mhlee on 2018. 5. 10..
//  Copyright © 2018년 mhlee. All rights reserved.
//

import UIKit
import SnapKit

class ListView: UIView {
  static let cellIdentifier = "cell"
  
  let addButton: UIButton = {
    let button = UIButton()
    button.setTitle("add", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let removeButton: UIButton = {
    let button = UIButton()
    button.setTitle("remove", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .red
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ListView.cellIdentifier)

    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setViews()
    layoutViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setViews()
    layoutViews()
  }
  
  func setViews() {
    backgroundColor = .white
    addSubview(addButton)
    addSubview(removeButton)
    addSubview(tableView)
  }
  
  func layoutViews() {
    addButton.snp.makeConstraints { make in
      make.right.equalTo(self.snp.centerX).offset(-20)
      make.top.equalTo(self).offset(30)
    }
    
    removeButton.snp.makeConstraints { make in
      make.left.equalTo(self.snp.centerX).offset(20)
      make.top.equalTo(self).offset(30)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(addButton.snp.bottom).offset(20)
      make.left.right.bottom.equalTo(self)
    }
  }
}
