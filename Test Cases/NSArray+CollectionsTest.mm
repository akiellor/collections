#import <SenTestingKit/SenTestingKit.h>
#import "NSArray+Collections.h"

#define HC_SHORTHAND

#import <OCHamcrest/OCHamcrest.h>

@interface NSArray_CollectionsTest : SenTestCase
@end

@implementation NSArray_CollectionsTest

- (void) test_that_each_returns_the_original_array {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array each:^(id item) { }];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) test_that_each_yields_to_block_for_each_item {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	NSMutableArray *actual = [NSMutableArray array];
	
	[array each:^(id item) {
		[actual addObject:item];
	}];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) test_that_map_applies_block_to_each_value {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array map:^(id item) {
		return [NSString stringWithFormat:@"WOOT %@", item];
	}];
	
    assertThat(actual, contains(@"WOOT 1", @"WOOT 2", @"WOOT 3", @"WOOT 4", @"WOOT 5", nil));
}

- (void) test_that_select_returns_an_element_matching_block_condition {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array select:^(id item) {
		return (BOOL)(item == @"1");
	}];
	
    assertThat(actual, contains(@"1", nil));
}

- (void) test_that_filter_returns_an_element_matching_block_condition {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array filter:^(id item) {
		return [item isEqual:@"1"];
	}];
	
    assertThat(actual, contains(@"1", nil));
}

- (void) test_that_sort_returns_sorted_array {
    NSArray *array = [NSArray arrayWithObjects:@"4", @"2", @"3", @"1", @"5", nil ];
	
	NSArray *actual = [array sort:^(id obj1, id obj2) {
        return [obj1 localizedCaseInsensitiveCompare:obj2];		
	}];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) test_that_first_returns_zeroth_element {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	id actual = [array first];
	
    assertThat(actual, is(@"1"));
}

- (void) test_last_returns_last_element {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	id actual = [array last];
	
    assertThat(actual, is(@"5"));
}

- (void) test_join_concatenates_array_elements {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array join];
	
    assertThat(actual, is(@"12345"));
}

- (void) test_join_concatenates_elements_using_separator {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array join:@","];
	
    assertThat(actual, is(@"1,2,3,4,5"));
}

- (void) test_take_yields_first_n_elements {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array take:2];
	
    assertThat(actual, contains(@"1", @"2", nil));
}

- (void) test_take_zero_yields_empty_array {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array take:0];
	
    assertThat(actual, is(empty()));
}

- (void) test_take_length_yields_identical_array {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array take:5];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) test_step_n_yields_tail_from_element_n {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array step:2];
	
    assertThat(actual, contains(@"3", @"4", @"5", 
								nil));
}

- (void) test_step_zero_yields_identical_array {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array step:0];
	
    assertThat(actual, contains(@"1", @"2", @"3", @"4", @"5", nil));
}

- (void) test_step_length_yields_empty_array {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [array step:5];
	
    assertThat(actual, is(empty()));
}

- (void) test_step1_take2_yields_2nd_and_3rd_elements {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSArray *actual = [[array step:1] take:2];
	
    assertThat(actual, contains(@"2", @"3", nil));
}

- (void) test_all_yields_yes_when_all_values_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array all:^(id object) { return YES; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) test_all_yields_no_when_not_all_values_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array all:^(id object) { return [object isEqual:@"1"]; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) test_all_yields_no_when_no_values_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array all:^(id object) { return NO; }];
	
    assertThatBool(actual, equalToBool(NO));
}


- (void) test_none_yields_no_when_all_elements_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array none:^(id object) { return YES; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) test_none_yields_no_when_some_elements_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array none:^(id object) { return [object isEqual:@"1"]; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) test_none_yields_yes_when_no_elements_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array none:^(id object) { return NO; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) test_any_yields_yes_when_all_elements_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array any:^(id object) { return YES; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) test_any_yields_yes_when_some_elements_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array any:^(id object) { return [object isEqual:@"1"]; }];
	
    assertThatBool(actual, equalToBool(YES));
}

- (void) test_any_yields_no_when_no_elements_match_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	BOOL actual = [array any:^(id object) { return NO; }];
	
    assertThatBool(actual, equalToBool(NO));
}

- (void) test_reduce_aggregates_result_from_each_consecutive_pair_of_elements {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array reduce:^(id result, id item) {
		return [NSString stringWithFormat:@"%@%@", result, item];
	} initial:@""];
	
	assertThat(actual, is(@"12345"));
}

- (void) test_detect_yields_first_element_matching_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array detect:^(id item) {
		return [item isEqual:@"2"];
	}];
	
	assertThat(actual, is(@"2"));
}

- (void) test_first_yields_first_element_matching_block {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil ];
	
	NSString *actual = [array first:^(id item) {
		return [item isEqual:@"2"];
	}];
	
	assertThat(actual, is(@"2"));
}

- (void) test_partition_by_oddness_yields_dictionary_with_odd_and_even_keys {
    NSArray *array = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                               [NSNumber numberWithInt:2],
                                               [NSNumber numberWithInt:3],
                                               [NSNumber numberWithInt:4], nil ];
	
	NSDictionary *actual = [array partition:(id)^(id item) {
        if([item intValue] % 2 == 0){
            return @"even";
        } else {
            return @"odd";
        }
	}];
	
	assertThat([actual valueForKey:@"even"], contains([NSNumber numberWithInt:2], [NSNumber numberWithInt:4], nil));
	assertThat([actual valueForKey:@"odd"], contains([NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil));
}
@end
