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
