//
//  QuestionModel.m
//  guessImg(猜图)
//
//  Created by panxf on 14-10-24.
//  Copyright (c) 2014年 xjf. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        self.queAnswer = dict[@"answer"];
        self.queImg = dict[@"icon"];
        self.queDetail = dict[@"title"];
        self.queSelect = dict[@"options"];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict{
    QuestionModel *queModel = [[QuestionModel alloc]initWithDict:dict];
    return queModel;
}

@end
