//
//  DDMenuController.h
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 toaast. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

typedef enum {
    DDMenuPanDirectionLeft = 0,
    DDMenuPanDirectionRight,
} DDMenuPanDirection;

typedef enum {
    DDMenuPanCompletionLeft = 0,
    DDMenuPanCompletionRight,
    DDMenuPanCompletionRoot,
} DDMenuPanCompletion;

@protocol DDMenuControllerDelegate;
@interface DDMenuController : UIViewController <UIGestureRecognizerDelegate>{
    
    id _tap;
    id _pan;
    
    CGFloat _panOriginX;  //平移原点
    CGPoint _panVelocity; //平移速度
    DDMenuPanDirection _panDirection;  //平移方向

    struct {
        unsigned int respondsToWillShowViewController:1; //响应将显示视图控制器
        unsigned int showingLeftView:1;
        unsigned int showingRightView:1;
        unsigned int canShowRight:1;
        unsigned int canShowLeft:1;
    } _menuFlags;
    
}

- (id)initWithRootViewController:(UIViewController*)controller;

@property(nonatomic,assign) id <DDMenuControllerDelegate> delegate;

@property(nonatomic,strong) UIViewController *leftViewController;
@property(nonatomic,strong) UIViewController *rightViewController;
@property(nonatomic,strong) UIViewController *rootViewController;

@property(nonatomic,readonly) UITapGestureRecognizer *tap;
@property(nonatomic,readonly) UIPanGestureRecognizer *pan;

@property(nonatomic,assign) Class barButtonItemClass;

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated; // used to push a new controller on the stack 用于推动栈上一个新的控制器
- (void)showRootController:(BOOL)animated; // reset to "home" view controller复位到“家”视图控制器
- (void)showRightController:(BOOL)animated;  // show right
- (void)showLeftController:(BOOL)animated;  // show left


- (void)setEnableGesture:(BOOL)isEnable;
@end

@protocol DDMenuControllerDelegate 
- (void)menuController:(DDMenuController*)controller willShowViewController:(UIViewController*)controller;
@end