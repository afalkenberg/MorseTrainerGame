//
//  AFBarGraph.m
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

#import "AFBarGraph.h"

@implementation AFBarGraph


@synthesize xoffset;
@synthesize yoffset;
@synthesize xWidth;
@synthesize yHight;
@synthesize maxYValue;
@synthesize stepSize;




- (id)initWithFrame:(CGRect)theFrame {


    self = [super initWithFrame:theFrame];
    if (self) {
        [self initDefault];
    }
    return self;
}


- (id)initWithCoder:(NSCoder*)coder
{
    
    
    if ((self = [super initWithCoder:coder]))
    {
       [self initDefault];
    }
    
    
    return self;
}


-(void)initDefault
{
    // xoffset   = 30.0;
    
    // yoffset   = 10.0;
    // xWidth    = 210.0;
    // yHight    = 140.0;  // PHYSICAL SIZE
    // maxYValue = 45.1;   // maximum on y axis
    // stepSize  = 10.0;
    
    
    xLabels = [[NSMutableArray alloc] init];
    
    yValues = [[NSMutableArray alloc] init];
    
    NSNumber* n0 = [[NSNumber alloc] initWithFloat:30.0];
    NSNumber* n1 = [[NSNumber alloc] initWithFloat:20.0];
    NSNumber* n2 = [[NSNumber alloc] initWithFloat:10.0];
    
    NSString* l0 = @"x";
    NSString* l1 = @"y";
    NSString* l2 = @"z";
    
    [xLabels addObject:l0];
    [xLabels addObject:l1];
    [xLabels addObject:l2];
    [xLabels addObject:l1];
    [xLabels addObject:l1];
    [xLabels addObject:l0];
    [xLabels addObject:l2];
    [xLabels addObject:l2];
    [xLabels addObject:l2];
    
    
    
    [yValues addObject:n0];
    [yValues addObject:n1];
    [yValues addObject:n2];
    [yValues addObject:n2];
    [yValues addObject:n2];
    [yValues addObject:n0];
    [yValues addObject:n2];
    [yValues addObject:n2];
    [yValues addObject:n2];
    
    
    
    //_fillColor  = [UIColor redColor];
    //_textColor  = [UIColor blueColor];
    //_lineColor  = [UIColor blackColor];
    
}


-(void)setXLabels:(NSMutableArray *)x
{
    xLabels = x;
    
}


-(void)setYValues:(NSMutableArray *)y
{
    
    yValues= y;
    
}



-(void) drawXAxis
{
    int   n;
    float step;
    
    n =  (int)[yValues count];
    
    
    step = xWidth/n;
    
    
    // draw straight line
  
    [_lineColor set];
    
    
    UIBezierPath* xMain = [UIBezierPath bezierPath];
    [xMain moveToPoint:CGPointMake(xoffset, yHight + yoffset)]; // was yoffset
    [xMain addLineToPoint:CGPointMake(xoffset + xWidth, yHight + yoffset)];  // was yOffset
    [xMain stroke];
    
    // ticks
    
    for(int i = 0; i < n; i++)
    {
        
        [_lineColor set];
        
        xMain = [UIBezierPath bezierPath];
        [xMain moveToPoint:CGPointMake(xoffset+step * i + step/2.0 , (yHight + yoffset) + 3)];
        [xMain addLineToPoint:CGPointMake(xoffset+step * i +step/2.0, (yHight + yoffset) - 3)];   // was only yOffset
        [xMain stroke];
    
        
        NSString* txt;
        txt = [xLabels objectAtIndex : i];
        
        [self drawXText : txt at: xoffset+step * i + step/2.0 ];
        
    }
    
    
    
}


