//
//  SamesczhulistModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-13.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface SamesczhulistModel : JSONModel


@property(nonatomic,retain)NSNumber *id;
@property(nonatomic,retain)NSNumber *sc_id;
@property(nonatomic,retain)NSNumber *sc_cat;
@property(nonatomic,retain)NSNumber *cb_id;
@property(nonatomic,copy)NSString *sc_name;
@property(nonatomic,copy)NSString *sc_num;
@property(nonatomic,copy)NSString<Optional> *remark;


@end
