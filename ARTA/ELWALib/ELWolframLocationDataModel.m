//
//  ELWolframLocationDataModel.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWolframLocationDataModel.h"

@implementation ELWolframLocationDataModel

@synthesize title, imageUrlString, isInputInterpretation;

- (NSString *)description {
    return [NSString stringWithFormat:@"--- Title:%@, ImageURL:%@, isInputInterpretation:%@ ---", title, imageUrlString, isInputInterpretation ? @"YES" : @"NO"];
}

@end
