//
//  UILabel-Additions.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabel-Additions.h"

@implementation UILabel(ELAdditions)

- (float)suggestedHeightForLabelText {
	CGSize textSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	float suggestedSize = [[NSString stringWithFormat:@"%.2f", textSize.height] floatValue];
	
	return suggestedSize;
}

- (void)wrapLabelBasedOnWidth {
    CGRect newFrame=[self frame];
    newFrame.size.height=[self suggestedHeightForLabelText];
    self.frame=newFrame;
}

@end
