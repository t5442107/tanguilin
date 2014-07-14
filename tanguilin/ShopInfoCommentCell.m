//
//  ShopInfoCommentCell.m
//  tanguilin
//
//  Created by yangyuji on 14-3-3.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "ShopInfoCommentCell.h"
#import "UIImageView+WebCache.h" 
#import "UIUtils.h"
@implementation ShopInfoCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
     
    _userImage.contentMode = UIViewContentModeScaleAspectFit;
    _userImage.layer.cornerRadius = 8;
    _userImage.layer.masksToBounds = YES;
    _userImage.backgroundColor = [UIColor clearColor];
    
    _commentImageView = [[UIImageView alloc]init];
    _commentImageView.frame = CGRectMake(_comment.left, _comment.bottom + 5, 300, 300);
    _commentImageView.backgroundColor = [UIColor clearColor];
    _commentImageView.hidden = YES;
    [self.contentView addSubview:_commentImageView];
    
     
    
   
}


//返回高度
+ (float)getCellHeight:(ShopInfoCommentModel*)shopInfoCommentModel tableview:(UITableView*)tableview{
    
    // 列寬
    CGFloat contentWidth =  tableview.frame.size.width - 80;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:13];
    
    // 該行要顯示的內容
    NSString *content = [UIUtils getText:shopInfoCommentModel.shop_gb_content];
    // 計算出顯示完內容需要的最小尺寸
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    float h = 0;
    if (![shopInfoCommentModel.icon isEqualToString:@""]) {
        
        h = shopInfoCommentModel.icon_h.intValue;
    }
    
    return size.height + 50 + h;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _username.text = _shopInfoCommentModel.shop_gb_author;
    _ctime.text = _shopInfoCommentModel.shop_gb_postdatetime;
    
    _comment.text = [UIUtils getText:_shopInfoCommentModel.shop_gb_content];
    NSString *imgUrl = [NSString stringWithFormat:@"%@%d",UserFaceImage,_shopInfoCommentModel.shop_gb_authorid.intValue];
    NSURL *url = [NSURL URLWithString:imgUrl];
    [_userImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"back.png"]];
    
    if (![_shopInfoCommentModel.icon isEqualToString:@""]) {
        _commentImageView.hidden = NO;
        
        _commentImageView.width = _shopInfoCommentModel.icon_w.intValue;
        _commentImageView.height = _shopInfoCommentModel.icon_h.intValue;
        NSString *commentImage = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/shop/comment/icon/s_%@",_shopInfoCommentModel.icon];
        [_commentImageView setImageWithURL:[NSURL URLWithString:commentImage]];
    }
    
    //设置自动行数与字符换行
    [_comment setNumberOfLines:0];
    _comment.lineBreakMode = NSLineBreakByWordWrapping;
    
    UIFont *font = [UIFont systemFontOfSize:13];
    //设置一个行高上限
    CGSize size = CGSizeMake(ScreenWidth - 80,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_comment.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    _comment.frame = CGRectMake(_userImage.right + 10,_username.bottom + 5, labelsize.width, labelsize.height);
    
    
    
}



- (void)dealloc {
    [_userImage release];
    [_username release];
    [_ctime release];
    [_comment release];
    [_commentImageView release];
    [super dealloc];
}
@end
