#import <SenTestingKit/SenTestingKit.h>
#import "Collections.h"

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

-(void) test_filter_by_key_returns_a_subdictionary_with_keys_matching_block_condition {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
    NSDictionary *actual = [dict filterByKey:^(id key) {
        return [key isEqual:@"key1"];
    }];
    
    assertThat(actual , hasEntries(@"key1", @"value1", nil));
}

-(void) test_filter_by_value_returns_a_subdictionary_with_values_matching_block_condition {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
    NSDictionary *actual = [dict filterByValue:^(id value) {
        return [value isEqual:@"value2"];
    }];
    
    assertThat(actual , hasEntries(@"key2", @"value2", nil));
}
@end