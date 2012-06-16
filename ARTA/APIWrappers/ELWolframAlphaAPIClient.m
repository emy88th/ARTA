//
//  ELWolframAPIClient.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWolframAlphaAPIClient.h"
#import "AFKissXMLRequestOperation.h"
#import "ELWolframConstants.h"
#import "DDXMLDocument.h"
#import "ELWolframLocationDataModel.h"

@implementation ELWolframAlphaAPIClient

+ (ELWolframAlphaAPIClient *)sharedClient {
    static ELWolframAlphaAPIClient *_sharedClient = nil;
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

- (void)informationPodsForInput:(NSString *)inputString withBlock:(void (^)(NSArray *pods))block {
    
    // Notify that a request is in progress
    [[NSNotificationCenter defaultCenter] postNotificationName:kWolframRequestInProgressNotification object:nil];
    
    // Prepare the request params
    NSDictionary *paramDictionary = [NSDictionary dictionaryWithObjectsAndKeys:inputString, kWolframGeneralInputParam, kWolframApiID, kWolframApiIDParam, [NSString stringWithFormat:@"%@", kWolframImageDatatype], kWolframResultsFormatParam, nil];
    
    // Launch the request 
    [self getPath:kWolframGeneralQueryParam parameters:paramDictionary 
          success:^(AFHTTPRequestOperation *operation, id xmlDocument) {
              [[NSNotificationCenter defaultCenter] postNotificationName:kWolframRequestFinishedNotification object:nil];
              
              DDXMLDocument *documentToParse = (DDXMLDocument *)xmlDocument;
              
              // Scan for pod nodes
              NSError *error = nil;
              NSArray *pods = [documentToParse nodesForXPath:@"/queryresult/pod" error:&error];
              
              if (!error) {
                  NSMutableArray *resultPods = [NSMutableArray array];
                  
                  for (DDXMLElement *pod in pods) {
                      // Populate data models
                      ELWolframLocationDataModel *dataModel = [[ELWolframLocationDataModel alloc] init];
                      dataModel.title = [[pod attributeForName:@"title"] stringValue];
                      
                      if ([[[pod attributeForName:@"id"] stringValue] isEqualToString:@"Input"]) {
                          dataModel.isInputInterpretation = YES;
                      }
                      
                      NSArray *podChildren = [pod children];
                      if ([podChildren count]) {
                          for (DDXMLNode *childNode in podChildren) {
                              NSError *subpodError = nil;
                              NSArray *childInformationArray = [childNode nodesForXPath:@"./img/@src" error:&subpodError];
                              
                              [childInformationArray count] ? [dataModel setImageUrlString:[(DDXMLNode *)[childInformationArray objectAtIndex:0] stringValue]] : nil;
                          }
                      }
                      [resultPods addObject:dataModel];
                  }
                  
                  if (block) {
                      block ([NSArray arrayWithArray:resultPods]);
                  }
              } else {
                  [[NSNotificationCenter defaultCenter] postNotificationName:kWolframRequestFailedNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error, @"Error", nil]];
                  
                  if (block) {
                      block (nil);
                  }
              }              
    } 
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [[NSNotificationCenter defaultCenter] postNotificationName:kWolframRequestFailedNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error, @"Error", nil]];
            
              if (block) {
                  block (nil);
              }
          }];
}

@end
