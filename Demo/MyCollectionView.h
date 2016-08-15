//
//  MyCollectionView.h
//  Demo
//
//  Created by HJ on 16/1/4.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^callBack)(NSInteger index,NSString * imageURL);
typedef void(^callBackForModel)(id model);

typedef enum
{
    MyCollectionViewScrollDirectionVertical,
    MyCollectionViewScrollDirectionHorizontal
}MyCollectionViewScrollDirection;

@interface MyCollectionView : UIView

+ (instancetype)creatNewCollectionView;
/** 图片链接地址 */
@property (strong, nonatomic) NSArray *imgUrlStr;
/** 图片数组 */
@property (strong, nonatomic) NSArray *images;
/** 标题数组 */
@property (strong, nonatomic) NSArray *titles;
/** 定时器时间，默认为2s */
@property (assign, nonatomic) CGFloat timeInterval;
/** 是否需要定时循环滚动 默认开启*/
@property (nonatomic,assign, getter=isNeedCycleRoll) BOOL needCycleRoll;
/** 是否显示pageControl */
@property (assign,nonatomic,getter=isShowPageControl) BOOL showPageControl;
/** 占位图片 */
@property (strong, nonatomic) UIImage *placeHoldImage;
/** 滑动方向 */
@property (assign, nonatomic) MyCollectionViewScrollDirection scrollDirection;
/** 最小item间距 */
@property (assign, nonatomic) CGFloat minimumInteritemSpacing;
/** 最小行间距 */
@property (assign, nonatomic) CGFloat minimumLineSpacing;
/** item的大小 */
@property (assign, nonatomic) CGSize itemSize;

/** 标题字体大小 */
@property (strong, nonatomic) UIFont *titleFont;
/** 字体颜色 */
@property (strong, nonatomic) UIColor *titleColor;
/** 标题背景颜色 */
@property (strong, nonatomic) UIColor *titleBackColor;


/** 给图片创建点击后的回调方法 */
- (void)imageClink:(callBack)callBackUrl;
/** 通过模型获取当前被点击对象,并回传当前图片的模型,只有在使用模型初始化循环滚动时才有效 */
- (void)modelImageClink:(callBackForModel)callBackModel;

/**
 *  @param frame                设置Frame
 *  @param imageArr             图片数组
 *  @param PageControlShowStyle PageControl显示位置
 *
 *  @return 无限滚动视图
 */
+ (instancetype)scrollViewWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr;

/**
 *  传递模型数组,每个模型中都拥有自己的图片链接属性
 *
 *  @param modelArr             模型数组
 *  @param imageName            属性名称
 */
+ (instancetype)scrollViewWithFrame:(CGRect)frame modelArr:(NSArray *)modelArr imagePropertyName:(NSString *)imageName;
/**
 *  传递
 *
 *  @param frame                设置的frame
 *  @param imagesStrArr         图片链接地址字符串数组
 *  @param imageName            占位图片
 *
 *  @return 无限滚动视图
 */
+ (instancetype)scrollViewWithFrame:(CGRect)frame imagesStr:(NSArray *)imagesStrArr placeHoderImageName:(NSString *)imageName;



@end
