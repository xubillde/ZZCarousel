//
//  ExampleViewController2.m
//  ZZCarousel
//
//  Created by Liu on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ExampleViewController2.h"
#import "ZZCarouselControl.h"
#import "UIImageView+WebCache.h"
@interface ExampleViewController2()<ZZCarouselDataSource,ZZCarouselDelegate>

@property (strong, nonatomic) NSArray *array;

@end

@implementation ExampleViewController2
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _array = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];
    
    
    ZZCarouselControl *carouselView = [[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    carouselView.carouseScrollTimeInterval = 2.0f;
    carouselView.dataSource = self;
    carouselView.delegate = self;
    [self.view addSubview:carouselView];
    
    
    /*
     *   必须实现下面重载数据方法
     */
    
    [carouselView reloadData];
    
    
}

#pragma mark --- dataSource
-(NSArray *) zzcarousel:(ZZCarouselControl *)carouselView
{
    return _array;
}

-(UIView *) zzcarousel:(ZZCarouselControl *)carouselView carouselFrame:(CGRect)frame data:(NSArray *)data viewForItemAtIndex:(NSInteger)index
{
    /*
     *   此方法中必须返回UIView
     *   注意在此方法中创建 UI 控件时，必须使用此方法冲的frame参数来设定位置。
     *   注意在此方法中的数据源必须从data参数中获取。
     */
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[data objectAtIndex:index]]];
    [view addSubview:imageView];
    
    
    return view;
}

#pragma mark --- delegate

-(void)zzcarouselView:(ZZCarouselControl *)zzcarouselView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了 %lu",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
