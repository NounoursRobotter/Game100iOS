//
//  ViewController.h
//  premier
//
//  Created by Remy on 12/09/13.
//  Copyright (c) 2013 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int gameNumber;
}


- (IBAction)PlayGame:(id)sender;
- (IBAction)SizeSliderValueChange:(id)sender;
- (IBAction)VoidedPlacesSliderValueChange:(id)sender;
- (IBAction)GameNumberTextAction:(id)sender;
- (IBAction)GameNumberTextReturn :(id)sender;
- (IBAction)GameNumberEnd:(id)sender;

- (void)FillGameNumberField :(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *SizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *VoidedPlacesLabel;
@property (weak, nonatomic) IBOutlet UITextField *GameNumberText;
@property (weak, nonatomic) IBOutlet UISlider *SizeSliderValue;
@property (weak, nonatomic) IBOutlet UISlider *VoidedPlacesValue;


@end
