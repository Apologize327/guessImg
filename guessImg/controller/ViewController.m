//
//  ViewController.m
//  guessImg
//
//  Created by panxf on 14-10-24.
//  Copyright (c) 2014年 xjf. All rights reserved.
//

#import "ViewController.h"
#import "QuestionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //给controller添加背景图片
    [self setupViewImg];
    
    //添加问题view
    [self setupQuestionView];
    
    //添加备选项区域
    [self setupAnswerPart];
    
}

//设置状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)setupViewImg{
    UIImage *imgbj = [UIImage imageNamed:@"bj"];
    UIImageView *backImgView = [[UIImageView alloc]initWithImage:imgbj];
    backImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:backImgView];
}


-(void)setupQuestionView{
    QuestionView *queView = [[QuestionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //该出的背景色应为clearColor，否则会遮住背景图片
    queView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:queView];
    //NSLog(@"%f,%f",self.view.frame.size.width,self.view.frame.size.height);//768,1024
}

-(void)setupAnswerPart{
//    AnswerView *answerView = [[AnswerView alloc]initWithFrame:CGRectMake(0, 600, self.view.frame.size.width, self.view.frame.size.height)];
//    answerView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:answerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
