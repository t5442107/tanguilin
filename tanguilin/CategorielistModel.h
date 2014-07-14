//
//  CategorielistModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-14.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface CategorielistModel : JSONModel

@property (nonatomic,retain)NSNumber *cat_id;
@property (nonatomic,retain)NSNumber *cat_parent;
@property (nonatomic,retain)NSNumber *cat_group;
@property (nonatomic,retain)NSNumber *cat_group_order;
@property (nonatomic,retain)NSNumber *cat_order;
@property (nonatomic,retain)NSNumber *cat_level;
@property (nonatomic,retain)NSNumber *cat_havechild;
@property (nonatomic,copy)NSString *cat_title;

@end
