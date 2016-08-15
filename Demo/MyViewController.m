//
//  MyViewController.m
//  Demo
//
//  Created by HJ on 16/1/4.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "MyViewController.h"
//#import "ViewController.h"
#import "AdView.h"
#import "MyCollectionView.h"

@interface picture : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;

+ (instancetype)pictureWithDict:(NSDictionary *)dict;

@end

@implementation picture

+ (instancetype)pictureWithDict:(NSDictionary *)dict
{
    picture *pic = [[picture alloc] init];
    pic.icon = dict[@"icon"];
    pic.title = dict[@"title"];
    
    return pic;
}

@end

@interface MyViewController ()
@property (strong, nonatomic) AdView *adView;
@property (strong, nonatomic) NSArray *images;

@property (strong, nonatomic) MyCollectionView *collectionView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat KScreenWidth = [UIScreen mainScreen].bounds.size.width;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"images.plist" ofType:nil];
    self.images = [NSArray arrayWithContentsOfFile:path];
    
    MyCollectionView *collection = [MyCollectionView creatNewCollectionView];
    collection.frame = CGRectMake(5, 100,KScreenWidth - 10 , 150);
//    collection.backgroundColor = [UIColor blueColor];
    self.collectionView = collection;
    [self.view addSubview:collection];
    
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.collectionView.images = self.images;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
