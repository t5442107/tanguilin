//
//  HdpIndexModel.h
//  tanguilin
//
//  Created by yangyuji on 14-2-18.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface HdpIndexModel : JSONModel

@property (nonatomic,assign) NSUInteger slideid;
@property (nonatomic,copy  ) NSString   *slide_title;
@property (nonatomic,copy  ) NSString   *slide_url;
@property (nonatomic,copy  ) NSString   *slide_pic;
@property (nonatomic,copy  ) NSString   *slide_posttime;


@end
