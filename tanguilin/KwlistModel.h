//
//  KwlistModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-14.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface KwlistModel : JSONModel

@property (nonatomic,retain)NSNumber *kw_id;
@property (nonatomic,copy)NSString *kw_name;
@end
