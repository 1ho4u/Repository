//
//  ReadBaseCell.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "ReadBaseCell.h"
#import "EssayItem.h"
#import "QuestionItem.h"
#import "SerialItem.h"
#import "AuthorItem.h"
#import <Masonry/Masonry.h>

NSString *const kReadBaseCellID = @"ReadBaseCellID";

@interface ReadBaseCell ()

@property (nonatomic, strong) UIImageView *readTypeView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ReadBaseCell

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews {
    
    self.backgroundColor = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _readTypeView = [[UIImageView alloc] init];
    _readTypeView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_readTypeView];
    [_readTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(41, 19));
        make.top.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor colorWithWhite:51 / 255.0 alpha:1];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_readTypeView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.lessThanOrEqualTo(_readTypeView.mas_left).offset(-10);
    }];
    
    _authorLabel = [UILabel new];
    _authorLabel.font = [UIFont systemFontOfSize:13];
    _authorLabel.textColor = [UIColor colorWithWhite:90 / 255.0 alpha:1];
    [self.contentView addSubview:_authorLabel];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(_titleLabel);
    }];
                           
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor =[UIColor colorWithWhite:90 / 255.0 alpha:1];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_authorLabel);
        make.top.equalTo(_authorLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-24);
    }];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor colorWithWhite:229 / 255.0 alpha:1];
    [self.contentView addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.bottom.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithEssayItem:(EssayItem *)item {
    _readTypeView.image = [UIImage imageNamed:@"icon_read"];
    _titleLabel.text = item.title;
    _authorLabel.text = [[item.authorItems lastObject] userName];
    _contentLabel.text = item.guideWord;
    
}

- (void)configureCellWithQuestionItem:(QuestionItem *)item {
    _readTypeView.image = [UIImage imageNamed:@"icon_question"];
    _titleLabel.text = item.questionTitle;
    _authorLabel.text = item.answerTitle;
    _contentLabel.text = item.answerContent;
    _bottomLine.hidden = YES;
}

- (void)configureCellWithSerialItem:(SerialItem *)item {
    _readTypeView.image = [UIImage imageNamed:@"icon_serial"];
    _titleLabel.text = item.title;
    _authorLabel.text = item.authorItem.userName;
    _contentLabel.text = item.excerpt;
}


@end
