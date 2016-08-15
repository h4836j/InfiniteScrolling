//
//  MyCollectionView.m
//  Demo
//
//  Created by HJ on 16/1/4.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "MyCollectionView.h"
#import "UnlimitScrollViewCell.h"

#define imageCount 1000
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface MyCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    callBackForModel modelBack;
    callBack urlBack;
}
/** collectionView */
@property (strong, nonatomic) UICollectionView *collectionView;
/** 流式布局 */
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 定时器 */
@property (strong, nonatomic) NSTimer *timer;
/** 显示分页控件 */
@property (strong, nonatomic) UIPageControl *pageControl;
/** 模型数组（含有图片URL）*/
@property (nonatomic,strong) NSArray *models;
@end

@implementation MyCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

+ (instancetype)creatNewCollectionView
{
    MyCollectionView *myView = [[MyCollectionView alloc] init];
    return myView;
}

- (void)setUp
{
    // 设置基本参数的初始值
    // item的水平和垂直间距
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    // 水平滑动
    self.scrollDirection = MyCollectionViewScrollDirectionHorizontal;
    // 尺寸
    self.itemSize = CGSizeMake(KScreenWidth - 10, 150);
    self.timeInterval = 2.0;
    self.needCycleRoll = YES;
    self.showPageControl = YES;
    [self setUpLayout];
    [self setUpCollectionView];
    [self setUpPageControl];
    [self addTimer];
//    //
//    self.titleBackColor = [UIColor whiteColor];
    
}


+ (instancetype)scrollViewWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr
{
    MyCollectionView *view = [[MyCollectionView alloc] initWithFrame:frame];
    view.images = imageArr;
    return view;
}


+ (instancetype)scrollViewWithFrame:(CGRect)frame modelArr:(NSArray *)modelArr imagePropertyName:(NSString *)imageName
{
    MyCollectionView *view = [[MyCollectionView alloc] initWithFrame:frame];
    view.models = modelArr;
    
    if (modelArr.count==0)
    {
        return view;
    }
    
    NSMutableArray *imagePaths = [[NSMutableArray alloc]init];
    for (id  model in modelArr)
    {
        NSString * path = [model valueForKey:imageName];
        if (path==nil)
            path = @"";
        [imagePaths addObject:path];
    }
    view.imgUrlStr = imagePaths;
    return view;
}

+ (instancetype)scrollViewWithFrame:(CGRect)frame imagesStr:(NSArray *)imagesStrArr placeHoderImageName:(NSString *)imageName
{
    MyCollectionView *view = [[MyCollectionView alloc] initWithFrame:frame];
    view.imgUrlStr = imagesStrArr;
    return view;
}


#pragma mark - 初始化控件
- (void)setUpLayout
{
    // 设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // item的水平和垂直间距
    layout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    layout.minimumLineSpacing = self.minimumLineSpacing;
    // 滑动方向
    switch (self.scrollDirection) {
        case MyCollectionViewScrollDirectionHorizontal:
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            break;
        case MyCollectionViewScrollDirectionVertical:
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            break;
        default:
            break;
    }
    // 尺寸
    layout.itemSize = self.itemSize;
    self.layout = layout;
}
- (void)setUpCollectionView
{
    CGRect frame = CGRectMake(5, 300, KScreenWidth - 5, 150);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout: self.layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    self.collectionView = collectionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:collectionView];
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"UnlimitScrollViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:500 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    self.collectionView.scrollEnabled = NO;
    
}
- (void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    self.pageControl = pageControl;
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    CGFloat pageY = self.bounds.size.height - 30;
    CGFloat pageW = self.images.count * 30;
    CGFloat pageX = ( self.bounds.size.width - pageW ) * 0.5;
    CGFloat pageH = 20;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
}

- (UIImage *)placeHoldImage
{
    if (_placeHoldImage == nil) {
        _placeHoldImage = [UIImage imageNamed:@"屏幕快照 2015-11-26 下午6.55.06"];
    }
    return _placeHoldImage;
}

