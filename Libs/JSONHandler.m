//
//  JSONHandler.m
//  new_green_box
//
//  Created by Yu on 12/6/14.
//  Copyright (c) 2014 Yu. All rights reserved.
//

#import "JSONHandler.h"

@implementation JSONHandler
+(NSString*)DataToString:(NSData *)data{
    NSString *res=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return res;
}

+(NSData*)StringToData:(NSString *)str{
    NSData *data=[str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    return data;
}

+(NSString *)ObjectToJSON:(id)obj{
    NSData *data=[NSJSONSerialization JSONObjectWithData:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+(NSString*)ConvertDictionaryToQueryString:(NSDictionary *)dic{
    NSMutableArray *container=[[NSMutableArray alloc] init];
    for (id key in dic){
        NSString *tmp=[NSString stringWithFormat:@"%@=%@", key, [dic objectForKey: key]];
        [container addObject:tmp];
    }
    return [container componentsJoinedByString:@"&"];
}

+(NSString *)ConvertBOOLToString:(BOOL)val{
    if(val==YES) return @"YES";
    else return @"NO";
}
@end
