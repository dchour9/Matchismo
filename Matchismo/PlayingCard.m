//
//  PlayingCard.m
//  Matchismo
//
//  Created by David Chour on 7/23/14.
//  Copyright (c) 2014 DavidChour. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    //match rules for comparison to another card
    int score = 0;
    int numOtherCards = [otherCards count];
    if (numOtherCards){
        for (Card *card in otherCards){
            if ([card isKindOfClass:[PlayingCard class]]){
                PlayingCard *otherCard = (PlayingCard *)card;
                if (otherCard.rank == self.rank) {
                    score += 4;
                } else if ([otherCard.suit isEqualToString:self.suit]){
                    score += 1;
                }
            }
        }
    
    }
    //3 card match rules to create a higher score
    if (numOtherCards > 1){
        score += [[otherCards firstObject] match: [otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
    }
    return score;
}
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♠️", @"♥️", @"♦️", @"♣️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit =suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] -1;}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
