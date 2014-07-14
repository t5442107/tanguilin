//
//  ShopInfoCommentCell.h
//  tanguilin
//
//  Created by yangyuji on 14-3-3.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopInfoCommentModel.h"
@interface ShopInfoCommentCell : UITableViewCell{
    
    IBOutlet UIImageView *_userImage;
    IBOutlet UILabel *_ctime;
    IBOutlet UILabel *_comment;
    UIImageView *_commentImageView;
    
}

@property (nonatomic,retain)IBOutlet UILabel *username;
@property (nonatomic,retain)ShopInfoCommentModel *shopInfoCommentModel;

+ (float)getCellHeight:(ShopInfoCommentModel*)shopInfoCommentModel tableview:(UITableView*)tableview;

@end
