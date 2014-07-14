//
//  NSString+HTML.h
//  MWFeedParser
//
//  Copyright (c) 2010 Michael Waterfall
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//  
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the 
//     purpose of any concept relating to diary/journal keeping.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

// Dependant upon GTMNSString+HTML

@interface NSString (HTML)

// Strips HTML tags & comments, removes extra whitespace and decodes HTML character entities.
//条HTML标签和注释，删除多余的空格和解码HTML字符实体。
- (NSString *)stringByConvertingHTMLToPlainText;

// Decode all HTML entities using GTM.
//解码采用GTM所有HTML实体。
- (NSString *)stringByDecodingHTMLEntities;

// Encode all HTML entities using GTM.
//编码采用GTM所有HTML实体。
- (NSString *)stringByEncodingHTMLEntities;

// Minimal unicode encoding will only cover characters from table
// A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
// which is what you want for a unicode encoded webpage.
//最小unicode编码将只包括从表中的字符
//
//这是你想要的Unicode编码的网页是什么。
- (NSString *)stringByEncodingHTMLEntities:(BOOL)isUnicode;

// Replace newlines with <br /> tags.
//替换换行符与<br />标签。
- (NSString *)stringWithNewLinesAsBRs;

// Remove newlines and white space from string.
//从字符串中删除换行符和空格。
- (NSString *)stringByRemovingNewLinesAndWhitespace;

// Wrap plain URLs in <a href="..." class="linkified">...</a>
//  - Ignores URLs inside tags (any URL beginning with =")
//  - HTTP & HTTPS schemes only
//  - Only works in iOS 4+ as we use NSRegularExpression (returns self if not supported so be careful with NSMutableStrings)
//  - Expression: (?<!=")\b((http|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?)
//  - Adapted from http://regexlib.com/REDetails.aspx?regexp_id=96
/*
 在总结平原网址<a href="..." class="linkified"> ... < / A >
 忽略标签内的网址（ URL任何开头=“ ）
 HTTP和HTTPS配置只
 仅在iOS 4的+工程，我们使用NSRegularExpression （如果不支持，所以要小心使用NSMutableStrings返回self ）
 表达式： \ B （ （ HTTP | HTTPS） （ < =“ ？ ！ ） ： \ / \ / [ \ W \ - _ ] + （ \ [ \ W \ - _ ] +）+ （ [ \ W \ - \ ， @ ^ = ％ ＆ :/ 〜 \ + ＃ ] * [ \ W \ - ？ ？ ？ \ @ ^ = ％ ＆ / 〜 \ + ＃ ] ） ）
 从http://regexlib.com/REDetails.aspx?regexp_id=96改编
 */
- (NSString *)stringByLinkifyingURLs;

// DEPRECIATED - Please use NSString stringByConvertingHTMLToPlainText
//折旧 - 请使用NSString的stringByConvertingHTMLToPlainText
- (NSString *)stringByStrippingTags __attribute__((deprecated));

+ (NSDictionary *)htmlEscapes;
+ (NSDictionary *)htmlUnescapes;
- (NSString *)htmlEscapedString;
- (NSString *)htmlUnescapedString;

@end