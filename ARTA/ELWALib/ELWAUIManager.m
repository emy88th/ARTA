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
#import "UIImage-Additions.h"

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
    containerBackgroundImageView.frame = CGRectMake(15, 0, containerBackground.size.width, 0);
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(containerBackgroundImageView.frame.origin.x, 0, containerBackground.size.width, 0)];
    containerView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:containerBackgroundImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(containerBackgroundImageView.frame.origin.x + 15, 0, containerBackground.size.width - 10, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    titleLabel.text = dataModel.title;
    [titleLabel wrapLabelBasedOnWidth];
    
    int spaceBetweenTitleAndResult = 5;
    UIImageView *responseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(containerBackgroundImageView.frame.origin.x + 6, 0, dataModel.imageWidth, dataModel.imageHeight)];
    responseImageView.backgroundColor = [UIColor clearColor];
    responseImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    BOOL imageWasEmbeddedInScrollView = NO;
    UIScrollView *scrollableContainer = nil;
    
    if (dataModel.imageWidth > containerBackground.size.width) {
        scrollableContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(containerBackgroundImageView.frame.origin.x + 6, 0, containerBackground.size.width - 7, dataModel.imageHeight + 7)];
        [scrollableContainer setContentSize:CGSizeMake(dataModel.imageWidth, dataModel.imageHeight)];
        
        CGRect responseImageViewRect = responseImageView.frame;
        responseImageViewRect.origin.x -= 6;
        responseImageView.frame = responseImageViewRect;
        [scrollableContainer addSubview:responseImageView];
        imageWasEmbeddedInScrollView = YES;
    }
    
    [responseImageView setImageWithURL:[NSURL URLWithString:dataModel.imageUrlString]];
    
    if (imageWasEmbeddedInScrollView)
        [scrollableContainer moveUnderView:titleLabel withSpaceBetween:spaceBetweenTitleAndResult];
    else
        [responseImageView moveUnderView:titleLabel withSpaceBetween:spaceBetweenTitleAndResult];
    
    CGRect containerBackgroundRect = containerBackgroundImageView.frame;
    containerBackgroundRect.size.height = [titleLabel suggestedHeightForLabelText] + dataModel.imageHeight + spaceBetweenTitleAndResult + 25;
    containerBackgroundImageView.frame = containerBackgroundRect;
    
    CGRect containerViewRect = containerView.frame;
    containerViewRect.size.height = containerBackgroundRect.size.height;
    containerView.frame = containerViewRect;
    
    [containerView addSubview:titleLabel];
    
    if (imageWasEmbeddedInScrollView)
        [containerView addSubview:scrollableContainer];
    else
        [containerView addSubview:responseImageView];
    
    return containerView;
}

- (UIScrollView *)createResponseScrollViewForPodsArray:(NSArray *)podsArray withSize:(CGSize)scrollViewSize spaceBetweenPods:(int)spaceBetweenPods {
    
    UIScrollView *containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
    
    int scrollContentSizeYOffset = 0;
    UIView *tempResponseView = nil;
    
    for ( ELWolframLocationDataModel *dataModel in podsArray) {
        if (!scrollContentSizeYOffset) {
            tempResponseView = [self createResponseViewForPod:dataModel];
            CGRect tempRect = tempResponseView.frame;
            tempRect.origin.y = 10;
            tempResponseView.frame = tempRect;
            [containerScrollView addSubview:tempResponseView];
            
            scrollContentSizeYOffset += tempResponseView.frame.size.height + tempRect.origin.y;
            continue;
        }
        
        UIView *responseViewForPod = [self createResponseViewForPod:dataModel];
        [responseViewForPod moveUnderView:tempResponseView withSpaceBetween:spaceBetweenPods];
        scrollContentSizeYOffset += responseViewForPod.frame.size.height + spaceBetweenPods;
        tempResponseView = responseViewForPod;
        [containerScrollView addSubview:responseViewForPod];
        
        //Adding the bulets
        UIImage *bulletImage = [UIImage imageNamed:@"bullet.png"];
        UIImageView *bulletImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bullet.png"]];
        bulletImageView.frame = CGRectMake(5, responseViewForPod.frame.origin.y + responseViewForPod.frame.size.height / 2 - bulletImage.size.height, bulletImage.size.width, bulletImage.size.height);
        [containerScrollView addSubview:bulletImageView];
    }
    
    // Adding the timeline image
    UIImage *timeLineImage = [[UIImage imageNamed:@"line.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)];
    UIImageView *timeLineImageView = [[UIImageView alloc] initWithImage:timeLineImage];
    timeLineImageView.contentMode = UIViewContentModeScaleToFill;
    CGRect timeLineRect = timeLineImageView.frame;
    timeLineRect.origin.x = 10;
    timeLineRect.origin.y = - 400;
    timeLineRect.size.height = scrollContentSizeYOffset + 400 * 2;
    timeLineImageView.frame = timeLineRect;
    
    [containerScrollView addSubview:timeLineImageView];
    
    [containerScrollView setContentSize:CGSizeMake(containerScrollView.frame.size.width, scrollContentSizeYOffset + spaceBetweenPods)];
    
    return containerScrollView;
}


@end
