//
//  Extension.swift
//  Hi-Chat
//
//  Created by BJIT-SAKIB on 7/11/22.
//

import UIKit

extension UIView{
    public var width:CGFloat {
        return self.frame.size.width
    }

    public var height:CGFloat {
        return self.frame.size.height
    }

    public var top:CGFloat {
        return self.frame.origin.y
    }

    public var bottom:CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }

    public var left:CGFloat {
        return self.frame.origin.x
    }

    public var right:CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

extension String{
    public func flatEmail()->String{
        let email = self.replacingOccurrences(of: "@", with: "-")
        let newEmail = email.replacingOccurrences(of: ".", with: "-")
        return newEmail
    }
}
