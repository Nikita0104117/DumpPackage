//
//  BaseInteractorProtocol.swift
//  
//
//  Created by Nikita Omelchenko on 28.06.2022.
//

public protocol BaseInteractor {
    associatedtype T: BaseInteractorOutput

    var output: T? { get set }
}

public protocol BaseInteractorOutput {
    func success(with message: String?)
    func failure(with error: String?)
}

public extension BaseInteractorOutput {
    func success(with message: String?) { }
    func failure(with error: String?) { }
}

