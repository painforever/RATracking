
//
//  Post.m
//  new_green_box
//
//  Created by Yu on 12/4/14.
//  Copyright (c) 2014 Yu. All rights reserved.
//

#import "Post.h"

@implementation Post
+(NSString*)postRequest:(NSString *)url withParams:(NSString *)params{
    
    NSData *data=[params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL: [NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+(void)postAsyncRequest:(NSString *)url withParams :(NSString *)params{
    //http://stackoverflow.com/questions/19229491/ios7-nsurlconnection-sendasynchronousrequest-failed-with-post-data
    NSData *data=[params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL: [NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [[NSData alloc] init];
    //NSDictionary *res_dic=[[NSDictionary alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        NSLog(@"async request status code: %d", responseCode);
    }];
    //return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}
@end
