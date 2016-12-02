//
//  FeedController.swift
//  facebookFeed
//
//  Created by Tihomir Videnov on 11/26/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    //MARK:- Properties
    let cellId = "cellId"
    
    //Uncomment this to generate the posts manually
    //var posts = GeneratePosts()
    
    var posts = [Post]()
    
    var postsFromJson = Post()
    
    let blackBackground = UIView()
    
    var statusImageView: UIImageView?
    
    let zoomImageView = UIImageView()
    
    let navBarCoverView = UIView()
    
    let tabBarCover = UIView()

    
    //MARK:- View
    override func viewDidLoad() {
        super.viewDidLoad()

        //Another way to set the caching for the images is to increase the default system caching to a higher numbers
//        let memoryCapacity = 500 * 1024 * 1024
//        let diskCapacity = 500 * 1024 * 1024
//        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
//        URLCache.shared = urlCache
        
        
        
            
            if let path = Bundle.main.path(forResource: "posts", ofType: "json") {
                
                do {
                    
                    let data = try (NSData(contentsOfFile: path, options: Data.ReadingOptions.mappedIfSafe))
                    
                    let jsonDictionary = try(JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)) as? [String: Any]
                    print(jsonDictionary)
                    
                    if let postsArray = jsonDictionary?["posts"] as? [[String: Any]] {
                        
                            self.posts = [Post]()
                        
                        for postDictionary in postsArray {
                            let post = Post()
                            post.setValuesForKeys(postDictionary)
                            self.posts.append(post)
                        }
                    }
                    
                } catch let err {
                    print(err)
                }
                
            }
        
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
    
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }

    //MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
//        if let name = posts[indexPath.item].name {
//            feedCell.nameLabel.text = name
//        }
 
        feedCell.post = posts[indexPath.item]
        feedCell.feedController = self
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].postStatusText {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeght: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSize(width: view.frame.width, height: rect.height + knownHeght + 24)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    //MARK:- Animation
    func animateImateView(statusImageView: UIImageView) {
        
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            statusImageView.alpha = 0
            
            blackBackground.frame = self.view.frame
            blackBackground.backgroundColor = .black
            blackBackground.alpha = 0
            view.addSubview(blackBackground)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = .black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                
                tabBarCover.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tabBarCover.backgroundColor = .black
                tabBarCover.alpha = 0
                keyWindow.addSubview(tabBarCover)
            }
            
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackground.alpha = 1
                
                self.navBarCoverView.alpha = 1
                
                self.tabBarCover.alpha = 1
                
            }, completion: nil)
        }
    }
    
    func zoomOut() {
        
        if let startingFrame = statusImageView!.superview?.convert(statusImageView!.frame, to: nil) {
        
                UIView.animate(withDuration: 0.75, animations: { 
                    self.zoomImageView.frame = startingFrame
                    
                    self.blackBackground.alpha = 0
                    self.navBarCoverView.alpha = 0
                    self.tabBarCover.alpha = 0
                    
                }, completion: { (didComplete) in
                    self.zoomImageView.removeFromSuperview()
                    self.blackBackground.removeFromSuperview()
                    self.statusImageView?.alpha = 1
                    self.navBarCoverView.removeFromSuperview()
                    self.navBarCoverView.alpha = 1
                    self.tabBarCover.removeFromSuperview()
                })
        }
    }
    
    

}

