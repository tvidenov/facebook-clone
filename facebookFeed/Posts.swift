//
//  Posts.swift
//  facebookFeed
//
//  Created by Tihomir Videnov on 11/27/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import Foundation

class Posts {
    
    private let postsList: [Post]
    
    init() {
        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.postStatusText = "Getting ready to demo something new we've been building in virtual reality. Tune in tomorrow at 10am pacific time to hear about the future of VR at Oculus Connect."
        postMark.profileImageName = "zuckprofile"
        //        postMark.statusImageName = "zuckPost"
        postMark.statusImageUrl = "https://dl.dropboxusercontent.com/u/48453924/appAssets/zuckPost.jpg"
        postMark.numLikes = 300
        postMark.numComments = 632
        
        let postElon = Post()
        postElon.name = "Elon Musk"
        postElon.postStatusText = "\"The Hitchhiker's Guide to the Galaxy\": It taught me that the tough thing is figuring out what questions to ask, but that once you do that, the rest is really easy."
        postElon.profileImageName = "elon"
        //postElon.statusImageName = "elonStatus"
        postElon.statusImageUrl = "https://dl.dropboxusercontent.com/u/48453924/appAssets/elonStatus.jpg"
        postElon.numLikes = 953
        postElon.numComments = 404
        
        let postJimmy = Post()
        postJimmy.name = "Jimmy Fallon"
        postJimmy.postStatusText = "Join us tonight to see our special guest - The Weeknd!"
        postJimmy.profileImageName = "jimmy"
        //        postJimmy.statusImageName = "jimmyStatus"
        postJimmy.statusImageUrl = "https://dl.dropboxusercontent.com/u/48453924/appAssets/jimmyStatus.jpg"
        postJimmy.numLikes = 100
        postJimmy.numComments = 223
        

        postsList = [postMark, postElon, postJimmy]
    }
    
    func numberOfPosts() -> Int {
        return postsList.count
    }
    
    subscript(indexPath: IndexPath) -> Post {
        get {
            return postsList[indexPath.item]
        }
    }
}
