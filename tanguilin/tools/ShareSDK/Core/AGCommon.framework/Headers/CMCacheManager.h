//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CMLoader.h"

/**
 *	@brief	缓存管理器
 */
@interface CMCacheManager : NSObject
{
	//加载队列，尚未从网络获取本地加载完毕的将会进入此队列。
	NSMutableArray *_loaderQueue;
	//缓存路径
	NSString *_cachePath;
}

/**
 *	@brief	加载文件
 *
 *	@param 	url 	文件路径
 *
 *	@return	文件加载器
 */
- (CMLoader *)load:(NSURL *)url;


@end
