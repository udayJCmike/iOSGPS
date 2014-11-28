//
//  Passwordchange.m
//  LMSMOOC
//
//  Created by DeemsysInc on 10/09/14.
//  Copyright (c) 2014 deemsys. All rights reserved.
//

#import "Passwordchange.h"





@implementation Passwordchange



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
          NSLog(@"called");
            
            // Initialization code
            popUpView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,394)];
//            popUpView.transform = CGAffineTransformMakeRotation(0);
            [popUpView setBackgroundColor:[UIColor whiteColor]];
            
            
      
            
            
            CGRect closeButtonFrame=CGRectMake(95, 197, 187, 29);
         close=[[UIButton alloc]initWithFrame:closeButtonFrame];
          //  close.style=4;
            [close.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
            [close.titleLabel setTextColor:[UIColor whiteColor]];
            [close setTitle:@"Close" forState:UIControlStateNormal];
            [close addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
            [close setBackgroundColor:[UIColor colorWithRed:127/256.0 green:127/256.0 blue:127/256.0 alpha:1.0]];
            [close setTintColor:[UIColor whiteColor]];
            [close.layer setCornerRadius:5.0f];
            
            
            
  
       
       
        
        
        
        
       
        
     
     
     
        
        [UIView beginAnimations:@"curlup" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:popUpView cache:YES];
        [self addSubview:popUpView];
        [UIView commitAnimations];
        [self addSubview:close];
        [ self setUserInteractionEnabled: TRUE];
        UIColor *color = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        self.backgroundColor = color;
        UIWindow *w=[[[UIApplication sharedApplication] delegate] window];
        if (w) {
            NSLog(@"window istrue");
              [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        }
      
        
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
      NSLog(@"Yeah !, i found it ");
    CGPoint location = [[touches anyObject] locationInView:self];
    CGRect fingerRect = CGRectMake(location.x-5, location.y-5, 10, 10);
    
    for(UIView *view in self.subviews){
        CGRect subviewFrame = view.frame;
        
        if(CGRectIntersectsRect(fingerRect, subviewFrame)){
            //we found the finally touched view
            NSLog(@"Yeah !, i found it %@",view);
        }
        
    }
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"eater touched");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
      NSLog(@"eater touched");
}


-(void)closeView:(id)sender
{
    [self removeFromSuperview];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
     NSLog(@"called superview... removed");
}
- (void)willRemoveSubview:(UIView *)subview {
    NSLog(@"called... removed");
}
@end
