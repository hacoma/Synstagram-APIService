//
//  AuthService.swift
//  Auth
//
//  Created by hacoma on 2020/10/11.
//

import Foundation
import HacomaNetwork

public final class AuthService {
    
    private let provider = NetworkProvider<AuthNetworkTarget>()
    
    public init() {
        // available outside of the framework
    }
}

extension AuthService {
    
    public typealias LoginCompletion = (Result<AuthLoginModel.Response.DTO, AuthLoginModel.Response.Error>) -> Void
    
    public func requestIsAlreadyLogin(completion: @escaping LoginCompletion) {
        let target = AuthNetworkTarget(route: .isAlreadyLogin)
        
        provider.request(target: target) { result in
            switch result {
            case .success(let response):
                guard let loginDTO = try? JSONDecoder().decode(AuthLoginModel.Response.DTO.self, from: response.data) else {
                    completion(.failure(AuthLoginModel.Response.Error.parsingFailed))
                    return
                }
                completion(.success(loginDTO))
            case .failure(let error):
                completion(.failure(.unknown(error)))
            }
        }
    }
    
    public func requestLogin(request: AuthLoginModel.Request, completion: @escaping LoginCompletion) {
        let target = AuthNetworkTarget(route: .login(request: request))
        
        provider.request(target: target) { result in
            switch result {
            case .success(let response):
                guard let loginDTO = try? JSONDecoder().decode(AuthLoginModel.Response.DTO.self, from: response.data) else {
                    completion(.failure(AuthLoginModel.Response.Error.parsingFailed))
                    return
                }
                completion(.success(loginDTO))
            case .failure(let error):
                completion(.failure(.unknown(error)))
            }
        }
    }
}

extension AuthService {
    
    public typealias LogoutCompletion = (Result<AuthLogoutModel.Response.DTO, AuthLogoutModel.Response.Error>) -> Void
    
    public func requestLogout(completion: @escaping LogoutCompletion) {
        let target = AuthNetworkTarget(route: .logout)
        provider.request(target: target) { result in
            switch result {
            case .success(let response):
                guard let logoutDTO = try? JSONDecoder().decode(AuthLogoutModel.Response.DTO.self, from: response.data) else {
                    completion(.failure(AuthLogoutModel.Response.Error.parsingFailed))
                    return
                }
                completion(.success(logoutDTO))
            case .failure(let error):
                completion(.failure(.unknown(error)))
            }
        }
    }
}
