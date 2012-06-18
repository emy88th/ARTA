//
//  ELWAUIManager.h
//  ARTA
//
//  Created by Lupu Emanuel on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELWolframLocationDataModel.h"

@interface ELWAUIManager : NSObject

+ (ELWAUIManager *)sharedManager;

#pragma mark - UIFactory

- (UIView *)createResponseViewForPod:(ELWolframLocationDataModel *)dataModel;

@end
