//
//  QuestionView.m
//  guessImg(猜图)
//
//  Created by panxf on 14-10-24.
//  Copyright (c) 2014年 xjf. All rights reserved.
//

#import "QuestionView.h"
#import "QuestionModel.h"

@interface QuestionView()

/** 问题序号 */
@property(nonatomic,strong) UILabel *queSeqLabel; //xib中用weak
/** 问题描述 */
@property(nonatomic,strong) UILabel *queDetailLabel;
/** 分数统计 */
@property(nonatomic,strong) UIButton *scoreBtn;
/** 问题的图片 */
@property(nonatomic,strong) UIImageView *queImage;
/** 提示按钮 */
@property(nonatomic,strong) UIButton *tipsBtn;
/** 帮助按钮 */
@property(nonatomic,strong) UIButton *helpBtn;
/** 图片放大按钮 */
@property(nonatomic,strong) UIButton *enlargeBtn;
/** 下一题 */
@property(nonatomic,strong) UIButton *nextBtn;

/** 遮罩，通过遮罩来判断图片是否放大 */
@property(nonatomic,strong) UIButton *cover;

/** 所有题目 */
@property(nonatomic,strong) NSArray *queAll;

/** 当前题目序号 */
@property(nonatomic,assign) int queIndex;


/** 正确答案区 */
@property(nonatomic,strong) UIView *answerView;
/** 备选答案区 */
@property(nonatomic,strong) UIView *optionsView;

@end

@implementation QuestionView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self decorRootView];
        
        self.queIndex = 0; //这一行代码等价于下边两行
        
        /** 若想加载queNext方法，只需令queIndex=-1即可 */
        //self.queIndex = -1;
        //[self queNext];
    }
    return self;
}


