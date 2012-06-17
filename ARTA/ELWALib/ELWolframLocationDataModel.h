//
//  ELWolframLocationDataModel.h
//  ARTA
//
//  Created by Lupu Emanuel on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELWolframLocationDataModel : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *plaintext;
@property (nonatomic, retain) NSString *imageUrlString;
@property (nonatomic, assign) BOOL isInputInterpretation;

@end
