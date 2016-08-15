//
//  UnlimitScrollViewCell.m
//  Demo
//
//  Created by HJ on 15/11/27.
//  Copyright © 2015年 HJ. All rights reserved.
//

#import "UnlimitScrollViewCell.h"

@interface UnlimitScrollViewCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *scrollImageView;


@end

@implementation UnlimitScrollViewCell

+ (instancetype)cellForItemWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UnlimitScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setScrollImage:(UIImage *)scrollImage
{
    _scrollImage = scrollImage;
    self.scrollImageView.image = scrollImage ;
}

- (void)setImgUrlStr:(NSString *)imgUrlStr
{
    _imgUrlStr = imgUrlStr;
    NSURL *url = [NSURL URLWithString:imgUrlStr];
//    [self.scrollImageView sd_setImageWithURL:url placeholderImage:self.placeHoldImage];
}

@end
