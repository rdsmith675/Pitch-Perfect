//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Richard smith on 7/24/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import Foundation



class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init (filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}