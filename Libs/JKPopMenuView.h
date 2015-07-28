//
//  JKPopMenuView.h
//  
//
//  Created by Bingjie on 14/12/15.
//  Copyright (c) 2015年 Bingjie. All rights reserved.
//

#import "JKPopMenuItem.h"

typedef void (^JKPopMenuViewSelectBlock)(NSInteger index);

@protocol JKPopMenuViewSelectDelegate <NSObject>
-(void)popMenuViewSelectIndex:(NSInteger)index;
@end

@interface JKPopMenuView : UIView

@property (nonatomic, copy) NSArray *menuItems;

@property (nonatomic, copy) JKPopMenuViewSelectBlock selectBlock;
@property (nonatomic, assign) id<JKPopMenuViewSelectDelegate> delegate;

+ (instancetype)menuView;
+ (instancetype)menuViewWithItems:(NSArray*)items;
- (void)show;

@end

@interface UIView (Additions)
- (CABasicAnimation *)fadeIn;
- (CABasicAnimation *)fadeOut;

@end
