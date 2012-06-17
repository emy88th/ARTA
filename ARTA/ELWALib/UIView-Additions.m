//
//  UIView-Additions.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView-Additions.h"

@implementation UIView(ELAdditions)

- (void) mooveUnderView:(UIView*)topView withSpaceBetween:(float)spaceBetween {
    CGRect newFrame = self.frame;
    newFrame.origin = topView.frame.origin;
    
    if(topView.hidden == NO && topView.alpha != 0) {
        newFrame.origin.y = CGRectGetMaxY(topView.frame) + spaceBetween;
    }
    
    newFrame.origin.x = self.frame.origin.x;
    self.frame=newFrame;
}

@end
