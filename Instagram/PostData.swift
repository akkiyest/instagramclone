//
//  PostData.swift
//  Instagram
//
//  Created by Akihiro Itoh on 2016/10/04.
//  Copyright © 2016年 akihiro.itoh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = valueDictionary["name"] as? String
        
        caption = valueDictionary["caption"] as? String
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDictionary["time"] as! NSTimeInterval)
    }
}
