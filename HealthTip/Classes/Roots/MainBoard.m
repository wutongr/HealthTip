//
//  MainBoard.m
//  HealthTip
//
//  Created by Yorke on 14/12/8.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "MainBoard.h"
#import "WTCircleLayer.h"

@interface MainBoard (){
    WTCircleLayer *_layer;
}

@end

@implementation MainBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    WTCircleLayer *layer = [WTCircleLayer layer];
    
    layer.position=CGPointMake(100, 100);
    
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
    _layer = layer;
    
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *anima=[CABasicAnimation animation];
    
     //1.1告诉系统要执行什么样的动画
    anima.keyPath=@"position";
     //设置通过动画，将layer从哪儿移动到哪儿
//     anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    int x = arc4random() % 5 + 1;
    int y = arc4random() % 5 + 1;
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(50 * x, 50 * y)];

     //1.2设置动画执行完毕之后不删除动画
     anima.removedOnCompletion=NO;
     //1.3设置保存动画的最新状态
     anima.fillMode=kCAFillModeForwards;

     [_layer addAnimation:anima forKey:nil];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
