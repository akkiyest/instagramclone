//
//  PostTableViewCell.swift
//  
//
//  Created by Akihiro Itoh on 2016/10/04.
//
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setPostData(postData: PostData) {
        postImageView.image = postData.image
        captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(postData.date!)
        dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
    }
    
}
