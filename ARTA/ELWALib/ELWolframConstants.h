//
//  ELWolframConstants.h
//  ARTA
//
//  Created by Lupu Emanuel on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef ARTA_ELWolframConstants_h
#define ARTA_ELWolframConstants_h

#pragma mark - Base & ID
extern NSString *kWolframApiID;
extern NSString *kWolframApiBaseURL;

#pragma mark - URL parameters
extern NSString *kWolframGeneralQueryParam;
extern NSString *kWolframGeneralInputParam;
extern NSString *kWolframApiIDParam;
extern NSString *kWolframResultsFormatParam;

#pragma mark - Expected datatypes
extern NSString *kWolframImageDatatype;
extern NSString *kWolframPlaintextDatatype;

#pragma mark - Notifications
extern NSString *kWolframRequestInProgressNotification;
extern NSString *kWolframRequestFinishedNotification;
extern NSString *kWolframRequestFailedNotification;
#endif
