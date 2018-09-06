//
//  LetterCollection.m
//  Morse Program
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
#import "LetterCollection.h"


// implementation section //


@implementation LetterCollection

{
    NSMutableArray* letterArray;
    int lastSelected;
    
}


-(void) initial
{
    
    letterArray = [NSMutableArray alloc];
    letterArray = [letterArray init];
}

-(void) addLetter:(Letter*) let
{
    
    [letterArray addObject: let];
    
   // NSLog(@"in addLetter");
    
   // NSLog(@" anzahl %lu", [letterArray count]);
   // [let print];
    
}


-(bool)letterExists: (Letter*) let
{
    int i;
    for(i = 0; i < [letterArray count]; i++)
    {
        Letter* x = [letterArray objectAtIndex : i];
        
        if([x compare: let] == true)
        {
            return true;
        }
    }
    
    return false;
    
}



-(void) deleteLetter:(Letter*) let
{
    
    
}


-(Letter *) letterAtIndex:(int) i
{
    return [letterArray objectAtIndex : i];
}

-(Letter*) selectLetter:(float) r
{
    
    // go through all letters
    
    float sum;
    sum   = 0.0;
    lastSelected = 0;
    Letter* res;
    
    for(int i = 0; i < [letterArray count] ; i++)
    {
        float before;
        float after;
        
        
        before = sum;
        
        sum = sum + [[letterArray objectAtIndex : i] probability];

        
        after = sum;
	
        
        if((before <= r) && (after >= r))
        {
            
            
            res          = [letterArray objectAtIndex : i];
            lastSelected = i;
        }
        
    }
    
    // accumualate the probability
    // if r is >= than last probability and <= than this one then
    // select this letter and return
    
    
    return res;
}


-(Letter*) selectRandomLetter
{
    
    
    
    float one_over_max = (float)UINT32_MAX + 1.0;
    
  //  float ar  = rand();
    float ra = arc4random();
    
    float r = ra / one_over_max;

    
    // NSLog(@"in sort by errors ... %f", r );

    
    
    float maxNum;
    maxNum = 0.0;
    
    for(int i = 0; i < [letterArray count] ; i++)
    {
        maxNum = maxNum + [[letterArray objectAtIndex : i] probability];
    }
    
    float res;
    res = r  * maxNum;  // was *
    
    
    return [self selectLetter: res];
}





-(void)onSelectDecrement
{
    [[letterArray objectAtIndex : lastSelected] dec];
    
}

-(void)onSelectIncrement
{
    [[letterArray objectAtIndex : lastSelected] inc];
}



-(void)onSelectAddError
{
    [[letterArray objectAtIndex : lastSelected] addError];
}


-(void)incrementAll
{
    for(int i = 0; i < [letterArray count] ; i++)
    {
       [[letterArray objectAtIndex : i] inc];
    }
}

-(void)decrementAll
{
    for(int i = 0; i < [letterArray count] ; i++)
    {
        [[letterArray objectAtIndex : i] dec];
    }
}


-(float)getProbabilitySum
{
    
    float maxNum;
    
    maxNum = 0.0;
    
    for(int i = 0; i < [letterArray count] ; i++)
    {
        maxNum = maxNum + [[letterArray objectAtIndex : i] probability];
    }
    
    
    return maxNum;
    
}


-(int)getErrorSum
{
    int err;
    err = 0;
    
    for(int i=0; i<[letterArray count]; i++ )
    {
        err += [[letterArray objectAtIndex: i] getError];
    }
    
    return err;
    
}



//NSArray* someArray = [xpathParser search:@"//h3"];
// NSMutableArray* mutableArray = [someArray mutableCopy];


//- (NSComparisonResult)compare:(Person *)otherObject {
//    return [self.birthDate compare:otherObject.birthDate];
//}




-(LetterCollection*)sortByErrors
{
    

    // NSLog(@"in sort by errors %d",[letterArray count] );

    
    NSArray* sortedLetters;
    
    sortedLetters = [letterArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
    		{
        		int first  = [(Letter*)a getError];
        		int second = [(Letter*)b getError];
        		return first < second;
    		}];
    
    
    letterArray = [sortedLetters mutableCopy];
    
    return self;
    
}



-(void) print
{
    
    NSLog(@"in LetterCollection %lu",(unsigned long)[letterArray count] );
    
    for(int i = 0; i < [letterArray count] ; i++)
    {
        NSLog(@"Entry %i", i);
        [[letterArray objectAtIndex: i] print];
    }
    
    
    
}





@end

