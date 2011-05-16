#import "NSDictionary+Collections.h"

@implementation NSDictionary (NSDictionary_Collections)

-(void)each:(void(^)(id key, id value))block{
    for(id key in [self allKeys]){
        block(key, [self objectForKey:key]); 
    }
}

-(void)eachKey:(void (^)(id))block{
    for(id key in [self allKeys]){
        block(key); 
    }
}

-(void)eachValue:(void (^)(id))block{
    for(id key in [self allKeys]){
        block([self objectForKey:key]); 
    }
}

@end
