//
//  AuthLogoutModel.swift
//  Auth
//
//  Created by hacoma on 2020/10/11.
//

import Foundation

public enum AuthLogoutModel {
    
    public enum Response {
        
        public struct DTO: Decodable {
            
            public let success: Bool
            
            enum RootKeys: String, CodingKey {
                case success
            }
            
            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: RootKeys.self)
                success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? false
            }
        }
        
        public enum Error: Swift.Error {
            
            case parsingFailed
            case unknown(Swift.Error)
        }
    }
}
