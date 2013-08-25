//
//  ViewController.h
//  check-version-example
//
//  Created by kiyoshiro on 13/08/25.
//  Copyright (c) 2013年 kiyoshiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_titile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_lastVersion;
@property (weak, nonatomic) IBOutlet UILabel *lbl_currentVersion;

@end
