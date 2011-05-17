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

-(NSDictionary *)filter:(BOOL (^)(id, id))block{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(id key in [self allKeys]){
        if(block(key, [self objectForKey:key])){
            [result setObject:[self objectForKey:key] forKey:key];
        } 
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

-(NSDictionary *)first:(BOOL (^)(id, id))block{
    for(id key in [self allKeys]){
        if(block(key, [self objectForKey:key])){
            NSMutableDictionary *result = [NSMutableDictionary dictionary];
            [result setObject:[self objectForKey:key] forKey:key];
            return [NSDictionary dictionaryWithDictionary:result];
        } 
    }
    return [NSDictionary dictionary];
}
@end
