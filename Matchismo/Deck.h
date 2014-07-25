//
//  Deck.h
//  Matchismo
//
//  Created by David Chour on 7/23/14.
//  Copyright (c) 2014 DavidChour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
