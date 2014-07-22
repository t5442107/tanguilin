//
//  CommentView.h
//  tanguilin
//
//  Created by yangyuji on 14-3-1.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
 
typedef void(^GetCommentBlock)(NSString*,UIImage*);
@interface CommentView : UIView<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
   
    UIView *_commentView;
    UIButton *_sendButon;
    UIImage *_addImage;
    UIImageView *_addImageView;
    UIButton *_addImageButton;
}
@property (nonatomic,retain) UITextView      *commentTextView;
//@property (nonatomic,retain)  UIButton *sendButon;
@property (nonatomic,copy  ) GetCommentBlock getBlock;

//压缩图片

-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
