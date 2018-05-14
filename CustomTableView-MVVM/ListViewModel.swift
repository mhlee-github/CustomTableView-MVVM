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
  func numberOfListViewSections() -> Int
  func numberOfListViewRows(inSection section: Int) -> Int
  func textForListViewCell(atSection section: Int, atRow row: Int) -> String
  
  func addNewRow()
  func removeFirstRow()
}

enum ListViewModelEvent {
  case test
}

protocol ListViewModelOutput {
  var listViewModelEventQueue: PublishSubject<ListViewModelEvent> { get }
}

class ListViewModel {
  private let disposeBag = DisposeBag()
  
  private let listModel: ListModel
  private let eventQueue: PublishSubject<ListViewModelEvent> = PublishSubject<ListViewModelEvent>()
  
  init() {
    listModel = ListModel()
        
    listModel.textsEvents.subscribe(onNext: { event in
      print(event)
    }).disposed(by: disposeBag)
  }
}

extension ListViewModel: ListViewModelInput {
  func numberOfListViewSections() -> Int {
    return 3
  }
  
  func numberOfListViewRows(inSection section: Int) -> Int {
    return 3
  }
  
  func textForListViewCell(atSection section: Int, atRow row: Int) -> String {
    return "text"
  }
  
  func addNewRow() {
    let string = UUID().uuidString
    listModel.insert(string: string, at: 0)
  }
  
  func removeFirstRow() {
    if listModel.texts.count > 0 {
      listModel.remove(at: 0)
    }
  }
}

extension ListViewModel: ListViewModelOutput {
  var listViewModelEventQueue: PublishSubject<ListViewModelEvent> { return eventQueue }
}
