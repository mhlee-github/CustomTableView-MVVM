//
//  MainModel.swift
//  TableView-MVVM
//
//  Created by mhlee on 2018. 5. 10..
//  Copyright © 2018년 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import Differentiator

enum ArrayEvent {
  case inserted
  case removed
  case replaced
}

// enum error

protocol ListModelInput {
  func insert(string: String, at: Int) // throw error on invalid index
  func remove(at: Int) // throw error on invalid index
  func replace(texts: [String])
}

protocol ListModelOutput {
  var textsEvents: PublishSubject<ArrayEvent> { get }
}

class ListModel: ListModelInput, ListModelOutput {
  private(set) var texts: [String] = [String]()
  private(set) var textsEvents: PublishSubject<ArrayEvent> = PublishSubject<ArrayEvent>()
  
  func insert(string: String, at: Int) {
    texts.insert(string, at: at)
    textsEvents.onNext(.inserted) // enum에 at를 저장할 수 있다.
  }
  
  func remove(at: Int) {
    texts.remove(at: at)
    textsEvents.onNext(.removed) // enum에 at를 저장할 수 있다.
  }
  
  func replace(texts: [String]) {
    self.texts = texts
    textsEvents.onNext(.replaced) // enum에 texts를 저장할 수 있다.
  }
}