-(void) drawYAxis
{
    
    float numStep;
    
    float ystep;
    
    // y direction //
    ystep = stepSize * yHight / maxYValue;
    
    numStep = maxYValue / stepSize;
    
    
    [_lineColor set];
    
    
    UIBezierPath* yMain = [UIBezierPath bezierPath];
    
    
    yMain = [UIBezierPath bezierPath];
    
    
    [yMain moveToPoint:CGPointMake(xoffset, (yHight +yoffset))]; // was yoffset
                                   
    [yMain addLineToPoint:CGPointMake(xoffset, yoffset)];  // was yoffset + yHight
    
    [yMain stroke];
    

    // numbers from n here //
    for(int i = 0; i < numStep; i++)
    {
        
        [_lineColor set];
        
        yMain = [UIBezierPath bezierPath];
        [yMain moveToPoint:CGPointMake(xoffset -3 , yHight + yoffset - ystep * i   )];
        [yMain addLineToPoint:CGPointMake(xoffset + 3, yHight + yoffset - ystep * i )];
        [yMain stroke];
        
        
        
        NSString* txt;
        txt = [NSString stringWithFormat:@"%i", (int)(stepSize * i)];
        
        [self drawYText : txt at: yHight - ystep * i];
        
        
    }
    
    
    
}


-(void) drawBars
{
    
    int n;
    float step;
    
    n = (int)[yValues count];
    
    step = xWidth/n;
    
    
    
    for(int i = 0; i < n; i++)
    {
        float v = [[yValues objectAtIndex : i] floatValue];
        
        // now calculate relative to maxValue
        
        float pixv;
        pixv = yHight*v/maxYValue;
        
        
        [self drawBar : ((i + 0.5) * step) value : pixv];
        
        
    }
    
}




-(void) drawBar: (float) xpos  value : (float) ypos
{
    
    int   n;
    float barWidth;
    
    n =  (int)[xLabels count];
    
    barWidth = (xWidth/n)*0.6; // .9 leaves a little gap

    [_fillColor set];
    
    UIBezierPath* barMain = [UIBezierPath bezierPath];
    
    [barMain moveToPoint:CGPointMake(xoffset + xpos -0.5*barWidth, yoffset + yHight)];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yoffset + yHight)];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yHight + yoffset - ypos )];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos -0.5*barWidth , yHight + yoffset - ypos )];
    
    [barMain closePath];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Shadow for now we leave it here //
    CGContextSetShadow(context, CGSizeMake(8,8), 4);
    
    [barMain fill];
    
    [barMain stroke];
    
    
    
}




-(void) drawXText: (NSString*) txt at: (float) xpos
{
    
    
    UIFont *smallFont = [UIFont systemFontOfSize : _fSize];
    CGPoint textPoint = CGPointMake(xpos,yHight + yoffset + 2);
    
    [_textColor set];
    
    [txt drawAtPoint:textPoint withFont:smallFont];
    

}








-(void) drawYText: (NSString*) txt at: (float) ypos
{
    
    
    
    UIFont *smallFont = [UIFont systemFontOfSize: _fSize];  /// was 8
    CGPoint textPoint = CGPointMake(xoffset - _fSize - 2 , yoffset + ypos - (_fSize/2) );
    
    
    [_textColor set];
    
    [txt drawAtPoint:textPoint withFont:smallFont];         //  withFont:smallFont];
    

    
}



 
 
- (void)drawRect:(CGRect)rect

{
    
    
    // [self initDefault];
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();  // old
    CGRect  myFrame = self.bounds;       // new
    
    yHight  = self.bounds.size.height  * _yHightMult;
    xWidth  = self.bounds.size.width   * _xWidthMult;
    
    CGContextSetLineWidth(context, _lineWidth);   // new
   
    CGRectInset(myFrame, 5,5);  // new
    [_fillColor set];        //  ??
    
    UIRectFrame(myFrame);       // new

    
    [self drawBars];
    
    [self drawXAxis];
    [self drawYAxis];
    
//    CGContextRestoreGState(context);
    
    
}



-(void)somethingChanged:(id)sender
{
   // NSLog(@"Something Changed !! !!!!!!");
    
    
   // NSLog(@"in somethingChanged %f",123.2);
    
    NSNumber* n1 = [[NSNumber alloc] initWithFloat:10.0];
    
   // NSLog(@"in somethingChanged _  %@",n1);
    
    [yValues replaceObjectAtIndex:1 withObject:n1];
    
    [self setNeedsDisplay];
    
}



@end
