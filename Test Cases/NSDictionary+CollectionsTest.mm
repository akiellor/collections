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
               
-(void) test_mapValues_returns_dictionary_with_block_applied_to_values {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"key1", @"2", @"key2", nil];

    NSDictionary *actual = [dict mapValues:^id(id value) { return [@"woot " stringByAppendingString:value]; }];

    assertThat(actual, hasEntries(@"key1", @"woot 1", @"key2", @"woot 2", nil));
}

-(void) test_hasKeys_yields_YES_when_dictionary_has_all_specified_keys {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"key1", @"2", @"key2", @"3", @"key3", nil];
    
    BOOL actual = [dict hasKeys:@"key1", @"key2", nil];
    
    assertThatBool(actual, equalToBool(YES));
}

-(void) test_hasKeys_yields_NO_when_dictionary_does_not_have_all_specified_keys {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"key1", @"2", @"key2", @"3", @"key3", nil];
    
    BOOL actual = [dict hasKeys:@"key1", @"key7", @"bob", @"fred", nil];
    
    assertThatBool(actual, equalToBool(NO));
}


-(void) test_hasKeys_yields_NO_when_dictionary_does_not_have_first_specified_key {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"key1", @"2", @"key2", @"3", @"key3", nil];
    
    BOOL actual = [dict hasKeys:@"key7", nil];
    
    assertThatBool(actual, equalToBool(NO));
}

@end
