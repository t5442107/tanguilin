//
//  MarkupParser.m
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "MarkupParser.h"

@implementation MarkupParser

@synthesize font, color, strokeColor, strokeWidth;
@synthesize images;

-(id)init
{
    self = [super init];
    if (self) {
        self.font = @"Arial";
        self.color = [UIColor blackColor];
        self.strokeColor = [UIColor whiteColor];
        self.strokeWidth = 0.0;
        self.images = [NSMutableArray array];
    }
    return self;
}

-(NSAttributedString*)attrStringFromMarkup:(NSString*)markup
{
    NSMutableAttributedString* aString =
    [[NSMutableAttributedString alloc] initWithString:@""]; //1
    
    NSRegularExpression* regex = [[NSRegularExpression alloc]
                                  initWithPattern:@"(.*?)(<[^>]+>|\\Z)"
                                  options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                  error:nil]; //2
    NSArray* chunks = [regex matchesInString:markup options:0
                                       range:NSMakeRange(0, [markup length])];
    [regex release];
    
    for (NSTextCheckingResult* b in chunks) {
        NSArray* parts = [[markup substringWithRange:b.range]
                          componentsSeparatedByString:@"<"]; //1
        
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font,
                                                 24.0f, NULL);
        
        //apply the current text style //2
        NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               (id)self.color.CGColor, kCTForegroundColorAttributeName,
                               (id)fontRef, kCTFontAttributeName,
                               (id)self.strokeColor.CGColor, (NSString *) kCTStrokeColorAttributeName,
                               (id)[NSNumber numberWithFloat: self.strokeWidth], (NSString *)kCTStrokeWidthAttributeName,
                               nil];
        [aString appendAttributedString:[[[NSAttributedString alloc] initWithString:[parts objectAtIndex:0] attributes:attrs] autorelease]];
        
        CFRelease(fontRef);
        
        //handle new formatting tag //3
        if ([parts count]>1) {
            NSString* tag = (NSString*)[parts objectAtIndex:1];
            if ([tag hasPrefix:@"font"]) {
                //stroke color
                NSRegularExpression* scolorRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=strokeColor=\")\\w+" options:0 error:NULL] autorelease];
                [scolorRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                    if ([[tag substringWithRange:match.range] isEqualToString:@"none"]) {
                        self.strokeWidth = 0.0;
                    } else {
                        self.strokeWidth = -3.0;
                        SEL colorSel = NSSelectorFromString([NSString stringWithFormat: @"%@Color", [tag substringWithRange:match.range]]);
                        self.strokeColor = [UIColor performSelector:colorSel];
                    }
                }];
                
                //color
                NSRegularExpression* colorRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=color=\")\\w+" options:0 error:NULL] autorelease];
                [colorRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                    SEL colorSel = NSSelectorFromString([NSString stringWithFormat: @"%@Color", [tag substringWithRange:match.range]]);
                    self.color = [UIColor performSelector:colorSel];
                }];
                
                //face
                NSRegularExpression* faceRegex = [[[NSRegularExpression alloc] initWithPattern:@"(?<=face=\")[^\"]+" options:0 error:NULL] autorelease];
                [faceRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
                    self.font = [tag substringWithRange:match.range];
                }];
            } //end of font parsing
        }
    }
    
    return (NSAttributedString*)aString;
    
}

-(void)dealloc
{
    self.font = nil;
    self.color = nil;
    self.strokeColor = nil;
    self.images = nil;
    
    [super dealloc];
}

@end
