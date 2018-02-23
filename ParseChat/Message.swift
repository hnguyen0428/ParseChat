//
//  Message.swift
//  ParseChat
//
//  Created by Hoang on 2/22/18.
//  Copyright © 2018 Hoang. All rights reserved.
//

import Parse

class Message: PFObject, PFSubclassing {
    @NSManaged var text: String
    @NSManaged var user: PFUser
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Message"
    }
    
}
