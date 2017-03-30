//
//  MainViewController.m
//  NumberTail
//
//  Created by lixun on 2017/3/25.
//  Copyright © 2017年 sunshine. All rights reserved.
//

#import "MainViewController.h"
#import "MainStroe.h"
#import "Minya.h"
#import "MainDataPipeline.h"

@interface MainViewController ()

@property (nonatomic, strong) MainDataPipeline *mainPipeline;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数字尾巴";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.store fetchData];
    
    [self addObservers];
}


- (void)setupPipeline:(__kindof MIPipeline *)pipeline{
    self.mainPipeline = pipeline;
}


- (void)addObservers{
    @weakify(self)
    [MIObserve(self.mainPipeline, isRequestError) changed:^(id  _Nonnull newValue) {
        @strongify(self)
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil message:@"网络错误,请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道啦" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertViewController addAction:action];
        [self presentViewController:alertViewController animated:YES completion:nil];
    }];
}

@end
