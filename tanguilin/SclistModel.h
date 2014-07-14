//
//  SclistModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-14.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface SclistModel : JSONModel

@property (nonatomic,retain)NSNumber *sc_id;
@property (nonatomic,copy)NSString *sc_name;
@property (nonatomic,retain)NSNumber *sc_category;
@end
