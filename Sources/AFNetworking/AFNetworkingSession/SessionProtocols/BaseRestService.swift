//
//  File.swift
//  
//
//  Created by Nikita Omelchenko on 02.07.2022.
//

public protocol BaseRestService {
    var restClient: NetworkingSessionProtocol { get }
}
