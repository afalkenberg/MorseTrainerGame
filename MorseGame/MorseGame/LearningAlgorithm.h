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
#import "LetterCollection.h"
#import "AudioClass.h"

//interface section //


@interface LearningAlgorithm: NSObject


-(AudioClass *) getAudioApplication;



-(void) initSound;


-(void) initDataBaseWithAlphabet : (bool)localAlphabet withNumbers : (bool)localNumbers withSymbols : (bool)localSymbols;


-(LetterCollection*) getSortedLetters;
-(LetterCollection*) selectFourLetters;
-(LetterCollection*) getFourLetters;
-(Letter*) getCorrectLetter;


-(bool)isCorrectLetter : (Letter*) let;

-(void) runOnce;

// -(void) run;


-(void) startOnPhone;


-(void) showResult;


-(void) setAnzahl :(int) x; 

-(void) setSpeed : (int) x;

-(void) setTone:(float)x;

-(int) getTotalNumber;

-(int) getTotalErrors;


@end



