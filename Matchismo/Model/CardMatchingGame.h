//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by David Chour on 7/24/14.
//  Copyright (c) 2014 DavidChour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount: (NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property(nonatomic, readonly) NSInteger score;
@end
