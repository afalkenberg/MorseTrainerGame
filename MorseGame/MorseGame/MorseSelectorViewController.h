//
//  MorseSelectorViewController.h
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

#import <UIKit/UIKit.h>
#import "AFBarGraph.h"
#import "LearningAlgorithm.h"


@interface MorseSelectorViewController : UIViewController

// -(MorseSelectorViewController*) init;

-(void) setAnzahl:(int) x;
-(void) setSpeed: (int) x;
-(void) setTone:(float) x;
-(void) setAlphabet:(bool) x;
-(void) setNumbers: (bool) x;
-(void) setSymbols: (bool) x;

@end
