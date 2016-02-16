//
//  ExampleViewController1.m
//  ZZCarousel
//
//  Created by Liu on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ExampleViewController1.h"
#import "ZZCarouselControl.h"

@interface ExampleViewController1()<ZZCarouselDataSource,ZZCarouselDelegate>

@property (strong, nonatomic) NSArray *array;

@end

@implementation ExampleViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _array = @[@{@"image":[UIImage imageNamed:@"zz1.jpg"],@"title":@"标题1",@"url":@"www.baidu.com"},
               @{@"image":[UIImage imageNamed:@"zz2.jpg"],@"title":@"标题2",@"url":@"www.qq.com"},
               @{@"image":[UIImage imageNamed:@"zz3.jpg"],@"title":@"标题3",@"url":@"www.58.com"},
               @{@"image":[UIImage imageNamed:@"zz4.jpg"],@"title":@"标题4",@"url":@"www.zhilian.com"},
               @{@"image":[UIImage imageNamed:@"zz5.jpg"],@"title":@"标题5",@"url":@"www.huoying.com"}];
    

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
    
    //此处控件可以添加多个。例如此时包含标题和图片。
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    imageView.image = [[data objectAtIndex:index] objectForKey:@"image"];
    [view addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.6;
    label.text = [[data objectAtIndex:index] objectForKey:@"title"];
    [view addSubview:label];
    
    return view;
}

#pragma mark --- delegate

-(void)zzcarouselView:(ZZCarouselControl *)zzcarouselView didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"点击了 %@",[[_array objectAtIndex:index] objectForKey:@"url"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
