//
//  UIImageView.swift
//  iCode
//
//  Created by Mohamed Shafraz on 20/10/2014.
//  Copyright (c) 2014 Shafraz. All rights reserved.
//
/*

Copyright (c) 2014, Shafraz Buhary
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

import UIKit

extension UIImageView {
    
    var placeHolderImage:UIImage? {
        set {
            self.image = newValue
        }
        get {
            return self.image
        }
    }
    
    func imageWithURL(urlString:String?) {
        
        if urlString == nil {return}
        
        let url = NSURL(string: urlString!.urlEncodedString)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let httpResponse = response as! NSHTTPURLResponse
                if httpResponse.statusCode == 200 {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.image = UIImage(data: data!)
                    })
                }
            }
        })
        task.resume()
    }
    
    func setImageWithoutStrach(image:UIImage) {
        
        var frame = self.frame
        
        let frameWidth = frame.size.width
        let frameHeight = frame.size.height
        let imageWidthHeightRasio = image.size.width / image.size.height
        
        let mult = (frameWidth / imageWidthHeightRasio) < frameHeight ? (frameWidth / imageWidthHeightRasio) : frameHeight
        
        frame.size.width = mult * imageWidthHeightRasio
        frame.size.height = mult

        frame.origin.x = frame.origin.x + (frameWidth - frame.size.width) / 2
        frame.origin.y = frame.origin.y + (frameHeight - frame.size.height) / 2
        
        self.frame = frame
        
        self.image = image
    }
    
}
