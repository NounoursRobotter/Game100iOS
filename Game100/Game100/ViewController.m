//
//  ViewController.m
//  premier
//
//  Created by Remy on 12/09/13.
//  Copyright (c) 2013 Test. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gameNumber = arc4random() % 10000;
    [self FillGameNumberField:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)FillGameNumberField :(id)sender {
    if (_VoidedPlacesValue.value!=0)
    {
        _GameNumberText.text=[NSString stringWithFormat:@"%02d%02d%04d",(int)_SizeSliderValue.value,(int)_VoidedPlacesValue.value,gameNumber];
    }
    else
    {
        _GameNumberText.text=[NSString stringWithFormat:@"%02d%02d0000",(int)_SizeSliderValue.value,(int)_VoidedPlacesValue.value];
    }
}

- (IBAction)PlayGame:(id)sender {
    NSLog(@"Play game sent");
}

- (IBAction)SizeSliderValueChange:(id)sender {
    _SizeLabel.text=[NSString stringWithFormat:@"%2d",(int)_SizeSliderValue.value];
    [self FillGameNumberField:nil];
}

-(IBAction)GameNumberTextReturn:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)GameNumberEnd:(id)sender {
    if (_GameNumberText.text.length<8){
        NSString *valueField=@"";
        for (int charIndex = 0; charIndex < _GameNumberText.text.length; charIndex++) {
            valueField=[NSString stringWithFormat:@"%@%c", valueField, [_GameNumberText.text characterAtIndex:charIndex]];
        }
        // fill with 0
        for (int charIndex = _GameNumberText.text.length; charIndex < 8; charIndex++) {
            valueField=[NSString stringWithFormat:@"%@0", valueField];
        }
        _GameNumberText.text=valueField;
    }
    // Set value of sliders
    int userValSize;
    int userValVoid;
    userValSize=[[_GameNumberText.text substringWithRange:NSMakeRange(0,2)] intValue];
    userValVoid=[[_GameNumberText.text substringWithRange:NSMakeRange(2,2)] intValue];
    if ((userValSize>_SizeSliderValue.maximumValue)||(userValSize<_SizeSliderValue.minimumValue))
    {
        _GameNumberText.text=[NSString stringWithFormat:@"%02d%@", (int)_SizeSliderValue.value,[_GameNumberText.text substringFromIndex:2]];
        userValSize=(int)_SizeSliderValue.value;
    }
    else
    {
        if ((int)_SizeSliderValue.value!=userValSize) {
            _SizeSliderValue.value=userValSize;
            _SizeLabel.text=[NSString stringWithFormat:@"%2d",(int)_SizeSliderValue.value];
        }
    }
    if ((userValVoid>_VoidedPlacesValue.maximumValue)||(userValVoid<_VoidedPlacesValue.minimumValue))
    {
        _GameNumberText.text=[NSString stringWithFormat:@"%02d%02d%@", userValSize, (int)_VoidedPlacesValue.value,[_GameNumberText.text substringFromIndex:4]];
        userValVoid=(int)_VoidedPlacesValue.value;
    }
    else
    {
        if ((int)_VoidedPlacesValue.value!=userValVoid) {
            _VoidedPlacesValue.value=userValVoid;
            _VoidedPlacesLabel.text=[NSString stringWithFormat:@"%2d",(int)_VoidedPlacesValue.value];
        }
    }
    // Verify if end of game number needs to be set to 0
    if (userValVoid!=0)
    {
        // Set game number if non-nul
        gameNumber=[[_GameNumberText.text substringFromIndex:4] intValue];
    }
    else
    {
        // if nbVoid=0 remettre à 0
        _GameNumberText.text=[NSString stringWithFormat:@"%02d%02d0000",userValSize,userValVoid];
    }
}

- (IBAction)VoidedPlacesSliderValueChange:(id)sender {
    _VoidedPlacesLabel.text=[NSString stringWithFormat:@"%2d",(int)_VoidedPlacesValue.value];
    [self FillGameNumberField:nil];
}

- (IBAction)GameNumberTextAction:(id)sender {
    //_GameNumberText.text.
    NSString *valueField=@"";
    unichar valeurElem;
    UITextRange *pos=_GameNumberText.selectedTextRange;
    for (int charIndex = 0; charIndex < _GameNumberText.text.length; charIndex++) {
        valeurElem=[_GameNumberText.text characterAtIndex:charIndex];
        if (isdigit(valeurElem)){
            valueField=[NSString stringWithFormat:@"%@%c", valueField, valeurElem];
        }
    }
    int strLen=(valueField.length>8)?8:valueField.length;
    _GameNumberText.text=@"";
    for (int charIndex = 0; charIndex < strLen; charIndex++) {
            _GameNumberText.text=[NSString stringWithFormat:@"%@%c", _GameNumberText.text, [valueField characterAtIndex:charIndex]];
    }
    [_GameNumberText setSelectedTextRange:pos];
}
@end
