//
//  MarkupParser.h
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface MarkupParser : NSObject {
    
    NSString* font;
    UIColor* color;
    UIColor* strokeColor;
    float strokeWidth;
    
    NSMutableArray* images;
}

@property (retain, nonatomic) NSString* font;
@property (retain, nonatomic) UIColor* color;
@property (retain, nonatomic) UIColor* strokeColor;
@property (assign, readwrite) float strokeWidth;

@property (retain, nonatomic) NSMutableArray* images;

-(NSAttributedString*)attrStringFromMarkup:(NSString*)html;

@end