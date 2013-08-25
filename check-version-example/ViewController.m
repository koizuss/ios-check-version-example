//
//  ViewController.m
//  check-version-example
//
//  Created by kiyoshiro on 13/08/25.
//  Copyright (c) 2013年 kiyoshiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=333903271"]
                                            /* Tips:
                                             - サンプルの為idは「twitter」のidを使用
                                             - 公開している国が限られている場合、http://itunes.apple.com/lookup?country=×××&id=◯◯◯
                                             */
                                            
                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                        timeoutInterval:60.0];
                                        // TODO: timeout actions
    NSURLResponse *response;
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                        returningResponse:&response
                                                    error:&error];
    
    NSDictionary *versionSummary  = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
    
    // TODO: error actions
    
    NSDictionary *results = [[versionSummary objectForKey:@"results"] objectAtIndex:0];
    NSString *latestVersion = [results objectForKey:@"version"];
    
    self.lbl_lastVersion.text = [[@"Last Version: " stringByAppendingString:latestVersion] stringByAppendingString:@" (twitter)"];
    
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    self.lbl_currentVersion.text = [[@"Current Version: " stringByAppendingString:currentVersion] stringByAppendingString:@" (this app)"];
    
    if (![currentVersion isEqualToString:latestVersion]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                       message:@"最新バージョンが入手可能です。アップデートしますか？"
                                                      delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"アップデート", nil];
        [alert show];
    }
    
    /* issues:
     - オフラインで使用できない??
        - 起動時に必ずネットワークアクセスが必要になる
        - versionがx.x以上ならチェックしないような処理で回避？？
     - この実装では既にロードしている（メモリ上にある）アプリケーションの表示時にチェックはできない
        - 表示時必ず実行される箇所にチェック処理を移せばOK？？
     - 既存アプリにチェックを追加する場合、そもそも既存アプリをチェック処理追加バージョンにアップデートしなければ意味がない
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        /* TODO: update actions
        NSString *urlString = @"http://itunes.com/apps/アプリ名";
        NSURL *url= [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
         */
    }
}

@end
