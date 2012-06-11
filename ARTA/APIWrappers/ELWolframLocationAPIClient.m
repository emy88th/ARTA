//
//  ELWolframAPIClient.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWolframLocationAPIClient.h"
#import "AFKissXMLRequestOperation.h"
#import "ELWolframConstants.h"
#import "DDXMLDocument.h"

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
        [self registerHTTPOperationClass:[AFKissXMLRequestOperation class]];
        return self;
    }
    
    return nil;
}

- (void)informationPodsRegardingTheLocation:(NSString *)location {
    
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:location, kWolframGeneralInputParam, kWolframApiID, kWolframApiIDParam, [NSString stringWithFormat:@"%@,%@", kWolframImageDatatype, kWolframPlaintextDatatype], kWolframResultsFormatParam, nil];
    
    [self getPath:kWolframGeneralQueryParam parameters:paramDictionary 
          success:^(AFHTTPRequestOperation *operation, id xmlDocument) {
              
              DDXMLDocument *documentToParse = (DDXMLDocument *)xmlDocument;
              
              NSError *error = nil;
              NSArray *pods = [documentToParse nodesForXPath:@"/queryresult/pod" error:&error];
              
              NSLog(@"pods:%@",pods);
              
    } 
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

@end
