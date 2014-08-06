//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by David Chour on 7/24/14.
//  Copyright (c) 2014 DavidChour. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *cardArray;
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;

@end
@implementation CardMatchingGame

- (NSUInteger)cardsToMatch
{
    if (_cardsToMatch < 2){
        _cardsToMatch = 2;
    }
    //default number of cards to match is 2
    return _cardsToMatch;
}
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    //creation of deck
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
        } else{
            //array to hold cards for 3 card compare
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    [otherCards addObject:otherCard];
                }
            }
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            if ([otherCards count] == self.cardsToMatch - 1) {
                //match cards against each other
                int matchScore = [card match:otherCards];
                if (matchScore){
                    self.lastScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards){
                        otherCard.matched = YES;
                    }
                }else{
                    self.lastScore -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards){
                        otherCard.chosen = NO;
                    }
                }
                
            }
            card.chosen = YES;
            self.score += self.lastScore - COST_TO_CHOOSE;
        }
      
    }
   
}
@end
