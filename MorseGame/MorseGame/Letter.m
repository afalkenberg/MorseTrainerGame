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
#import "Letter.h"


// implementation section //


@implementation Letter


{
    NSString *content;
    NSString *code;
    int errorCount;

}


@synthesize probability;
@synthesize increment;
@synthesize decrement;




-(void) setLetter: (NSString*) c code: (NSString*) s prob: (float) p inc:(float) i dec: (float) d
{
    content      = c;
    probability = p;
    code        = s;
    increment   = i;
    decrement   = d;
    errorCount  = 0;
    
}


-(void) setLetter: (NSString*) s
{
    content = s;
}


-(NSString*) getLetter
{
    return content;
}


-(void) setCode: (NSString*) c
{
    code = c;
}

-(NSString*) getCode
{
    return code;
}


-(bool)compare: (Letter*) x
{
    if([self getLetter] == [x getLetter] )
    {
        return true;
    }
    else
    {
        return false;
    }
}



-(void) inc
{
    probability = probability + increment;
    
    
}

-(void) dec
{
    probability = probability - decrement;
    if(probability < 0.0)
    {
        probability = 0.0;
    }
}


-(void) delError
{
    errorCount = 0;
}

-(void) addError
{
    errorCount = errorCount + 1;
}

-(int)  getError
{
    return errorCount;
}


-(void) print
{
    NSLog(@"%@ ", content);
    NSLog(@"%f ", probability);
    NSLog(@"%@ ", code);
    NSLog(@"errors : %i ", errorCount);
}


-(float) giveResult
{
    return probability;
}


@end

