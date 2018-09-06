//
//  UIResult.m
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

#import "UIResult.h"
#import "AFBarGraph.h"

@interface UIResult ()


@property (nonatomic) IBOutlet AFBarGraph *barSec;


@end

@implementation UIResult


{
   // AFBarGraph *barGraph;

    IBOutlet AFBarGraph *barGraph;
    
    __weak IBOutlet UILabel *errorCounter;
    
    __weak IBOutlet UILabel *errorPercent;
}





- (void)viewDidLoad {
    [super viewDidLoad];

    [barGraph setXLabels:x];
    [barGraph setYValues:y];
    
    NSString *current = [NSString stringWithFormat:@"%i of %i", errors, total];

    float per;
    
    if(total > 0)
    {
    	per = (float)errors*100.0/(float)total;
    }
    else
    {
        per = 0.0;
    }
    
    NSString *pstr = [NSString stringWithFormat:@"%i %%",(int)per];
    
    [errorCounter setText:current];
    
    [errorPercent setText: pstr]; 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)setXLabels: (NSMutableArray*) a
{
    x = a;
   // NSLog(@" ... %@", x);
}


-(void)setYValues: (NSMutableArray*) b
{
    y = b;
   // NSLog(@" ::: %@",y);
}


-(void)setTotal: (int) t
{
    total = t;
}

-(void)setErrors: (int) e
{
    errors = e;
}






@end
