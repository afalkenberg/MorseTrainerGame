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



//interface section //


@interface Letter: NSObject

@property float probability;
@property float increment;
@property float decrement;


-(void) setLetter: (NSString*) c code: (NSString*) s prob: (float) p inc:(float) i dec: (float) d;


-(void) setLetter: (NSString*) s;
-(NSString*) getLetter;

-(void) setCode:   (NSString*) c;
-(NSString*) getCode;

-(bool) compare: (Letter*) x ;
-(void) inc;
-(void) dec;

-(void) delError;
-(void) addError;
-(int)  getError;

-(void) print;
-(float) giveResult;

@end



