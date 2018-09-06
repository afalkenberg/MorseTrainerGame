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

#import <AudioToolbox/AudioToolbox.h>



struct CallBackSupportStructure
{
    Float32 * myBuffer;
    int    bufSize;
    int    speed;
    double frequency;
    int    myPointer;
    int    runFlag;
};


@interface AudioClass: NSObject

{
    AudioUnit outputUnit;
    struct CallBackSupportStructure callBackSupport;

    NSString* code;
    
}


-(void)setCode:(NSString*) c;
-(void)setSpeed:(int) x;
-(void)setFrequency:(double) f;
-(void)createSound;
-(void)launching:(int) n;
-(void)start;
-(bool)stop:(bool) cbf;
-(void)terminate:(int) x;


@end







