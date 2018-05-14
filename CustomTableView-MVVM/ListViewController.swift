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
  
  var customView = ListView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(customView)
    
    customView.snp.makeConstraints { make in
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
//    print("!!!")
    customView.addButton.rx.tap
      .subscribe(onNext: {
//        print("1")
        self.listViewModel.addNewRow()
      }).disposed(by: disposeBag)
    
    customView.removeButton.rx.tap
        .subscribe(onNext: {
//        print("2")
        self.listViewModel.removeFirstRow()
      })
      .disposed(by: disposeBag)

    customView.tableView.dataSource = self
    customView.tableView.delegate = self
//    listViewModel.strings.bind(to: customView.tableView.rx
//      .items(cellIdentifier: ListView.cellIdentifier, cellType: UITableViewCell.self)) {  row, element, cell in
//        cell.textLabel?.text = "\(element) \(row)"
//      }
//      .disposed(by: disposeBag)
  }
}


extension ListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return listViewModel.numberOfListViewSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listViewModel.numberOfListViewRows(inSection: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier) as! TableViewCell
    
    let text = listViewModel.textForListViewCell(atSection: indexPath.section, atRow: indexPath.row)
    
    cell.textLabel?.text = text
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "section header #\(section)"
  }
}

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
}
