//
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


//interface section //


@interface LetterCollection: NSObject


-(void)initial;

-(void)addLetter:(Letter*) let;

-(bool)letterExists:(Letter*) let;

-(Letter *) letterAtIndex:(int) i; 

-(Letter*)selectLetter:(float) r;

-(Letter*)selectRandomLetter;

-(void)onSelectDecrement;

-(void)onSelectIncrement;

-(void)onSelectAddError;

-(void)incrementAll;

-(void)decrementAll;

-(float)getProbabilitySum;

-(int)getErrorSum;



-(void) print;

-(LetterCollection*) sortByErrors;


@end



