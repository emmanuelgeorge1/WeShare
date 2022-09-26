//
//  PostData.swift
//  WeShare
//
//  Created by Emmanuel George on 05/09/22.
//

import Foundation
struct PostData:Codable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
    
}
struct PostComment:Decodable {
    let postId:Int
    let id:Int
    let name:String
    let email:String
    let body:String
}
