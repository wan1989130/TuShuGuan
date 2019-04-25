//
//  FVSeatItem.h
//  FVCinemaSeatsView
//
//  Created by iforvert on 2016/11/13.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址：https://www.github.com/Upliver/FVSeatsPicker

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FVSeatState)
{
    FVSeatsStateAvailable   = 0,          // 可用
    FVSeatsStateUnavailable = 1,          // 不可用
    //    FVSeatsStateLocked      = 2,          // 被锁定
    FVSeatsStateSellOut     = 2,           // 他人选中
    FVSeatsStateSelected    = 3          // 我选中
};

@interface FVSeatItem : NSObject

@property(nonatomic, assign) int seatId;
@property(nonatomic, strong) NSString *seatName;
@property(nonatomic, assign) int price;
@property(nonatomic, assign) int col;
@property(nonatomic, assign) int row;
@property(nonatomic, assign) FVSeatState seatStatus;
@property(nonatomic, assign) int coordinateX;
@property(nonatomic, assign) int coordinateY;

@end
