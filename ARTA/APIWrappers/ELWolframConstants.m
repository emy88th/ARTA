//
//  ELWolframConstants.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWolframConstants.h"

#pragma mark - Base & ID
NSString *kWolframApiID = @"2QE28T-RWL8R637VW";
NSString *kWolframApiBaseURL = @"http://api.wolframalpha.com/v2/";

#pragma mark - URL parameters
NSString *kWolframGeneralQueryParam = @"query";
NSString *kWolframGeneralInputParam = @"input";
NSString *kWolframApiIDParam = @"appid";
NSString *kWolframResultsFormatParam = @"format";

#pragma mark - Expected datatypes
NSString *kWolframImageDatatype = @"image";
NSString *kWolframPlaintextDatatype = @"plaintext;";