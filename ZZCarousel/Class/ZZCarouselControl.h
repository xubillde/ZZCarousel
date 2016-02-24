//
//  ZZCarouselControl.h
//  ZZCarousel
//
//  Created by Yuan on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZCarouselControl;

@protocol ZZCarouselDataSource <NSObject>

@required
- (NSArray *) zzcarousel:(ZZCarouselControl *)carouselView;
- (UIView *) zzcarousel:(ZZCarouselControl *)carouselView carouselFrame:(CGRect)frame data:(NSArray *)data viewForItemAtIndex:(NSInteger)index;

@end

@class ZZCarouselControl;

@protocol ZZCarouselDelegate <NSObject>

/*
 *  此方法为 用于ZZCarousel 轮播的点击方法
 */
@optional
- (void)zzcarouselView:(ZZCarouselControl *)zzcarouselView didSelectItemAtIndex:(NSInteger)index;


@end
@interface ZZCarouselControl : UIView

/*
 *   设置自动滚动时间
 */
@property (nonatomic, assign) CGFloat carouseScrollTimeInterval;

@property (nonatomic, weak) id <ZZCarouselDataSource> dataSource;
@property (nonatomic, weak) id <ZZCarouselDelegate> delegate;

/*
 *   重载数据
 */
-(void)reloadData;

@end
