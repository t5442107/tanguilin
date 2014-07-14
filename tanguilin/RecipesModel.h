//
//  RecipesModel.h
//  tanguilin
//
//  Created by yangyuji on 14-3-8.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "JSONModel.h"
#import "SamesczhulistModel.h"
#import "SamescfulistModel.h"
#import "KwviewrowModel.h"

@protocol SamesczhulistModel
@end
@protocol SamescfulistModel
@end
@protocol KwviewrowModel
@end

@interface RecipesModel : JSONModel
/**
 ["cbid"] => string(3) "694"
 ["cb_cid"] => string(2) "14"
 ["kw_cid"] => string(1) "7"
 ["cb_recommend"] => string(1) "0"
 ["cb_title"] => string(18) "火腿玉米浓汤"
 ["cb_datetime"] => string(19) "2014-03-04 15:12:30"
 ["cb_authorid"] => string(4) "1430"
 ["cb_author"] => string(2) "33"
 ["cb_icon"] => string(17) "53157b6fbeaa1.jpg"
 ["cb_isoriginal"] => string(1) "0"
 ["cb_content"] => string(1668) " "
 ["cb_contentpic"] => string(0) ""
 ["cb_healthfigure"] => string(1) "3"
 ["cb_bz_content"] => string(1612) " "
 ["cb_difficulty"] => string(1) "0"
 ["cb_tese"] => string(213) " "
 ["cb_sc_count"] => string(1) "1"
 ["cb_view_count"] => string(1) "0"
 ["zuoguo_count"] => string(1) "0"
 ["authoruid"] => string(1) "0"
 ["method_id"] => string(1) "0"
 ["shenhe"] => string(1) "1"
 ["isfont"] => string(1) "1"
 ["cb_keywords"] => string(6) "西餐"
 ["cb_tip"] => string(342) " "
 ["seo_keywords"] => string(31) "火腿玉米浓汤,玉米浓汤"
 ["seo_description"] => string(213) " "
 ["cb_ctitle"] => string(6) "西餐"
 
 ['isshouchang'] => 1 是否收藏
 ['sccb_id'] => 收藏ID
 sccb_id
 */

@property(nonatomic,retain)NSNumber<Optional> *cbid;
@property(nonatomic,retain)NSNumber<Optional> *cb_cid;
@property(nonatomic,retain)NSNumber<Optional> *kw_cid;

@property(nonatomic,copy)NSString<Optional> *cb_recommend;
@property(nonatomic,copy)NSString<Optional> *cb_title;
@property(nonatomic,copy)NSString<Optional> *cb_datetime;
@property(nonatomic,assign)NSNumber<Optional> *cb_authorid;
@property(nonatomic,copy)NSString<Optional> *cb_author;
@property(nonatomic,copy)NSString<Optional> *cb_icon;
@property(nonatomic,retain)NSNumber<Optional> *cb_icon_width;
@property(nonatomic,retain)NSNumber<Optional> *cb_icon_height;
@property(nonatomic,copy)NSString<Optional> *cb_icon_u;
@property(nonatomic,assign)NSNumber<Optional> *cb_isoriginal;
@property(nonatomic,copy)NSString<Optional> *cb_content;
@property(nonatomic,copy)NSString<Optional> *cb_contentpic;
@property(nonatomic,copy)NSString<Optional> *cb_healthfigure;
@property(nonatomic,copy)NSString<Optional> *cb_bz_content;
@property(nonatomic,copy)NSString<Optional> *cb_difficulty;
@property(nonatomic,copy)NSString<Optional> *cb_tese;
@property(nonatomic,assign)NSNumber<Optional> *cb_sc_count;
@property(nonatomic,assign)NSNumber<Optional> *cb_view_count;
@property(nonatomic,assign)NSNumber<Optional> *authoruid;
@property(nonatomic,assign)NSNumber<Optional> *method_id;
@property(nonatomic,assign)NSNumber<Optional> *shenhe;
@property(nonatomic,assign)NSNumber<Optional> *isfont;
@property(nonatomic,retain)NSNumber<Optional> *isshouchang;
@property(nonatomic,retain)NSNumber<Optional> *sccb_id;

@property(nonatomic,strong)NSArray<SamesczhulistModel,Optional> *samesczhulist;
@property(nonatomic,strong)NSArray<SamescfulistModel,Optional> *samescfulist;
@property(nonatomic,strong)NSArray<KwviewrowModel,Optional>  *kwviewrow;

















@end
