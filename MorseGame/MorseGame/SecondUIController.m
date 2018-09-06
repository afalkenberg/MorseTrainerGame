//
//  SecondUIController.m
//  MorseGame
//
//  Created by Andreas Falkenberg on 2/18/15.
//  Copyright (c) 2015 Andreas Falkenberg. All rights reserved.
//
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

#import "SecondUIController.h"
#import "LearningAlgorithm.h"
#import "MorseSelectorViewController.h"


static int    speed;
static float  speedSliderStatic;

static float  tone;
static float  toneSliderStatic;

static bool   alphabet;
static bool   numbers;
static bool   symbols;
static int    anzahl;
static bool   firstTime = true;


@interface SecondUIController ()


- (IBAction)speedValue:(id)sender;

- (IBAction)toneValue:(id)sender;

- (IBAction)alphabetValue:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *alphabetSwitch;


- (IBAction)numbersValue:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *numbersSwitch;


- (IBAction)symbolsValue:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *symbolsSwitch;


@property (weak, nonatomic) IBOutlet UILabel   *totalSymbols;
@property (weak, nonatomic) IBOutlet UIStepper *totalSymbolsStepper;


@property (weak, nonatomic) IBOutlet UILabel  *speedLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;


@property (weak, nonatomic) IBOutlet UILabel  *toneLabel;
@property (weak, nonatomic) IBOutlet UISlider *toneSlider;



@end



@implementation SecondUIController

{
    
  
    
    LearningAlgorithm* lalgo;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // NSLog(@"in viewDidLoad For Settings");
    
    // NSLog(@"current Anzahl is %d",anzahl);
    
    if(firstTime == true)
    {
        firstTime = false;
    
        anzahl   = 50;  // how can I keep the old one ?
        speed    = 3000;
        tone     = 500.0;
        alphabet = [_alphabetSwitch isOn];
        numbers  = [_numbersSwitch isOn];
        symbols  = [_symbolsSwitch isOn];
        
        speedSliderStatic  = [_speedSlider value];
        toneSliderStatic   = [_toneSlider value];

        
    }
    
    NSString *st = [NSString stringWithFormat:@"%i", anzahl];
    [_totalSymbols setText: st];
    [_totalSymbolsStepper setValue : anzahl];
    
    
    // calculate speed vs input number //
    
    [_speedSlider setValue:speedSliderStatic];

    
    float showwpm  = ((0.05 + [_speedSlider value]) * 30.0);
    NSString *sp = [NSString stringWithFormat:@"%i wpm", (int)showwpm];         //  speed];
    
    [_speedLabel setText : sp];
    
    
    [_toneSlider setValue : toneSliderStatic];
    tone = 800.0 * (0.1+ toneSliderStatic)  ;
    NSString *tp = [NSString stringWithFormat:@"%i Hz", (int)tone];
    [_toneLabel setText : tp];
    
    
    [_alphabetSwitch setOn: alphabet];
    [_numbersSwitch  setOn: numbers];
    [_symbolsSwitch  setOn: symbols];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
    // Get the new view controller using
    
        // NSLog(@"xxxspeed : %i", (int)speed);
        
        MorseSelectorViewController* mc;
        
        mc = [segue destinationViewController];
        
    
        [mc setAnzahl  : anzahl];
        [mc setSpeed   : speed];
        [mc setTone    : tone ];
        [mc setAlphabet: alphabet];
        [mc setNumbers : numbers];
        [mc setSymbols : symbols];
        
        
    // Pass the selected object to the new view controller.
}



- (IBAction)numberSymbols:(id)sender

{

    UIStepper* bla;
    bla = (UIStepper*)sender;
    
    anzahl = (int)[bla value];
    
    NSString *st = [NSString stringWithFormat:@"%i", anzahl];
    
    
    [_totalSymbols setText: st];

}


- (IBAction)speedValue:(id)sender
{

    
    UISlider * speedSliderL;
    speedSliderL = (UISlider*)sender;
    
    // calculate speed vs input number //

    speedSliderStatic = [speedSliderL value];
    
    float showwpm  = ((0.05 + speedSliderStatic) * 30.0);
    
    
    speed    = (int)((44100.0*60.0)/(showwpm  *  50.0))  ;      //  6000 / ((0.1+[bla value]) * 5) ; // wpm * 50 ticks total 44100*60/wpm*50
    
    NSString *sp = [NSString stringWithFormat:@"%i wpm", (int)showwpm];         //  speed];

    [_speedLabel setText : sp];
    

}

- (IBAction)toneValue:(id)sender
{
    UISlider * bla;
    bla = (UISlider*)sender;
    
    toneSliderStatic = [bla value];
    
    tone = 800.0 * (0.1+ toneSliderStatic)  ;
    
    NSString *tp = [NSString stringWithFormat:@"%i Hz", (int)tone];
    
    [_toneLabel setText : tp];
        

}

- (IBAction)alphabetValue:(id)sender
{

    alphabet =     [sender isOn];
    
    if(numbers == false && symbols == false)
    {
        alphabet = true;
        [_alphabetSwitch setOn: alphabet];
    }
    
    
}

- (IBAction)numbersValue:(id)sender
{
    numbers = [sender isOn];
    
    if(alphabet == false && symbols == false)
    {
        numbers = true;
        [_numbersSwitch setOn: numbers];
    }
    
    
    
}

- (IBAction)symbolsValue:(id)sender
{
    symbols = [sender isOn];
    
    if(alphabet == false && numbers == false)
    {
        symbols = true;
        [_symbolsSwitch setOn: symbols];
    }
    
    
    
}


@end
