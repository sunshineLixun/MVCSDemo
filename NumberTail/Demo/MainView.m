//
//  MainView.m
//  NumberTail
//
//  Created by lixun on 2017/3/25.
//  Copyright © 2017年 sunshine. All rights reserved.
//

#import "MainView.h"
#import "Minya.h"
#import "MainDataPipeline.h"
#import "MainTableViewCell.h"
#import <Masonry/Masonry.h>
#import "MainModel.h"

@interface MainView ()<UITableViewDataSource>

@property (nonatomic, strong) MainDataPipeline *mainPipeline;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <MainModel *>*models;

@end

static NSString * const mainCellID = @"mainCellID";

@implementation MainView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {

        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }return self;
}

- (void)setupPipeline:(__kindof MIPipeline *)pipeline{
    self.mainPipeline = pipeline;
    @weakify(self)
    [MIObserve(self.mainPipeline, isRequestFinish) changed:^(id  _Nonnull newValue) {
        NSLog(@"%@",newValue);
        @strongify(self)
        for (NSString *key in self.mainPipeline.mainModels.allKeys) {
            MainModel *model = self.mainPipeline.mainModels[key];
            [self.models addObject:model];
        }
        [self.tableView reloadData];
    }];
}




- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
    cell.model = self.models[indexPath.row];
    return cell;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.rowHeight = 250;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTableViewCell class]) bundle:nil] forCellReuseIdentifier:mainCellID];
    }return _tableView;
}

- (NSMutableArray <MainModel *>*)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }return _models;
}

@end
