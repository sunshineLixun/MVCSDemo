//
//  MainTableViewCell.m
//  NumberTail
//
//  Created by lixun on 2017/3/25.
//  Copyright © 2017年 sunshine. All rights reserved.
//

#import "MainTableViewCell.h"
#import "MainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset = UIEdgeInsetsZero;
}


- (void)setModel:(MainModel *)model{
    _model = model;
    self.nickLabel.text = model.author;
    [self.infoImageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.title.text = model.title;
    self.contentLabel.text = model.summary;
}

@end
