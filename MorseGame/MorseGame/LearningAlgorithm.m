//
//  main.m
//  Trial 1
//
//  Created by Andreas Falkenberg on 1/27/15.
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

#import <Foundation/Foundation.h>
#import "LearningAlgorithm.h"


// implementation section //


@implementation LearningAlgorithm

{
    LetterCollection *letters;
    LetterCollection *numbers;
    LetterCollection *signs;
    
    
    LetterCollection* fourSelection;
    Letter*           correctLetter;
    
    AudioClass *audioApplication;
    
   // NSString* letterCodeInit[];
   // NSString* letterInit[];
    
    NSFileHandle *input;
    NSData       *inputData;
    NSString     *inputString;
    
    
    int anzahl;
    int totalCount;
    int totalError;
    
}


-(AudioClass *) getAudioApplication
{
    return audioApplication;
}



-(void) initSound
{
    
    // NSLog(@" in INIT SOUND ???? ? ??? ?? ?");
    
    audioApplication = [AudioClass alloc];
    audioApplication = [audioApplication init];
    
    // [audioApplication setCode: @"....--" ];
    [audioApplication setSpeed: 3000];
    [audioApplication setFrequency: 650.0];
    [audioApplication launching: 9];
    
}


-(void) setAnzahl :(int) x
{
    anzahl = x;
}




-(void) setSpeed:(int)x
{
    
   // NSLog(@" in Learning Algorithm %i", x);
    [audioApplication setSpeed: x];
    
}

-(void) setTone:(float)x
{
  //  NSLog(@" in Learning Algorithm tone %f", x);
    [audioApplication setFrequency:x];
}



