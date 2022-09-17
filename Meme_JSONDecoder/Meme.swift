//
//  Meme.swift
//  Meme_JSONDecoder
//
//  Created by jr on 2022/9/16.
//

import Foundation

struct Meme:Decodable{

    let src:URL
    let contest:Contest
    let createdAt:CreateAt
    
    struct Contest:Decodable{
        let name:String
    }
    
    struct CreateAt:Decodable{
        let dateTimeString:Date
    }
}
