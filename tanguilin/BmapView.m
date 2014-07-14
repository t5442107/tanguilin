//
//  BmapView.m
//  tanguilin
//
//  Created by yangyuji on 14-2-23.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "BmapView.h"

@implementation BmapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    NSLog(@"mapView dealloc");
    [super dealloc]; 
}

@end