-(void) initDataBaseWithAlphabet : (bool)localAlphabet withNumbers : (bool)localNumbers withSymbols : (bool)localSymbols
{
    
    
    totalCount = 0;
    totalError = 0;
    
   // NSLog(@" wann wird das hier aufgerufen ? ");
   // if(localNumbers)
   // {
   //     NSLog(@"localNumbers");
   // }
    
   // if(localSymbols)
   // {
   //     NSLog(@"localSymbols");
   // }
    
   // if(localAlphabet)
   // {
   //     NSLog(@"localAlphabet");
   // }
    
    
    
    letters = [LetterCollection alloc];
    
    letters = [letters init];
    
    
    [letters initial];
    
    NSArray *letterInit = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",
                              @"F",@"G",@"H",@"I",@"J",
                              @"K",@"L",@"M",@"N",@"O",
                              @"P",@"Q",@"R",@"S",@"T",
                              @"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    NSArray *letterCodeInit = [NSArray arrayWithObjects:
                  @" .-",
                  @" -...",
                  @" -.-.",
                  @" -..",
                  @" .",
                  @" ..-.",
                  @" --.",
                  @" ....",
                  @" ..",
                  @" .---",
                  @" -.-",
                  @" .-..",
                  @" --",
                  @" -.",
                  @" ---",
                  @" .--.",
                  @" --.-",@" .-.",
                  @" ...",@" -",
                  @" ..-",@" ...-",
                  @" .--", @" -..-",
                  @" -.--",@" --..",nil];
    
    
    if(localAlphabet)
    {
    	for(int i=0; i < [letterCodeInit count]; i++)
    	{
        	Letter *temp;
        	temp = [[Letter alloc] init];
        
        
        
        	// setLetter: (char) c code: (char*) s prob: (float) p inc:(float) i dec: (float) d;
        
        	[temp setLetter: letterInit[i] code: [letterCodeInit objectAtIndex: i]
            	  prob     : 2.0   inc : 1.0   dec: 0.5];
        
        	[letters addLetter: temp];
        }
        
    }
    
    
    if(localNumbers)
    {
    	numbers = [[LetterCollection alloc] init];
    
    	NSArray *numberInit = [NSArray arrayWithObjects:
                           @"1",@"2",@"3",@"4",@"5",
                           @"6",@"7",@"8",@"9",@"0", nil];
    
    	NSArray *numberCodeInit = [NSArray arrayWithObjects:
                               @" .----",@" ..---",@" ...--",@" ....-",@" .....",
                               @" -....",@" --...",@" ---..",@" ----.",@" -----", nil];
    
    	for(int i=0; i < [numberCodeInit count]; i++)
    	{
        	Letter *temp;
        	temp = [[Letter alloc] init];
        
        
        
        	// setLetter: (char) c code: (char*) s prob: (float) p inc:(float) i dec: (float) d;
        
        	[temp setLetter: numberInit[i] code: [numberCodeInit objectAtIndex: i]
            	  prob     : 2.0   inc : 1.0   dec: 0.5];
        
        	[letters addLetter: temp];
        
        }
    }
    
    
    
    if(localSymbols)
    {
    	signs = [[LetterCollection alloc] init];
    
    	//NSArray *signInit = [NSArray arrayWithObjects:    @".",@",",@":",@"?",@"'",
    	//                                                  @"-",@"/",@"(",@")",@"/",
    	//                                                  @"=",@"sn",@"err",
    	//                                                  @"+",@"as",
    	//                                                  @"sk",@"ka",@"at",
    	//                                                  nil];
    
    	NSArray *signInit = [NSArray arrayWithObjects:    @".",@",",@":",@"?",@"'",
                                                      @"-",@"/",@"(",@")",@"/",
                                                      @"=",@"sn",@"err",
                                                      @"+",@"as",
                                                      @"sk",@"ka",@"at", nil];
    
    
    
    
    	NSArray *signCodeInit = [NSArray arrayWithObjects:
                                 @" .-.-.-",@" --..--",@" ---...",@" ..--..",@" .----.",
                                 @" -....-",@" -..-.",@" -.--.",@" -.--.-",@" .-..-.",
                                 @" -...-", @" ...-.",@" ........",
                                 @" .-.-.", @" .-...",
                                 @" ...-.-",@" -.-.-",@" .--.-.", nil
                                 ];
    
    	for(int i=0; i < [signCodeInit count]; i++)
    	{
        	Letter *temp;
        	temp = [[Letter alloc] init];
        
        
        
        	// setLetter: (char) c code: (char*) s prob: (float) p inc:(float) i dec: (float) d;
        
        	[temp setLetter: signInit[i] code: [signCodeInit objectAtIndex: i]
            	  prob     : 2.0   inc : 1.0   dec: 0.5];
        
        	[letters addLetter: temp];
        }
        
    }

    
    
}



/** The following functions are called by the GUI */


-(void) startOnPhone
{
    
   // NSLog(@"inside startOnPhone Letters 1");
    
    
    fourSelection = [self selectFourLetters];
    

    NSString* s;
    NSString* c;
    
    correctLetter = [fourSelection selectRandomLetter];
    
    s = [correctLetter getLetter];
    c = [correctLetter getCode];
    
    
    [audioApplication setCode: c];
    [audioApplication createSound];

  //  NSLog(@"inside startOnPhone Letters 2");
    
    [audioApplication start];
    
  //  NSLog(@"inside startOnPhone Letters 3");

    
    bool bla;
    bla = false;
    int i;
    i = 0;
    
    while ((i < 2000000) && (bla == false))
    // for(int i = 0; i < 1500; i++)
    
    {
        if( bla == false)
        {
        	bla = [audioApplication stop: true];
        }
    
    
    // NSLog(@"inside startOnPhone Letters 4");

    	if(bla == true)
    	{
        	NSLog(@"true");
    	}
    	else
    	{
        	// NSLog(@"false");
    	}
        
        i++;
    }
    // [audioApplication terminate: 9];
    
}


-(LetterCollection*)getSortedLetters
{
    // LetterCollection* sorted;
    // NSLog(@"inside getSorted Letters");
    
    [letters sortByErrors];
    
    // NSLog(@"inside getSorted Letters2");
    
    return letters;
    
    
}





