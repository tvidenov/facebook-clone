//
//  FeedController.swift
//  facebookFeed
//
//  Created by Tihomir Videnov on 11/26/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.postStatusText = "Getting ready to demo something new we've been building in virtual reality. Tune in tomorrow at 10am pacific time to hear about the future of VR at Oculus Connect."
        postMark.profileImageName = "zuckprofile"
        postMark.statusImageName = "zuckPost"
        postMark.numLikes = 300
        postMark.numComments = 632
        
        let postElon = Post()
        postElon.name = "Elon Musk"
        postElon.postStatusText = "\"The Hitchhiker's Guide to the Galaxy\": It taught me that the tough thing is figuring out what questions to ask, but that once you do that, the rest is really easy."
        postElon.profileImageName = "elon"
        postElon.statusImageName = "elonStatus"
        postElon.numLikes = 953
        postElon.numComments = 404
        
        let postJimmy = Post()
        postJimmy.name = "Jimmy Fallon"
        postJimmy.postStatusText = "Join us tonight to see our special guest - The Weeknd!"
        postJimmy.profileImageName = "jimmy"
        postJimmy.statusImageName = "jimmyStatus"
        postJimmy.numLikes = 100
        postJimmy.numComments = 223
        
        posts.append(postMark)
        posts.append(postElon)
        posts.append(postJimmy)
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
    
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
//        if let name = posts[indexPath.item].name {
//            feedCell.nameLabel.text = name
//        }
 
        feedCell.post = posts[indexPath.item]
        
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
    
}

