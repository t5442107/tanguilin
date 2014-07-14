//
//  TgModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-6.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface TgModel : JSONModel

/**
 *  ["tgart_id"] => string(3) "103"
 ["art_posttime"] => string(10) "1393478588"
 ["uid"] => string(4) "9308"
 ["username"] => string(6) "良辰"
 ["art_author"] => string(6) "良辰"
 ["art_chihuo"] => string(0) ""
 ["art_addr_name"] => string(15) "恩典清真菜"
 ["art_addr"] => string(36) "象山区崇善路1号(近清真寺)"
 ["art_title"] => string(33) "掀起盖头看清“清真菜”"
 ["art_content"]
 ["art_contentpic"]
 ["piclist"]
 */

@property (nonatomic,retain)NSNumber * tgart_id;
@property (nonatomic,copy)NSString *art_posttime;
@property (nonatomic,retain)NSNumber * uid;
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *art_author;
@property (nonatomic,copy)NSString *art_chihuo;
@property (nonatomic,copy)NSString *art_addr_name;
@property (nonatomic,copy)NSString *art_addr;
@property (nonatomic,copy)NSString *art_title;
@property (nonatomic,copy)NSString *art_content;
@property (nonatomic,retain)NSArray *art_contentpic;
@property (nonatomic,retain)NSArray *piclist;
@property (nonatomic,retain)NSString *art_icon;
@end
