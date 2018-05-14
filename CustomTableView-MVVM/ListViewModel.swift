//
//  ListViewModel.swift
//  TableView-MVVM
//
//  Created by mhlee on 2018. 5. 10..
//  Copyright © 2018년 mhlee. All rights reserved.
//

import Foundation
import RxSwift

protocol ListViewModelInput {
  func addNewRow()
  func removeFirstRow()
}

protocol ListViewModelOutput {
  var strings: Observable<[String]> { get }
}

class ListViewModel {
  
  let listModel: ListModel
  
  init() {
    listModel = ListModel()
  }
}

extension ListViewModel: ListViewModelInput {
  func addNewRow() {
    let string = UUID().uuidString
    listModel.add(string)
  }
  
  func removeFirstRow() {
    listModel.removeFirst()
  }
}

extension ListViewModel: ListViewModelOutput {
  var strings: Observable<[String]> { return listModel.strings.asObservable() }
}
