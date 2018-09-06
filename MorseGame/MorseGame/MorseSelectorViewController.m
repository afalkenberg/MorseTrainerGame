//
//  MorseSelectorViewController.m
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

#import "MorseSelectorViewController.h"
#import "UIResult.h"




@interface MorseSelectorViewController ()


@property (weak, nonatomic, readwrite) IBOutlet UIButton *ButtonA;


@property (weak, nonatomic, readwrite) IBOutlet UIButton *ButtonB;

@property (weak, nonatomic, readwrite) IBOutlet UIButton *ButtonC;

@property (weak, nonatomic, readwrite) IBOutlet UIButton *ButtonD;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UILabel *errorCounter;

@end


static bool  didNotLoad = true;
static int   localAnzahl;
static int   localSpeed;
static float localTone;
static bool  localAlphabet;
static bool  localNumbers;
static bool  localSymbols;

static NSMutableArray* xLabels;
static NSMutableArray* yValues;




@implementation MorseSelectorViewController



{
    // AFBarGraph *barGraph;
    
    LearningAlgorithm* lalgo;
    
    LetterCollection* four;
    
    
    int total;
    int errors;

}


-(void) setAnzahl:(int) x
{
    localAnzahl = x;
}




-(void) setSpeed: (int) x
{
    // NSLog(@" in MOrse selector view in setSpeed ");
    localSpeed = x;

}


-(void) setTone:(float) x
{
    
    //NSLog(@" set tone");
    
    localTone = x;
    
    //NSLog(@" %f", localTone);
}


-(void) setAlphabet:(bool) x
{
    localAlphabet = x;
}

-(void) setNumbers: (bool) x
{
    localNumbers =x;
    // NSLog(@"num");
}

-(void) setSymbols: (bool) x
{
    localSymbols = x;
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
  //  barGraph = [[AFBarGraph alloc] initWithFrame:CGRectMake(100.0, 370.0, 400.0, 500.0)];
    
  //  [barGraph initDefault];
    
    
  //  barGraph.backgroundColor = [UIColor clearColor]; // because it calls `super drawRect` I can now enjoy standard UIView features like this
  //  [self.view addSubview: barGraph];
    
    
    
    lalgo = [[LearningAlgorithm alloc] init];

    
    
    [lalgo initDataBaseWithAlphabet : localAlphabet withNumbers : localNumbers withSymbols : localSymbols];
    [lalgo initSound];
    
    [lalgo setAnzahl:localAnzahl];  // localAnzahl
    
    [lalgo setSpeed: localSpeed];
    
    [lalgo setTone: localTone];

    total = -1;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}


- (IBAction)startGame:(id)sender
{
    

    [self runOnce];
    
    [self updateGraph];


}



-(void)runOnce
{
    
    // NSLog(@" ________________ in run once ______1");
    
    [lalgo startOnPhone];
    
    //NSLog(@" ________________ in run once ______2");
    
    four = [lalgo getFourLetters];
    
    
    
    NSString* x0 = [[four letterAtIndex : 0] getLetter];
    
    
    [self.ButtonA setTitle: x0 forState:UIControlStateNormal ];
    
    
    NSString* x1 = [[four letterAtIndex : 1] getLetter];
    
    [self.ButtonB setTitle: x1 forState:UIControlStateNormal ];

 

    NSString* x2 = [[four letterAtIndex : 2] getLetter];


    [self.ButtonC setTitle: x2 forState:UIControlStateNormal ];


    NSString* x3 = [[four letterAtIndex : 3] getLetter];


    [self.ButtonD setTitle: x3 forState:UIControlStateNormal ];

    

    
}


-(void) updateGraph
{
    
    
    LetterCollection* sorted;
    sorted = [lalgo getSortedLetters];

    
    
    // [sorted print];
    
    
    xLabels = [[NSMutableArray alloc] init];
    
    
    
    
    yValues = [[NSMutableArray alloc] init];
    
    
    
    errors = [sorted getErrorSum];
   
    
    total = total + 1;
    
    for (int i=0; i<7; i++)
    {
    
        Letter* let;
        let = [sorted letterAtIndex:i];
        
    	NSString* x0 = [let getLetter];

        int nn;
        nn = [let getError];
        
        NSNumber* n0 = [[NSNumber alloc] initWithInt: nn];
    
       
        [xLabels addObject:x0];
        [yValues addObject:n0];
    
    }
    
  
    
    NSString *current = [NSString stringWithFormat:@"%i of %i", errors, total];

    
    [self.errorCounter setText:current];

    
    
    float rel;

  
    if(total > 0)
    {
       rel = (float)errors/((float)total);
    }
    else
    {
        rel = 0.0;
    }
    
    UIColor *tc = [UIColor greenColor];

  
    if(rel > 0.1)
    {
        tc = [UIColor yellowColor];
    }
    
    if(rel > 0.5)
    {
        tc = [UIColor redColor];
    }
    
    
    [self.errorCounter setTextColor:tc ];
    
    
    if(total >= localAnzahl)
    {
        
        
        [self performSegueWithIdentifier:@"transitToResult" sender:(id)self];

        
        
    }
    
   
    
}





- (IBAction)stopGame:(id)sender
{


}



- (IBAction)ButtonDTouchDown:(id)sender
{
    bool ant = [lalgo isCorrectLetter : [four letterAtIndex : 3]];
    
    [self updateGraph];
    [self runOnce];
    
}

- (IBAction)ButtonCTouchDown:(id)sender
{
    
    bool ant = [lalgo isCorrectLetter : [four letterAtIndex : 2]];

    [self updateGraph];
    [self runOnce];
    
}


- (IBAction)ButtonBTouchDown:(id)sender

{
    bool ant = [lalgo isCorrectLetter : [four letterAtIndex : 1]];
    
    [self updateGraph];
    [self runOnce];
    
}




- (IBAction)ButtonATouchUp:(id)sender
{
 //   bool ant = [lalgo isCorrectLetter : [four letterAtIndex : 0]];
    
//    [self updateGraph];
    
//    [self runOnce];
    

}

- (IBAction)ButtonATouchDown:(id)sender {


    bool ant = [lalgo isCorrectLetter : [four letterAtIndex : 0]];
 
    [self updateGraph];
    [self runOnce];
    
}



- (IBAction)ButtonBAction:(id)sender
{
    
    
    
}









- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using
    
    
    
    
    if ([segue.identifier isEqualToString:@"transitToResult"] ||
        [segue.identifier isEqualToString:@"swipeToResult"] )
    {
    
    
    	UIResult *mc;
    
    	mc =  [segue destinationViewController];
    
    //	NSLog(@" :: %@", xLabels);
    
    	[mc setXLabels : xLabels];
    
    //	NSLog(@" :: %@",yValues);
    	[mc setYValues : yValues];
        
        [mc setTotal:total];
        [mc setErrors:errors]; 
        
        
    }
    
    
    // Pass the selected object to the new view controller.
    
    
    
}




@end
