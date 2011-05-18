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

-(NSDictionary *)mapValues:(id (^)(id))block{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [self each:^(id key, id value) {
        [result setObject:block(value) forKey:key];
    }];
    return [NSDictionary dictionaryWithDictionary:result];
}

-(BOOL)hasKeys:(id)first, ...{
    va_list keys;
    if([[self allKeys] indexOfObject:first] == NSNotFound){
        return NO;
    }
    BOOL result = YES;
    id object;
    va_start(keys, first);
    while ((object = va_arg(keys, id)) != nil) {
        result = result && ([[self allKeys] indexOfObject:object] != NSNotFound);
    }
    va_end(keys);
    return result;
}

@end
