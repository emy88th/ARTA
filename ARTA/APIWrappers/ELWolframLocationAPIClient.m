//
//  ELWolframAPIClient.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWolframLocationAPIClient.h"
#import "AFXMLRequestOperation.h"
#import "ELWolframConstants.h"

@implementation ELWolframLocationAPIClient

+ (ELWolframLocationAPIClient *)sharedClient {
    static ELWolframLocationAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kWolframApiBaseURL]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self registerHTTPOperationClass:[AFXMLRequestOperation class]];
        return self;
    }
    
    return nil;
}

- (void)informationPodsRegardingTheLocation:(NSString *)location {
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:location, kWolframGeneralInputParam, kWolframApiID, kWolframApiIDParam, nil];
    
    __block id delegate = self;
    
    [self getPath:kWolframGeneralQueryParam parameters:paramDictionary 
          success:^(AFHTTPRequestOperation *operation, id xmlParser) {
              [(NSXMLParser *)xmlParser setDelegate:delegate];
              [(NSXMLParser *)xmlParser parse];
              
    } 
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
    
	NSLog(@"elementName:%@, attributes:%@", elementName, attributeDict);
}

@end
