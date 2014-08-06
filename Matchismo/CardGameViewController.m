//
//  CardGameViewController.m
//  Matchismo
//
//  Created by David Chour on 7/23/14.
//  Copyright (c) 2014 DavidChour. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game; //the game
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; //the cards
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dialog; //Display card match or not
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount: [self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    [self changeMode:self.modeSwitch]; //set game mode
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init]; //create playingCard deck
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender]; //which card was clicked
    [self.game chooseCardAtIndex:chosenButtonIndex]; //what happens to the card
    self.modeSwitch.enabled = NO; //disable mode switch
    [self updateUI]; //update card display
}
- (IBAction)newGameButton:(UIButton *)sender {
    self.scoreLabel.text = @"Score: 0"; //reset score
    _game = nil; //nullify the old game
    [self game]; //create new game
    self.modeSwitch.enabled = YES; //renable mode switch
    [self updateUI]; //clear dialog and cards
    
}
- (IBAction)changeMode:(UISegmentedControl *)sender {
    _game.cardsToMatch = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
    //takes integer value of the segment selected
}



-   (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card * card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        //sets score and flips cards
    }
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastChosenCards count]){
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards){
                [cardContents addObject:card.contents]; //array holding card info
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        //set dialog displayed
        if (self.game.lastScore > 0){ //match if positive
            description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
        } else if(self.game.lastScore < 0){
            description = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", description, -self.game.lastScore];
        }
        self.dialog.text = description;
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents: @""; //title of card displayed according to whether card is chosen
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"]; //same with back of card
}

@end
