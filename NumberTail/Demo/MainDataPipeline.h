//
//  MainDataPipeline.h
//  NumberTail
//
//  Created by lixun on 2017/3/25.
//  Copyright © 2017年 sunshine. All rights reserved.
//

#import "MIPipeline.h"

@interface MainDataPipeline : MIPipeline

@property (nonatomic, copy) NSDictionary *mainModels;

/**
 请求是否完成
 */
@property (nonatomic, assign) BOOL isRequestFinish;

/**
 请求错误/网络请求失败
 */
@property (nonatomic, assign) BOOL isRequestError;

@end