-(LetterCollection*) getFourLetters
{
    return fourSelection;
}


-(Letter*) getCorrectLetter
{
    return correctLetter;
}



/* I think this is only for testing

-(void)run
{
    
    input = [NSFileHandle fileHandleWithStandardInput];
    
    for(int i=0; i<5; i++)
    {
       [self runOnce];
    }
    
    [audioApplication terminate: 9];
    
    
    // NSLog(@"Sorted Result ");
    
    [[letters sortByErrors] print];
    
    
}

*/



// select multiple random letters
// mark one as the correct one

-(LetterCollection*) selectFourLetters
{
   
    LetterCollection *selectedLetters;
    selectedLetters = [LetterCollection alloc];
    selectedLetters = [selectedLetters init];
    [selectedLetters initial];
    
    
    for(int i =0; i < 4; i++)
    {
        
      
        
    
    	Letter*  x;
        x = [[Letter alloc] init];
        
        x = [letters selectRandomLetter];
        
        
        while([selectedLetters letterExists : x])
        {
        
         //   NSLog(@"what 2 ");
            
            x = [letters selectRandomLetter];
            
        }
        
        
        [selectedLetters addLetter : x];
        
        
    }
  
    
   // [selectedLetters print];
    
    fourSelection = selectedLetters;
    
    
    return selectedLetters;
    
}



-(bool)isCorrectLetter : (Letter*) let
{
    if([let getLetter] == [correctLetter getLetter])
        
        {
            // NSLog(@"Result good ");
            //[letters onSelectDecrement];
            [let dec];
            
            return true;
        }
        else
        {
            // NSLog(@"Result bad ");
            
            
            for(int i=0; i < 4; i++)
            {
                
                // [[fourSelection letterAtIndex : i] inc];
                // [[fourSelection letterAtIndex : i] addError];
            }
            
            [correctLetter inc];
            [correctLetter addError];
            
            return false;
            
        }

}







-(void)runOnce
{
    
    
    LetterCollection* four;
    four = [self selectFourLetters];
    
    [four print];
    
    
        Letter*  x;
        
        NSString* s;
        NSString* c;
    
    
        x = [four selectRandomLetter];
        correctLetter = x;
    
        s = [x getLetter];
        c = [x getCode];
        
    
        [audioApplication setCode: c];
        [audioApplication createSound];

        [audioApplication start];
        
        
        bool r = [audioApplication stop: true];
    
        NSLog(@" ****************Question:   %i ", r);
    
    
        [audioApplication terminate: 9];

        inputData = [input availableData];
        
        inputString = [[NSString alloc] initWithData: inputData encoding:NSUTF8StringEncoding];
        
    
        /// if([inputString hasPrefix: s] == 1)
    
        int answer = 0;
    
        if([inputString hasPrefix: @"0"] == 1)
        {
            answer = 0;
         }
        else
        if([inputString hasPrefix: @"1"] == 1)
        {
            answer = 1;
        }
        else
        if([inputString hasPrefix: @"2"] == 1)
        {
            answer = 2;
        }
    
    else
        if([inputString hasPrefix: @"3"] == 1)
        {
            answer = 3;
        }
    

    bool ant = [self isCorrectLetter : [fourSelection letterAtIndex : answer]];
    
    
    
    if(ant==true)
    {
       // NSLog(@"true");
    }
    else
    {
        totalError += 1;
    }
    
    totalCount += 1;
        
   // NSLog(@" RESULT sum : %f", [letters getProbabilitySum]);
   // NSLog(@" RESULT sum : %i", [letters getErrorSum]);
   // NSLog(@" _____________ " );
    
    
    
    
   // [letters print];
        
    
}




-(int) getTotalNumber
{
    return totalCount;
}

-(int) getTotalErrors
{
    return totalError;
}



-(void)showResult
{
    [letters print]; 
}


@end

