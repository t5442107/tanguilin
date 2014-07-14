//
//  RecipesView.m
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "RecipesView.h"
#import "MarkupParser.h"
@implementation RecipesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
   
}


/**
 *
 *
 *  @param rect
 *
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    CGMutablePathRef path = CGPathCreateMutable(); //1
    CGPathAddRect(path, NULL, self.bounds );
    
 
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    NSAttributedString* attString = [p attrStringFromMarkup: @"Hello <font color=\"red\">core text <font color=\"blue\">world!"];
    
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    
    CTFrameDraw(frame, context); //4
    
    
    
    
    CFRelease(frame); //5
    CFRelease(path);
    CFRelease(framesetter);
    
    
}
 */

@end
