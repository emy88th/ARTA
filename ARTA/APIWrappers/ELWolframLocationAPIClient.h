//
//  ELWolframAPIClient.h
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"

@interface ELWolframLocationAPIClient : AFHTTPClient

+ (ELWolframLocationAPIClient *)sharedClient;

- (void)informationPodsRegardingTheLocation:(NSString *)location withBlock:(void (^)(NSArray *pods))block;

@end
