//
//  ShopModel.h
//  tanguilin
//
//  Created by yangyuji on 14-2-19.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"

@interface ShopModel : JSONModel

/*
 ["shopid"] => string(3) "188"
 ["catid"] => string(1) "1"
 ["shop_isshow"] => string(1) "1"
 ["shop_is_comment"] => string(1) "1"
 ["shop_star"] => string(1) "3"
 ["shop_chain_store"] => string(1) "0"
 ["shop_posttime"] => string(10) "1346898015"
 ["shop_name"] => string(24) "勾味王•喜宴酒楼"
 ["shop_icon"] => string(17) "50480799ddd7c.jpg"
 ["shop_business_hours"] => string(16) "11:00——21:00"
 ["shop_frist_operate"] => string(16) "桂林菜,粤菜"
 ["shop_secondary_operate"] => string(0) ""
 ["shop_other_operate"] => string(0) ""
 ["shop_consumer_guide"] => string(0) ""
 ["shop_area"] => string(6) "450304"
 ["shop_area_title"] => string(9) "象山区"
 ["shop_towns"] => string(1) "0"
 ["shop_towns_title"] => string(0) ""
 ["shop_road"] => string(15) "黑山植物园"
 ["shop_address"] => string(33) "桂林市黑山植物园大门旁"
 ["shop_phone"] => string(15) "2533678,2536298"
 ["shop_paymentaddress"] => string(25) "现金现结,银联刷卡"
 ["shop_cpc"] => string(8) "10-50元"
 ["shop_atmosphere"] => string(77) "家庭聚会,生活简餐,朋友聚会,情侣约会,商务洽谈,大型宴会"
 ["shop_decorate"] => string(6) "精装"
 ["shop_acreage"] => string(1) "0"
 ["shop_galleryful_all"] => string(1) "0"
 ["shop_room"] => string(0) ""
 ["shop_parking"] => string(3) "有"
 ["shop_bus"] => string(18) "10,12,20,36,85,202"
 ["shop_map_lng"] => string(10) "110.285035"
 ["shop_map_lat"] => string(9) "25.261819"
 ["shop_score_a"] => string(2) "32"
 ["shop_score_a_per"] => string(4) "4.57"
 ["shop_score_b"] => string(2) "30"
 ["shop_score_b_per"] => string(4) "4.29"
 ["shop_score_c"] => string(2) "31"
 ["shop_score_c_per"] => string(4) "4.43"
 ["shop_score_number"] => string(1) "7"
 ["shop_viewcount"] => string(4) "1392"
 ["keywords"] => string(0) ""
 ["shop_description"] => string(0) ""
 ["shop_keywords"] => string(0) ""
 */


@property (nonatomic,assign) NSUInteger shopid;
@property (nonatomic,assign) NSUInteger catid;
@property (nonatomic,copy  ) NSString   *shop_posttime;
@property (nonatomic,copy  ) NSString   *shop_name;
@property (nonatomic,copy  ) NSString   *shop_icon;
@property (nonatomic,copy  ) NSString   *shop_business_hours;
@property (nonatomic,copy  ) NSString   *shop_frist_operate;
@property (nonatomic,copy  ) NSString   *shop_secondary_operate;
@property (nonatomic,copy  ) NSString   *shop_area;
@property (nonatomic,copy  ) NSString   *shop_other_operate;
@property (nonatomic,copy  ) NSString   *shop_consumer_guide;
@property (nonatomic,copy  ) NSString   *shop_area_title;
@property (nonatomic,copy  ) NSString   *shop_towns;
@property (nonatomic,copy  ) NSString   *shop_towns_title;
@property (nonatomic,copy  ) NSString   *shop_road;
@property (nonatomic,copy  ) NSString   *shop_address;
@property (nonatomic,copy  ) NSString   *shop_phone;
@property (nonatomic,copy  ) NSString   *shop_paymentaddress;
@property (nonatomic,copy  ) NSString   *shop_cpc;
@property (nonatomic,copy  ) NSString   *shop_decorate;
@property (nonatomic,copy  ) NSString   *shop_acreage;
@property (nonatomic,copy  ) NSString   *shop_galleryful_all;
@property (nonatomic,copy  ) NSString   *shop_room;
@property (nonatomic,copy  ) NSString   *shop_parking;
@property (nonatomic,copy  ) NSString   *shop_bus;
@property (nonatomic,copy  ) NSString   *shop_map_lng;
@property (nonatomic,copy  ) NSString   *shop_map_lat;
@property (nonatomic,assign) NSUInteger shop_map_m;
@property (nonatomic,copy  ) NSString   *shop_score_a;
@property (nonatomic,copy  ) NSString   *shop_score_a_per;
@property (nonatomic,copy  ) NSString   *shop_score_b;
@property (nonatomic,copy  ) NSString   *shop_score_b_per;
@property (nonatomic,copy  ) NSString   *shop_score_c;
@property (nonatomic,copy  ) NSString   *shop_score_c_per;
@property (nonatomic,assign) NSUInteger shop_score_number;
@property (nonatomic,assign) NSUInteger shop_viewcount;
@property (nonatomic,copy  ) NSString   *keywords;
//@property (nonatomic,copy)NSString *shop_description;
//@property (nonatomic,copy)NSString *shop_keywords;











@end