#pragma mark - UICollectionViewDelegate && UICollectionViewCellDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.images.count * imageCount;
    
    return count ? count : 5000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UnlimitScrollViewCell *cell = [UnlimitScrollViewCell cellForItemWithCollectionView:collectionView atIndexPath:indexPath];
    if (self.titleColor) {
        cell.titleLabel.textColor = self.titleColor;
    }
    if (self.titleBackColor) {
        cell.titleLabel.backgroundColor = self.titleBackColor;
    }
    if (self.titleFont) {
        cell.titleLabel.font = self.titleFont;
    }
    
    if (self.images.count) { // 以图片的形式传递进来
        NSDictionary *image = self.images[indexPath.item % self.images.count];
        cell.scrollImage = [UIImage imageNamed:image[@"icon"]];
        cell.title = image[@"title"];
    }
    else if (self.imgUrlStr.count){ // 以链接的形式传递进来
        cell.imgUrlStr = self.imgUrlStr[indexPath.item % self.imgUrlStr.count];
    }
    else { // 没有图片显示占位图片
        cell.scrollImage = self.placeHoldImage;
    }
    if (self.titles.count && (self.titles.count == self.images.count || self.titles.count == self.imgUrlStr.count)) {
        cell.title = self.titles[indexPath.item % self.titles.count];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"====%ld====%ld",indexPath.row, indexPath.section);
    
    if (urlBack)
    {
        if (self.images.count) { // 以图片的形式传递进来
            urlBack(indexPath.item, nil);
        }
        else if (self.imgUrlStr.count) // 以链接的形式传递进来
        {
            NSString *urlStr = self.imgUrlStr[indexPath.item % self.images.count];
            urlBack(indexPath.item, urlStr);
        }
        
    }
    if (self.models && modelBack)
    {
        modelBack(self.models[indexPath.item % self.images.count]);
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!self.images) return;
    // 开启定时器
    [self addTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!self.images) return;
    if(scrollView!=self.collectionView) return;
    CGFloat scrollW = self.itemSize.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    self.pageControl.currentPage = page % self.images.count;
}

#pragma mark - 定时器的控制
- (void)addTimer
{
    if (!self.needCycleRoll) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextImage
{
    CGFloat scrollW = self.itemSize.width;
    NSInteger pages = (self.collectionView.contentOffset.x + scrollW * 0.5) / scrollW;
    pages++;
    if (pages >= self.images.count * imageCount) {
        pages = 0;
    }
    CGFloat offsetX = pages * (self.itemSize.width + self.minimumLineSpacing);
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.collectionView setContentOffset:offset animated:YES];
    
}

#pragma mark - 重写setter方法
- (void)setImages:(NSArray *)images
{
    _images = images;
    if (images.count && self.collectionView) {
        self.collectionView.scrollEnabled = YES;
        self.pageControl.numberOfPages = images.count;
        NSInteger number = images.count * imageCount;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:number*0.5 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    } else {
        self.collectionView.scrollEnabled = NO;
    }
    [self.collectionView reloadData];
}

- (void)setImgUrlStr:(NSArray *)imgUrlStr
{
    _imgUrlStr = imgUrlStr;
    if (imgUrlStr.count && self.collectionView) {
        self.collectionView.scrollEnabled = YES;
        self.pageControl.numberOfPages = imgUrlStr.count;
        NSInteger number = imgUrlStr.count * imageCount;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:number*0.5 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    } else {
        self.collectionView.scrollEnabled = NO;
    }
    [self.collectionView reloadData];
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    if (!showPageControl) {
        [self.pageControl removeFromSuperview];
    }
}

#pragma mark - 其他方法
- (void)imageClink:(callBack)callBackUrl
{
    urlBack = callBackUrl;
}

- (void)modelImageClink:(callBackForModel)callBackModel
{
    modelBack = callBackModel;
}
- (void)dealloc
{
    [self removeTimer];
}

@end
