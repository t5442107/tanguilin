//
//  UIView+Additions.m
//  tanguilin
//
//  Created by yangyuji on 14-4-8.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIViewController *)viewVC{
    
    UIResponder *next =  [self nextResponder];
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController*)next;
        }
        
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}
@end
