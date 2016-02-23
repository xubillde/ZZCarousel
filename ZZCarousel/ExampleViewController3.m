//
//  ExampleViewController3.m
//  ZZCarousel
//
//  Created by Liu on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ExampleViewController3.h"
#import "ZZCarouselControl.h"
#import "NetRequest.h"
#import "UIImageView+WebCache.h"

@interface ExampleViewController3()<ZZCarouselDataSource,ZZCarouselDelegate>

@property (strong, nonatomic) NSMutableArray *array;

@end


@implementation ExampleViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    ZZCarouselControl *carouselView = [[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    carouselView.carouseScrollTimeInterval = 2.0f;
    carouselView.dataSource = self;
    carouselView.delegate = self;
    [self.view addSubview:carouselView];
    
    _array = [NSMutableArray array];
    
    NSDictionary *param = @{
                            @"num":@"7",
                            };
    
    
    [NetRequest GETRequest:@"http://apis.baidu.com/txapi/mvtp/meinv" WithParams:param WithSuccess:^(id responseObject){

        NSArray *array = [responseObject objectForKey:@"newslist"];
        NSLog(@"%@",array);
    
        [_array addObjectsFromArray:array];
        
        /*
         *   必须实现下面重载数据方法
         */
        [carouselView reloadData];
    
    } WithFail:^(NSError *error){
        NSLog(@"%@",error);
    
    
    } WithNetState:^(){
    
    }];
    
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[data objectAtIndex:index] objectForKey:@"picUrl"]]];
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
    NSLog(@"点击了 %lu",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
