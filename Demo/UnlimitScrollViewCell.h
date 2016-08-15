//
//  UnlimitScrollViewCell.h
//  Demo
//
//  Created by HJ on 15/11/27.
//  Copyright © 2015年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnlimitScrollViewCell : UICollectionViewCell
/** 显示的图片 */
@property (strong, nonatomic) UIImage *scrollImage;
/** 图片标题 */
@property (copy, nonatomic) NSString *title;
/** 图片链接地址 */
@property (copy, nonatomic) NSString *imgUrlStr;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellForItemWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
