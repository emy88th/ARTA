//
//  ELMainViewController.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELMainViewController.h"
#import "ELWolframAlphaAPIClient.h"
#import "ELWAUIManager.h"

@implementation ELMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[ELWolframAlphaAPIClient sharedClient] informationPodsForInput:@"Iasi" withBlock:^(NSArray *resultPods) {
        if (resultPods) {
            NSArray *_resultPods = resultPods;
            
            [self.view addSubview:[[ELWAUIManager sharedManager] createResponseScrollViewForPodsArray:_resultPods withSize:CGSizeMake(320, 480) spaceBetweenPods:30]];
        }        
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
