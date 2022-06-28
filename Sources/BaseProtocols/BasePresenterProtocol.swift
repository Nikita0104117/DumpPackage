//
//  BasePresenterProtocol.swift
//  
//
//  Created by Nikita Omelchenko on 28.06.2022.
//

public protocol BasePresenterProtocol {
    associatedtype C: BaseControllerInput
    associatedtype I
    associatedtype R
    
    var controller: C? { get set }
    var interactor: I? { get set }
    var router: R? { get set }
}
