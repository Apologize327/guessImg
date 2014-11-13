//
//  AnswerView.m
//  guessImg(猜图)
//
//  Created by panxf on 14-10-28.
//  Copyright (c) 2014年 xjf. All rights reserved.
//

#import "AnswerView.h"
#import "QuestionModel.h"
#import "QuestionView.h"

@interface AnswerView()


/** 正确答案区 */
@property(nonatomic,strong) UIView *answerView;
/** 备选答案区 */
@property(nonatomic,strong) UIView *optionsView;

@end

@implementation AnswerView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}


/** 增加正确答案 */
-(void)addRightAnswer:(QuestionModel *) queModel{
    //添加新按钮前先删除之前的所有按钮
    for (UIView *btnView in self.answerView.subviews) {
        [btnView removeFromSuperview];
    }
    
    //添加新的答案按钮
    int answerLength = queModel.queAnswer.length;
    for (int i=0; i<answerLength; i++) {
        UIButton *answerBtn = [[UIButton alloc]init];
        
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        
        //设置view的位置
        CGFloat viewW = self.frame.size.width;
        //设置按钮之间的间距
        CGFloat margin = 30;
        //设置按钮的大小
        CGFloat answerBtnW = 60;
        CGFloat answerBtnH = 60;
        //设置answer两侧区域宽度
        CGFloat fieldW = (viewW - answerBtnW * answerLength - (answerLength - 1) * margin)/2;
        //按钮的x坐标
        CGFloat answerBtnX = fieldW + (answerBtnW + margin) * i;
        answerBtn.frame = CGRectMake(answerBtnX, 20, answerBtnW, answerBtnH);
        
        [self.answerView addSubview:answerBtn];
        
        [answerBtn addTarget:self action:@selector(judgeAnswer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self addSubview:self.answerView];
    
}

/** 添加待选答案 */
-(void)addAnswerOption:(QuestionModel *) queModel{
    //添加新的之前先删除旧的
    for (UIView *optionBtn in self.optionsView.subviews) {
        [optionBtn removeFromSuperview];
    }
    
    //添加新的备选按钮
    int optionLengtn = queModel.queSelect.count;
    for (int i=0; i<optionLengtn; i++) {
        UIButton *optionBtn = [[UIButton alloc]init];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        
        //设置frame
        CGFloat optionBtnW = 50;
        CGFloat optionBtnH = 50;
        int marginBetweenBtnsInRow = 20;//按钮行之间的距离
        int marginBetweenBtnsInCol = 30;//按钮列之间的距离
        int btnNumInRow = 7; //每行出现的按钮数
        int marginSide = 10; //两侧边距
        int rowIndex = i / btnNumInRow;
        int colIndex = i % btnNumInRow;
        CGFloat optionBtnX = marginSide + (optionBtnW + marginBetweenBtnsInRow) * colIndex;
        CGFloat optionBtnY = 30 + (optionBtnH + marginBetweenBtnsInCol) * rowIndex;
        
        optionBtn.frame = CGRectMake(optionBtnX, optionBtnY, optionBtnW, optionBtnH);
        
        //设置按钮文字
        [optionBtn setTitle:queModel.queSelect[i] forState:UIControlStateNormal];
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.optionsView addSubview:optionBtn];
        
        [optionBtn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:self.optionsView];
}

/** 判断答案是否正确 */
-(void)judgeAnswer:(UIButton *)btn{
    //答案按钮上的文字
    NSString *answerText = [btn titleForState:UIControlStateNormal];
    
    //让答案按钮文字对应的待选按钮显示出来
    for (UIButton *optionBtn in self.optionsView.subviews) {
        NSString *optionTitle = [optionBtn titleForState:UIControlStateNormal];
        if([optionTitle isEqualToString:answerText]){
            optionBtn.hidden = NO;
            break;
        }
    }
    
    //让被点击答案的文字消失,而不是按钮
    [btn setTitle:nil forState:UIControlStateNormal];
    
    //把所有的答案文字颜色改为黑色
    for (UIButton *answerBtn in self.answerView.subviews) {
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

/** 监听答案待选区按钮 */
-(void)optionClick:(UIButton *)optionBtn{
    //被点击的按钮消失
    optionBtn.hidden = YES;
    
    NSString *optionBtnLabel = [optionBtn titleForState:UIControlStateNormal];
    //显示文字到正确答案上
    for (UIButton *answerBtn in self.answerView.subviews) {
        NSString *answerBtnTitle = [answerBtn titleForState:UIControlStateNormal];
        if (answerBtnTitle.length == 0) {
            [answerBtn setTitle:optionBtnLabel forState:UIControlStateNormal];
            break; //停止遍历
        }
    }
    
    //检测答案是否填满
    BOOL full = YES;
    NSMutableString *tempAnswerTitle = [NSMutableString string];
    for (UIButton *answerBtn in self.answerView.subviews) {
        NSString *answerBtnTitle = [answerBtn titleForState:UIControlStateNormal];
        
        //通过是否有文字来判断是否填满，没文字==没填满
        if (answerBtnTitle.length == 0) {
            full = NO;
        }
        
        //拼接答案
        if (answerBtnTitle) {
            [tempAnswerTitle appendString:answerBtnTitle];
        }
        
    }
    
    //如果答案满了
    if (full) {
        //QuestionModel *queModel = QuestionView.queAll;
        
    }
    
    
}

@end
