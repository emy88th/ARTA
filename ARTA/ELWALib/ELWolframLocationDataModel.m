//
//  ELWolframLocationDataModel.m
//  ARTA
//
//  Created by Lupu Emanuel on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ELWolframLocationDataModel.h"

@implementation ELWolframLocationDataModel

@synthesize title, plaintext, imageUrlString, imageWidth, imageHeight, isInputInterpretation;

- (NSString *)description {
    return [NSString stringWithFormat:@"--- Title:%@, Plaintext:%@, ImageURL:%@, isInputInterpretation:%@ ---", title, plaintext, imageUrlString, isInputInterpretation ? @"YES" : @"NO"];
}

@end
