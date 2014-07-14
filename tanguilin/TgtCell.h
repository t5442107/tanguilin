//
//  tgtCell.h
//  tanguilin
//
//  Created by yangyuji on 14-3-6.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TgModel.h"
@interface TgtCell : UITableViewCell
{
    
    IBOutlet UIImageView *_art_icon;
    IBOutlet UILabel *_art_title;
    IBOutlet UILabel *_art_author;
    IBOutlet UILabel *_art_addr_name;
}

@property (nonatomic,retain)TgModel *tgModel;
@end
