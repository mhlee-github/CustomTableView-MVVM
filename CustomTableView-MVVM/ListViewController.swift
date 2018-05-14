//
//  ListViewController.swift
//  TableView-MVVM
//
//  Created by mhlee on 2018. 5. 10..
//  Copyright © 2018년 mhlee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ListViewController: UIViewController {
  let disposeBag = DisposeBag()
  
  var listViewModel: ListViewModel!
  
//  var listView: ListView! {
//    return view as! ListView
//  }

  var listView = ListView()
  
//  override func loadView() {
//    view = ListView()
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(listView)
    
    listView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalTo(view)
    }
    
    listViewModel = ListViewModel()
    
    bind()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func bind() {
    listView.addButton.rx.tap
      .subscribe {
        self.listViewModel.addNewRow()
      }
      .disposed(by: disposeBag)

    listView.removeButton.rx.tap
      .subscribe {
        self.listViewModel.removeFirstRow()
      }
      .disposed(by: disposeBag)
    
    listViewModel.strings.bind(to: listView.tableView.rx
      .items(cellIdentifier: ListView.cellIdentifier, cellType: UITableViewCell.self)) {  row, element, cell in
        cell.textLabel?.text = "\(element) \(row)"
      }
      .disposed(by: disposeBag)
  }
}

