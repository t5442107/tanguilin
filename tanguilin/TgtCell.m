//
//  tgtCell.m
//  tanguilin
//
//  Created by yangyuji on 14-3-6.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "TgtCell.h"
#import "UIImageView+WebCache.h"
@implementation TgtCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

- (void)awakeFromNib{
    [self _initView];
}

- (void)_initView{
    
    _art_icon.layer.borderWidth = 1;
    _art_icon.layer.borderColor = [UIColor colorWithRed:0.573 green:0.573 blue:0.573 alpha:1].CGColor;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *imageUrl = [NSString stringWithFormat:@"http://www.0773time.com/Public/uploads/food/foreteste/tgarticle/covericon/100_%@",_tgModel.art_icon];
    
    [_art_icon setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"back.png"]];
    
    _art_title.text     = _tgModel.art_title;
    _art_author.text    = _tgModel.art_author;
    _art_addr_name.text = _tgModel.art_addr_name != nil ?_tgModel.art_addr_name:_tgModel.art_addr;
    
    
}




- (void)dealloc {
    [_art_icon release];
    [_art_title release];
    [_art_author release];
    [_art_addr_name release];
    [super dealloc];
}
@end
