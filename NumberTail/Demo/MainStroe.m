//
//  MainStroe.m
//  NumberTail
//
//  Created by lixun on 2017/3/25.
//  Copyright © 2017年 sunshine. All rights reserved.
//

#import "MainStroe.h"
#import "MainDataPipeline.h"
#import "MainService.h"
#import "Minya.h"

@interface MainStroe ()

@property (nonatomic, strong) MainDataPipeline *mainPipeline;
@property (nonatomic, strong) MainService *mainService;


@end


@implementation MainStroe

/*
- (instancetype)initWithContext:(NSDictionary<NSString *,id> *)context{
    if (self == [super initWithContext:context]) {
       // [self addObservers];
    }return self;
}*/



- (__kindof MIPipeline *)pipeline{
    return self.mainPipeline;
}

- (void)fetchData{
    @weakify(self)
    
    [self.mainService requestWithParameters:nil success:^(id  _Nullable data) {
        @strongify(self)
        self.mainPipeline.mainModels = data;
        self.mainPipeline.isRequestFinish = YES;
    } fail:^(id  _Nullable data, NSError * _Nullable error) {
        self.mainPipeline.isRequestError = YES;
    }];
}

/*
- (void)addObservers{
    @weakify(self)
    [MIObserve(self.mainPipeline, isRequestFinish) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        
    }];
}*/


- (MainDataPipeline *)mainPipeline{
    if (!_mainPipeline) {
        _mainPipeline = [[MainDataPipeline alloc] init];
    }return _mainPipeline;
}

- (MainService *)mainService{
    if (!_mainService) {
        _mainService = [MainService serviceWithName:@"MainService"];
    }return _mainService;
}


@end