-(void)decorRootView{
    //添加问题序号
    _queSeqLabel = [[UILabel alloc]init];
    _queSeqLabel.text = @"1/10";
    _queSeqLabel.frame = CGRectMake(350, 20, 80, 120);
    _queSeqLabel.textAlignment = NSTextAlignmentCenter;
    _queSeqLabel.font = [UIFont systemFontOfSize:30];
    _queSeqLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.queSeqLabel];
    
    //添加计分器
    _scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scoreBtn setTitle:@"1000" forState:UIControlStateNormal];
    _scoreBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [_scoreBtn setImage:[UIImage imageNamed:@"coin"] forState:UIControlStateNormal];
    _scoreBtn.frame = CGRectMake(600, 20, 160, 100);
    _scoreBtn.userInteractionEnabled = NO;//点击按钮后不出现效果
    [self addSubview:self.scoreBtn];
    
    //添加问题描述
    _queDetailLabel = [[UILabel alloc]init];
    _queDetailLabel.text = @"恶搞风格的喜剧大片";
    _queDetailLabel.frame = CGRectMake(200, 80, 350, 100);
    _queDetailLabel.textAlignment = NSTextAlignmentCenter;
    _queDetailLabel.font = [UIFont systemFontOfSize:30];
    _queDetailLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.queDetailLabel];
    
    //添加图片，有白色边框
    _queImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie_ygbh"]];
    _queImage.frame = CGRectMake(250, 200, 300, 300);
    /** 给图片添加边框 */
    CALayer *boderLayer = [self.queImage layer];
    boderLayer.borderColor = [[UIColor whiteColor] CGColor];
    boderLayer.borderWidth = 5;
    /** 对图片添加事件 */
    self.queImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClick:)];
    [self.queImage addGestureRecognizer:singTap];
    [self addSubview:self.queImage];
    
    CGFloat viewWidth = self.frame.size.width;
    CGFloat imgWidth = self.queImage.frame.size.width;
    
    //添加提示按钮
    _tipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tipsBtn setBackgroundImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    [_tipsBtn setBackgroundImage:[UIImage imageNamed:@"btn_left_highlighted"] forState:UIControlStateHighlighted];
    [_tipsBtn setImage:[UIImage imageNamed:@"icon_tip"] forState:UIControlStateNormal];
    [_tipsBtn setTitle:@"提示" forState:UIControlStateNormal];
    _tipsBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _tipsBtn.frame = CGRectMake(0, 220, (viewWidth - imgWidth)/2 - 40, 100);
    [self.tipsBtn addTarget:self action:@selector(queTip:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_tipsBtn];
    
    //添加帮助按钮
    _helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_helpBtn setBackgroundImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    [_helpBtn setBackgroundImage:[UIImage imageNamed:@"btn_left_highlighted"] forState:UIControlStateHighlighted];
    [_helpBtn setImage:[UIImage imageNamed:@"icon_help"] forState:UIControlStateNormal];
    [_helpBtn setTitle:@"帮助" forState:UIControlStateNormal];
    _helpBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _helpBtn.frame = CGRectMake(0, 380, (viewWidth - imgWidth)/2 - 40, 100);
    [self.helpBtn addTarget:self action:@selector(queHelp:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_helpBtn];
    
    //添加大图按钮
    _enlargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_enlargeBtn setBackgroundImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
    [_enlargeBtn setBackgroundImage:[UIImage imageNamed:@"btn_right_highlighted"] forState:UIControlStateHighlighted];
    [_enlargeBtn setImage:[UIImage imageNamed:@"icon_img"] forState:UIControlStateNormal];
    [_enlargeBtn setTitle:@"大图" forState:UIControlStateNormal];
    _enlargeBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _enlargeBtn.frame = CGRectMake(600, 220, (viewWidth - imgWidth)/2 - 40, 100);
    [self.enlargeBtn addTarget:self action:@selector(imgClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_enlargeBtn];
    
    //下一题
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"btn_right_highlighted"] forState:UIControlStateHighlighted];
    [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _nextBtn.frame = CGRectMake(600, 380, (viewWidth - imgWidth)/2 - 40, 100);
    [self.nextBtn addTarget:self action:@selector(queNext) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextBtn];
    
    
    //设置正确答案区位置
    _answerView = [[UIView alloc]init];
    _answerView.frame = CGRectMake(0, 510, self.frame.size.width, 100);
    //_answerView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.answerView];
    
    //设置备选答案区位置
    _optionsView = [[UIView alloc]init];
    _optionsView.frame = CGRectMake(0, 610, self.frame.size.width, 400);
    //_optionsView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.optionsView];
    
    //添加正确答案和备选答案去
    QuestionModel *queModel = self.queAll[self.queIndex];
    
    [self addRightAnswer:queModel];
    
    [self addOptionAnswer:queModel];
    
}

//问题提示
-(void)queTip:(UIButton *)btn{
    
}

//帮助
-(void)queHelp:(UIButton *)btn{
    
}

//大图
-(void)imgClick:(UIButton *)btn{
    //NSLog(@"图片被点击");
    if (self.cover==nil) { //没有遮罩，要放大
        [self imgEnlarge];
    } else {               //有遮罩，要缩小
        [self imgSmall];
    }
}

//图片放大
-(void)imgEnlarge{
    //添加阴影，此处的cover不是view中定义的cover
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = self.frame;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(imgSmall) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cover];
    
    self.cover = cover;//对view自带的cover赋值，删除该行后点击放大后的图片，阴影会越来越黑
    //改变阴影和图片的位置
    [self bringSubviewToFront:self.queImage];
    
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        //阴影慢慢显示
        cover.alpha = 0.7;
        
        //图片慢慢放大，放在屏幕中间
        CGFloat queImgBigW = self.frame.size.width;
        CGFloat queImgBigH = queImgBigW;
        CGFloat queImgBigY = (self.frame.size.height - queImgBigH)* 0.5;
        self.queImage.frame = CGRectMake(0, queImgBigY, queImgBigW, queImgBigH);
    }];
    
}

//图片缩小
-(void)imgSmall{
    //直接执行动画
    [UIView animateWithDuration:0.25 animations:^{
        //图像变回原来的位置
        self.queImage.frame = CGRectMake(250, 200, 300, 300);
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        //动画执行完毕后，移除遮罩(从内存中移除)
        [self.cover removeFromSuperview];
        self.cover = nil;//click时会判断cover是否为nil
    }];
}

