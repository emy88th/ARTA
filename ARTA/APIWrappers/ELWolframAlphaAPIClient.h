//
//  ELWolframAPIClient.h
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"

@interface ELWolframAlphaAPIClient : AFHTTPClient

+ (ELWolframAlphaAPIClient *)sharedClient;

- (void)informationPodsForInput:(NSString *)inputString withBlock:(void (^)(NSArray *pods))block;

@end
