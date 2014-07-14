//
//  CommentView.m
//  tanguilin
//
//  Created by yangyuji on 14-3-1.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//  //  有问题需要解答的，让加q群 170627662 ,我会尽我全力来回答问题，谢谢支持

#import "CommentView.h"
#import "ShopInfoViewController.h"
@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initWith];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillShowNotification object:Nil];
    }
    return self;
}

- (void)_initWith{
    _commentView = [[UIView alloc]init];
    _commentView.frame = CGRectMake(0, ScreenHeight - 110, ScreenWidth, 120);
    _commentView.backgroundColor = [UIColor whiteColor];
    
    
    
    [self addSubview:_commentView];
    
    _sendButon = [UIButton buttonWithType:UIButtonTypeSystem];
    _sendButon.frame = CGRectMake(ScreenWidth - 60,0, 60, 30);
    [_sendButon setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButon setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_sendButon setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_sendButon addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    _sendButon.enabled = NO;
    [_commentView addSubview:_sendButon];
    
    _commentTextView = [[UITextView alloc]init];
    _commentTextView.frame = CGRectMake(10, _sendButon.bottom, 300, 80);
    _commentTextView.delegate = self;
    _commentTextView.layer.borderWidth = 1;
    _commentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    
    [_commentView addSubview:_commentTextView];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 180, 30)];
    lable.font = [UIFont boldSystemFontOfSize:16];
    lable.textColor = [UIColor colorWithRed:0.427 green:0.427 blue:0.427 alpha:1];
    lable.text = @"我来说两句";
    [_commentView addSubview:lable];
    [lable release];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(5, 0, 20, 30);
    [cancelButton setTitle:@"X" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(removerComment) forControlEvents:UIControlEventTouchUpInside];
    [_commentView addSubview:cancelButton];
    
    
    
    //添加图片背影
    UIView *addImageView         = [[UIView alloc]init];
    addImageView.frame           = CGRectMake(cancelButton.right + 20, 2, 24, 24);
    addImageView.backgroundColor = [UIColor clearColor];
    [_commentView addSubview:addImageView];
    [addImageView release];

    _addImageButton              = [UIButton buttonWithType:UIButtonTypeCustom];
    _addImageButton.frame         = addImageView.frame;
    [_addImageButton setImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
    [_addImageButton setImage:[UIImage imageNamed:@"add_image_h"] forState:UIControlStateHighlighted];
    [_addImageButton addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView addSubview:_addImageButton];

    
    
    
    
     
}

#pragma mark sendAction 

- (void)addImageAction:(UIButton*)but
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从摄像机照相" otherButtonTitles:@"从相册里选相片", nil];
    
    
    [actionSheet showInView:self];
    
}
- (void)sendAction{
    
    
    _getBlock(_commentTextView.text,_addImage);
    
    Block_release(_getBlock);
    _getBlock = nil;
    
    
    [self removerComment];
}

- (void)removerComment{
    
    [UIView animateWithDuration:0.3 animations:^{
        [_commentView resignFirstResponder];
        _commentView.transform = CGAffineTransformIdentity;
        
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        _addImage = nil;
        _addImageView = nil;
    }] ;
    
    
}

#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    if (buttonIndex == 2) {
        return;
    }
    else if (buttonIndex == 0)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (buttonIndex == 1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self.viewVC presentViewController:imagePicker animated:YES completion:NULL];
    [imagePicker release];
     
}

#pragma mark UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _addImage = image;
    _addImageView = [[UIImageView alloc]init];
    _addImageView.frame = _addImageButton.frame;
    _addImageView.userInteractionEnabled = YES;
    _addImageView.image = _addImage;
    _addImageButton.hidden = YES;
    [_addImageView addGestureRecognizer:tap];
    [_commentView addSubview:_addImageView];
    [self.viewVC dismissViewControllerAnimated:YES completion:nil];
    [tap release];
    
}

//压缩图片

#pragma mark UITapGestureRecognizer
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
    [self fullImageView:100];
}

- (void)delFullImageViewTap:(UITapGestureRecognizer *)tap{
    
    [self minImageView:100];
  }


#pragma mark 放大和，缩小图片
- (void)fullImageView:(NSInteger)tag
{
    UITapGestureRecognizer *delFullImageView  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delFullImageViewTap:)];
    UIImageView *fullImageView = [[UIImageView alloc]init];
    fullImageView.userInteractionEnabled = YES;
    fullImageView.frame = _addImageView.frame;
    fullImageView.image = _addImageView.image;
    fullImageView.tag = tag;
    fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [fullImageView addGestureRecognizer:delFullImageView];
    [delFullImageView release];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        fullImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self addSubview:fullImageView];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
   [fullImageView release];
}

- (void)minImageView:(NSInteger)tag
{
    
    
    UIImageView *fullImageView = (UIImageView*)[self viewWithTag:tag];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        fullImageView.frame = _addImageView.frame;
      
        
    } completion:^(BOOL finished) {
           [fullImageView removeFromSuperview];
    } ];
}


- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
 {
    
    
     UIGraphicsBeginImageContext(newSize);
    
     [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
     UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
     UIGraphicsEndImageContext();
     return newImage;
    
 }



#pragma mark UITextView delegate

 
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0 ) {
        _sendButon.enabled = YES;
    }else{
        _sendButon.enabled = NO;
    }
    
    
    
    
    
}
#pragma mark UITextView NSNotification
- (void)keyboardNotificationAction:(NSNotification *)noti{
    
    NSValue * KeyboardValue = [noti.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect frame = [KeyboardValue CGRectValue];
    float height = frame.size.height;
    
    _commentView.bottom = ScreenHeight - height;
    
    
}

- (void)dealloc
{
    NSLog(@"_commentTextView");
    [super dealloc];
    [_commentTextView release];
    [_commentView release];
    [_addImage release];
    [_addImageButton release];
//    [_sendButon release];
}
 

@end