//下一题
-(void)queNext{
    //防止最后一题答对时程序由于数组越界崩溃
    int queNum = (int)self.queAll.count;
    if (self.queIndex == queNum - 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"已到最后一题"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    self.queIndex++;
    
    QuestionModel *queModel = self.queAll[self.queIndex];
    
    //改变序号
    self.queSeqLabel.text = [NSString stringWithFormat:@"%d/%d",self.queIndex+1,self.queAll.count];
    //改变问题描述
    self.queDetailLabel.text = queModel.queDetail;
    //改变图片
    [self.queImage setImage:[UIImage imageNamed:queModel.queImg]];
    
    //设置下一题按钮的状态
    self.nextBtn.enabled = (self.queIndex != (self.queAll.count -1));
    
    //重置答案和备选区
    [self addRightAnswer:queModel];
    [self addOptionAnswer:queModel];
}

//初始化所有问题内容
-(NSArray *)queAll{
    if (!_queAll) {
        NSString *quePath = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:quePath];
        
        //字典转模型
        NSMutableArray *queArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            QuestionModel *queModel = [[QuestionModel alloc]initWithDict:dict];
            [queArray addObject:queModel];
        }
        _queAll = queArray;
    }
    return _queAll;
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
        CGFloat answerBtnW = 70;
        CGFloat answerBtnH = 70;
        //设置answer两侧区域宽度
        CGFloat fieldW = (viewW - answerBtnW * answerLength - (answerLength - 1) * margin)/2;
        //按钮的x坐标
        CGFloat answerBtnX = 20 + fieldW + (answerBtnW + margin) * i;
        answerBtn.frame = CGRectMake(answerBtnX, 20, answerBtnW, answerBtnH);
        
        [self.answerView addSubview:answerBtn];
        
        [answerBtn addTarget:self action:@selector(judgeAnswer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

/** 添加待选答案 */
-(void)addOptionAnswer:(QuestionModel *) queModel{
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
        CGFloat optionBtnW = 60;
        CGFloat optionBtnH = 60;
        int marginBetweenBtnsInRow = 30;//按钮行之间的距离
        int marginBetweenBtnsInCol = 30;//按钮列之间的距离
        int btnNumInRow = 7; //每行出现的按钮数
        int viewW = self.frame.size.width;
        int marginSide = (viewW - optionBtnW * btnNumInRow - (btnNumInRow - 1)*marginBetweenBtnsInRow) * 0.5; //两侧边距
        int rowIndex = i / btnNumInRow;
        int colIndex = i % btnNumInRow;
        CGFloat optionBtnX = marginSide + (optionBtnW + marginBetweenBtnsInRow) * colIndex;
        CGFloat optionBtnY = 60 + (optionBtnH + marginBetweenBtnsInCol) * rowIndex;
        
        optionBtn.frame = CGRectMake(optionBtnX, optionBtnY, optionBtnW, optionBtnH);
        
        //设置按钮文字
        [optionBtn setTitle:queModel.queSelect[i] forState:UIControlStateNormal];
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.optionsView addSubview:optionBtn];
        
        [optionBtn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

/** 判断答案是否正确 */
-(void)judgeAnswer:(UIButton *)btn{
    //答案按钮上的文字
    NSString *answerText = [btn titleForState:UIControlStateNormal];
    
    //让答案按钮文字对应的待选按钮显示出来
    for (UIButton *optionBtn in self.optionsView.subviews) {
        NSString *optionTitle = [optionBtn titleForState:UIControlStateNormal];
        if([optionTitle isEqualToString:answerText] && optionBtn.hidden==YES){
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
    int answerNum = self.answerView.subviews.count;
    UIButton *lastBtn = self.answerView.subviews[answerNum-1];
    NSString *lastBtnLabel = [lastBtn titleForState:UIControlStateNormal];
    if (lastBtnLabel.length==0) {
        optionBtn.hidden = YES;
    }
    
    
    QuestionModel *queModel = self.queAll[self.queIndex];
    
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
        //如果答对了，文字显示蓝色
        if ([tempAnswerTitle isEqualToString:queModel.queAnswer]) {
            for (UIButton *answerBtn in self.answerView.subviews) {
                [answerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
            
            //加分
            int score = [self.scoreBtn titleForState:UIControlStateNormal].intValue;
            score += 100;
            [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d",score]  forState:UIControlStateNormal];
            
            //0.5秒后跳到下一题
            [self performSelector:@selector(queNext) withObject:nil afterDelay:0.5];
            
        } else { //打错了，文字显示红色
            for (UIButton *answerBtn in self.answerView.subviews) {
                [answerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
            }
        }
        
    }
    
}


@end
