//
//  QuestionModel.h
//  guessImg(猜图)
//
//  Created by panxf on 14-10-24.
//  Copyright (c) 2014年 xjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject
/** 问题答案 */
@property(nonatomic,copy) NSString *queAnswer;
/** 问题图片 */
@property(nonatomic,copy) NSString *queImg;
/** 问题描述 */
@property(nonatomic,copy) NSString *queDetail;
/** 备选项 */
@property(nonatomic,strong) NSArray *queSelect;


-(instancetype) initWithDict:(NSDictionary *)dict;

+(instancetype) modelWithDict:(NSDictionary *)dict;

@end
