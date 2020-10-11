//
//  AuthLoginModel.swift
//  Auth
//
//  Created by hacoma on 2020/10/11.
//

import Foundation

public enum AuthLoginModel {
    
    public struct Request {
        
        let username: String
        let password: String
        let isRemember: Bool
        
        public init(username: String, password: String, isRemember: Bool) {
            self.username = username
            self.password = password
            self.isRemember = isRemember
        }
    }
    
    public enum Response {
        
        public struct DTO: Decodable {
            
            public let success: Bool
            public let data: Data
            
            public struct Data: Decodable {
                
                public let sid: String
                public let username: String
                
                enum RootKeys: String, CodingKey {
                    case sid, username
                }
                
                init(sid: String = "", username: String = "") {
                    self.sid = sid
                    self.username = username
                }
                
                public init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: RootKeys.self)
                    sid = try container.decodeIfPresent(String.self, forKey: .sid) ?? ""
                    username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
                }
            }
            
            enum RootKeys: String, CodingKey {
                case success, data
            }
            
            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: RootKeys.self)
                success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? false
                data = try container.decodeIfPresent(Data.self, forKey: .data) ?? Data()
            }
        }
        
        public enum Error: Swift.Error {
            
            case parsingFailed
            case unknown(Swift.Error)
        }
    }
}
