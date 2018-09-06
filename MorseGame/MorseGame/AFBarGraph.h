//
//  AFBarGraph.h
//  Graphic1
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


IB_DESIGNABLE


@interface AFBarGraph : UIView


{
    
    NSMutableArray *xLabels;
    
    // values on y-achsis
    NSMutableArray *yValues;
    


}

//@property (strong, nonatomic) IBOutlet UIDatePicker* datePicker;

- (id)initWithFrame:(CGRect)theFrame;
- (id)initWithCoder:(NSCoder*)coder; 


  //   @property (nonatomic) IBInspectable NSInteger lineWidth;
@property (nonatomic) IBInspectable UIColor *fillColor;
    
@property (nonatomic) IBInspectable UIColor *textColor;

@property (nonatomic) IBInspectable UIColor *lineColor;


@property (nonatomic) IBInspectable NSInteger fSize;

@property (nonatomic) IBInspectable NSInteger lineWidth;

@property (nonatomic) IBInspectable CGFloat xoffset;

@property (nonatomic) IBInspectable CGFloat yoffset;

// the absolute width in x direction
@property (nonatomic) IBInspectable CGFloat xWidthMult;
@property (nonatomic) CGFloat xWidth;


// @property float xWidth;
// the hight of the box in y dirction
@property (nonatomic) IBInspectable CGFloat yHightMult;
@property (nonatomic) CGFloat yHight;


// the maximum value in Y direction
// the idea is that this fills the room
@property (nonatomic) IBInspectable CGFloat maxYValue;

@property (nonatomic) IBInspectable CGFloat stepSize;

// @property (nonatomic) IBOutlet NSMutableArray *xLabels;
// @property (nonatomic) IBOutlet NSMutableArray *yValues;


// Define an outlet for the custom view.
//@property (nonatomic, weak) IBOutlet UIView *referencedView;


// An action that triggers showing the view.
- (IBAction)somethingChanged:(id)sender;



-(void)setXLabels: (NSMutableArray*) x;
-(void)setYValues: (NSMutableArray*) y; 


-(void)initDefault;


-(void) drawXAxis;
-(void) drawYAxis;
-(void) drawBars;



-(void) drawBar: (float) xpos  value : (float) ypos;
-(void) drawXText: (NSString*) txt at: (float) xpos;
-(void) drawYText: (NSString*) txt at: (float) ypos;
-(void) drawRect:(CGRect)rect;


@end
