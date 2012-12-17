//
//  Summly.m
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Summly.h"
#import "SummlyAPIClient.h"
@implementation Summly
@synthesize title,describe,scource,imageUrl,interval,sourceUrl,summlyTime;

-(id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {

        self.title = [attributes objectForKey:@"title"];
        self.describe = [attributes objectForKey:@"content"];
        if (self.scource.length==0) {
            self.scource = @"雅虎通讯";
        }else{
            self.scource = [attributes objectForKey:@"source"];//来源
        }
        self.sourceUrl = [attributes objectForKey:@"url"];
        self.summlyTime =  [self stringDateToNSDate:[attributes objectForKey:@"time"]];
        self.imageUrl = [attributes objectForKey:@"imageUrl"];
        
    }
    
    return self;
}

-(NSDate *)stringDateToNSDate:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:string];

    return date;
}

+(void)getSummlysParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    NSLog(@"%@",parameters);
    [[SummlyAPIClient sharedClient] getPath:@"summly/index" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSMutableArray *summlyArr = [[NSMutableArray alloc] init];
        NSArray *responseArr = (NSArray*)responseObject;
        
        for (int i=0;i<responseArr.count;i++) {
            Summly *summly = [[Summly alloc] initWithAttributes:[responseArr objectAtIndex:i]];
            [summlyArr addObject:summly];
            
        }
        if (block) {
            block(summlyArr);
        }
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
    }];
    
}
@end
