//
//  feedCell.swift
//  facebookFeed
//
//  Created by Tihomir Videnov on 11/26/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    func animateImage() {
        
        feedController?.animateImateView(statusImageView: statusImageView)
    }
    
    var feedController: FeedController?
    
    var imageCache = NSCache<NSString, UIImage>()
    
    var post: Post? {
        
        didSet{
            
            statusImageView.image = nil
            activityIndicatorView.startAnimating()
            
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: "\nNovember 14 • San Francisco • ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                
                let attachment = NSTextAttachment()
                attachment.image = #imageLiteral(resourceName: "globe_icon")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText
            }
            
            if let statusText = post?.postStatusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
//            if let statusImageName = post?.statusImageName {
//                statusImageView.image = UIImage(named: statusImageName)
//            }
            
            
            if let statusImageUrl = post?.statusImageUrl {
                
                if let image = imageCache.object(forKey: statusImageUrl as NSString) {
                    statusImageView.image = image
                    activityIndicatorView.stopAnimating()
                } else {
                    let url = URL(string: statusImageUrl)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error ?? "")
                            return
                        }
                        let image = UIImage(data: data!)
                        
                        self.imageCache.setObject(image!, forKey: statusImageUrl as NSString)
                        
                        DispatchQueue.main.async {
                            self.statusImageView.image = image
                            self.activityIndicatorView.stopAnimating()
                        }
                        
                    }).resume()
                }
            }
        }
    }
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let profileImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "zuckprofile")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
        
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = "This is a test text"
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "320 Likes  2k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let dividerLineView: UIView = {
       let view = UIView()
       view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
       return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.hidesWhenStopped = true
        aiv.color = .black
        aiv.startAnimating()
        return aiv
    }()
    
    let likeButton: UIButton = FeedCell.buttonWithTitle(title: "LIke", imageName: "like")
    let commentButton: UIButton = FeedCell.buttonWithTitle(title: "Comment", imageName: "comment")
    let shareButton: UIButton = FeedCell.buttonWithTitle(title: "Share", imageName: "share")
    
    static func buttonWithTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named:imageName), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateImage)))
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        statusImageView.addSubview(activityIndicatorView)
        statusImageView.addConstraintsWithFormat(format: "H:|[v0]|", views: activityIndicatorView)
        statusImageView.addConstraintsWithFormat(format: "V:|[v0]|", views: activityIndicatorView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView,likeButton)
        
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
    }
    
    
}
