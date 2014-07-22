//
//  ShopCell.h
//  tanguilin
//
//  Created by yangyuji on 14-2-19.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
@interface ShopCell : UITableViewCell{
    
    IBOutlet UIImageView *_shop_image;
    IBOutlet UILabel *_shop_title;
    IBOutlet UILabel *_shop_tel;
    IBOutlet UILabel *_shop_addr;
    IBOutlet UILabel *_shop_frist_operate;
    UILabel *_shop_map_m;
}

@property (nonatomic,retain)ShopModel *shopModel;

 
@end
