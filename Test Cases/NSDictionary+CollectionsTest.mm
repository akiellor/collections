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
    
    [dict eachValue:^(id value) {
        [values addObject:value];
    }];
    
    assertThat(values, containsInAnyOrder(@"value1", @"value2", nil));
}

-(void) test_filter_returns_a_subdictionary_with_key_or_value_matching_block_condition {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
    NSDictionary *actual = [dict filter:^(id key, id value) {
        return [key isEqual:@"key1"];
    }];
    
    assertThat(actual , hasEntries(@"key1", @"value1", nil));
}

-(void) test_first_returns_a_subdictionary_with_first_matching_entry {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value3", @"key3", nil];
    
    NSDictionary *actual = [dict first:^(id key, id value) {
        return [key isEqual:@"key1"];
    }];
    
    assertThat(actual , hasEntries(@"key1", @"value1", nil));
}

-(void) test_first_returns_an_emtpy_dictionary_when_no_entries_match {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value3", @"key3", nil];
    
    NSDictionary *actual = [dict first:^(id key, id value) { return [key isEqual:@"key7"]; }];
    
    assertThat(actual, is(empty()));
}
               
@end