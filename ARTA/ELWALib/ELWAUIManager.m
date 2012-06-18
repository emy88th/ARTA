//
//  ELWAUIManager.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWAUIManager.h"
#import "UIView-Additions.h"
#import "UIImageView+AFNetworking.h"
#import "UILabel-Additions.h"

@implementation ELWAUIManager

+ (ELWAUIManager *)sharedManager {
    static ELWAUIManager *_sharedManager = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark - UIFactory

- (UIView *)createResponseViewForPod:(ELWolframLocationDataModel *)dataModel {
    UIImage *containerBackground = [[UIImage imageNamed:@"result-grey.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 10, 30, 10)];
    UIImageView *containerBackgroundImageView = [[UIImageView alloc] initWithImage:containerBackground];
    containerBackgroundImageView.frame = CGRectMake(0, 0, containerBackground.size.width, 0);
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerBackground.size.width + 5, 0)];
    containerView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:containerBackgroundImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, containerBackground.size.width - 10, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    titleLabel.text = dataModel.title;
    [titleLabel wrapLabelBasedOnWidth];
    
    int spaceBetweenTitleAndResult = 5;
    UIImageView *responseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, dataModel.imageWidth, dataModel.imageHeight)];
    responseImageView.backgroundColor = [UIColor clearColor];
    [responseImageView setImageWithURL:[NSURL URLWithString:dataModel.imageUrlString]];
    [responseImageView moveUnderView:titleLabel withSpaceBetween:spaceBetweenTitleAndResult];
    
    CGRect containerBackgroundRect = containerBackgroundImageView.frame;
    containerBackgroundRect.size.height = [titleLabel suggestedHeightForLabelText] + dataModel.imageHeight + spaceBetweenTitleAndResult + 25;
    containerBackgroundImageView.frame = containerBackgroundRect;
    
    CGRect containerViewRect = containerView.frame;
    containerViewRect.size.height = containerBackgroundRect.size.height;
    containerView.frame = containerViewRect;
    
    [containerView addSubview:titleLabel];
    [containerView addSubview:responseImageView];
    
    return containerView;
}


@end
