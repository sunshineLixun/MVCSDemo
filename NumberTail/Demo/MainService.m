//
//  MainService.m
//  NumberTail
//
//  Created by lixun on 2017/3/25.
//  Copyright © 2017年 sunshine. All rights reserved.
//

#import "MainService.h"
#import <XMNetworking/XMNetworking.h>
#import "MainModel.h"
#import <YYModel/YYModel.h>


@interface MainService ()

@end

@implementation MainService


- (void)requestWithParameters:(NSDictionary *)parameters success:(MIRequestSuccessBlock)success fail:(MIRequestFailBlock)fail{
    [XMCenter sendRequest:^(XMRequest *request) {
        request.url = @"http://api.dgtle.com/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=0_20&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.2.5";
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id responseObject) {
        
        // 伪代码 --> 根据返回状态码 success回传不同的数据
        /*
        if ([responseObject[@"code"] isEqualToString:@"2"]) {
            
        }else{
            
        }*/
        
        
        NSLog(@"onSuccess: %@", responseObject[@"returnData"][@"articlelist"]);
        if ([responseObject[@"returnData"][@"articlelist"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *datas = [NSDictionary yy_modelDictionaryWithClass:[MainModel class] json:responseObject[@"returnData"][@"articlelist"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(datas);
                }
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"onFailure: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (fail) {
                fail(nil,error);
            }
        });
    } onFinished:^(id responseObject, NSError *error) {
        NSLog(@"onFinished");
    }];
}

@end
