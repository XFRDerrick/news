//
//  NewsTableViewCell.m
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "NewsTableViewCell.h"

#import "News.h"
#import <UIImageView+AFNetworking.h>

@interface NewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *digestLable;
@property (weak, nonatomic) IBOutlet UILabel *replayCountLable;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImageViews;



@end


@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.digestLable.preferredMaxLayoutWidth = self.bounds.size.width- 104;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setNews:(News *)news{

    _news = news;
    [self.iconView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    self.titleLable.text = news.title;
    self.digestLable.text = news.digest;
    self.replayCountLable.text = [NSString stringWithFormat:@"%d",news.replyCount];
    
    //判断是否是多图的Cell
    if (news.imgextra.count == 2) {
        for (int i = 0; i<2; i++) {
            UIImageView *everyImageView = self.extraImageViews[i];
            NSString *imageURLString = news.imgextra[i][@"imgsrc"];
            [everyImageView setImageWithURL:[NSURL URLWithString:imageURLString]];
            
        }
    }
}
@end
