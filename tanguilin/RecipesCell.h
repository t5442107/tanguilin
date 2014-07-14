//
//  RecipesCell.h
//  tanguilin
//
//  Created by yangyuji on 14-3-11.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipesModel.h"
@interface RecipesCell : UITableViewCell
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UILabel *_titleLabel;
    
    IBOutlet UILabel *_jianJieLabel;
     
     UIButton *_shouChangButton;
}

@property (nonatomic ,retain)RecipesModel *recipesModel;

+ (float)getCellHeight:(RecipesModel*)recipesModel tableview:(UITableView*)tableview;
- (IBAction)shouChangAction:(id)sender;
@end
