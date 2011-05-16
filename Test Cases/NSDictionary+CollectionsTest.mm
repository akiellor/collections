#import <SenTestingKit/SenTestingKit.h>
#import "NSDictionary+Collections.h"

#define HC_SHORTHAND

#import <OCHamcrest/OCHamcrest.h>

@interface NSDictionary_CollectionsTest : SenTestCase
@end

@implementation NSDictionary_CollectionsTest

-(void) test_each_yields_to_block_for_each_key_and_value {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSMutableArray *keys = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
    
    [dict each:^(id key, id value){
        [keys addObject:key];
        [values addObject:value];
    }];
    
    assertThat(keys, containsInAnyOrder(@"key1", @"key2", nil));
    assertThat(values, containsInAnyOrder(@"value1", @"value2", nil));
}

-(void) test_each_key_yields_to_block_for_each_key {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
    NSMutableArray *keys = [NSMutableArray array];
    
    [dict eachKey:^(id key){
        [keys addObject:key];
    }];

    assertThat(keys, containsInAnyOrder(@"key1", @"key2", nil));
}

-(void) test_each_value_yields_to_block_for_each_value {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
    NSMutableArray *values = [NSMutableArray array];
    
    [dict eachValue:^(id value){
        [values addObject:value];
    }];
    
    assertThat(values, containsInAnyOrder(@"value1", @"value2", nil));
}

@end