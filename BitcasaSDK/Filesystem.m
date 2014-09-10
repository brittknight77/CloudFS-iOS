//
//  Filesystem.m
//  BitcasaSDK
//
//  Created by Olga on 8/21/14.
//  Copyright (c) 2014 Bitcasa. All rights reserved.
//

#import "Filesystem.h"
#import "Container.h"
#import "Item.h"
#import "BitcasaAPI.h"

@implementation Filesystem

#pragma mark - list
- (void)listItemsInContainer:(Container*)container completion:(void (^)(NSArray* items))completion
{
    [self listItemsAtPath:container.url completion:completion];
}

- (void)listItemsAtPath:(NSString*)path completion:(void (^)(NSArray* items))completion
{
    [BitcasaAPI getContentsOfDirectory:path completion:^(NSArray* response)
     {
         NSMutableArray* itemArray = [NSMutableArray array];
         for (NSDictionary* itemDict in response)
         {
             Item* item = [[Item alloc] initWithDictionary:itemDict];
             [itemArray addObject:item];
         }
         completion(itemArray);
     }];
}

#pragma mark - delete
- (void)deleteItems:(NSArray*)items completion:(void (^)(NSArray* successArray))completion
{
    [BitcasaAPI deleteItems:items completion:completion];
}

#pragma mark - move
- (void)moveItems:(NSArray*)items toContainer:(Container*)destinationContainer completion:(void (^)(NSArray* successArray))completion
{
    [BitcasaAPI moveItems:items to:destinationContainer completion:completion];
}

- (void)moveItems:(NSArray*)items toPath:(NSString*)destinationPath completion:(void (^)(NSArray* successArray))completion
{
    [BitcasaAPI moveItems:items to:destinationPath completion:completion];
}

@end
