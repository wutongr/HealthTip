//
//  WTCoreDataStack.m
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTCoreDataStack.h"

#import "LoginUser.h"
#import "Plan.h"

@interface WTCoreDataStack ()

@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation WTCoreDataStack

+ (instancetype)defaultStack{
    static WTCoreDataStack *stack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [[self alloc]init];
    });
    return stack;
}

+ (instancetype)inMemoryStack{
    static WTCoreDataStack *stack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [[self alloc]init];
        
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[stack managedObjectModel]];
        NSError *error;
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
        stack.persistentStoreCoordinator = persistentStoreCoordinator;
    });
    return stack;
}

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }

}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext!= nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HealthTip" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HealthTip.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)ensureInitialLoad{
    NSString *initialLoadKey = @"Initial Load";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL hasInitialLoad = [userDefaults boolForKey:initialLoadKey];
    if(hasInitialLoad == NO){
        [userDefaults setBool:YES forKey:initialLoadKey];
        {
            LoginUser *userA = [NSEntityDescription insertNewObjectForEntityForName:@"LoginUser" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            userA.uid = @1;
            userA.name = @"张一";
            userA.type = @"学生";
            userA.number = @20150301;
            
            Plan *planA = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            planA.user = userA;
            planA.date = [NSDate date];
            planA.content = @"张一今天去玩";
            
            Plan *planB = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            planB.user = userA;
            planB.date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
            planB.content = @"张一明天去吃";
            
            userA.plans = [NSOrderedSet orderedSetWithArray:@[planA,planB]];
        }
        
        {
            LoginUser *userB = [NSEntityDescription insertNewObjectForEntityForName:@"LoginUser" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            userB.uid = @2;
            userB.name = @"张二";
            userB.type = @"老板";
            userB.number = @20150302;
            
            Plan *planC = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            planC.user = userB;
            planC.date = [NSDate date];
            planC.content = @"张二今天去玩";
            
            Plan *planD = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            planD.user = userB;
            planD.date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
            planD.content = @"张二明天去吃";
            
            userB.plans = [NSOrderedSet orderedSetWithArray:@[planC,planD]];
        }
        
        {
            LoginUser *userC = [NSEntityDescription insertNewObjectForEntityForName:@"LoginUser" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            userC.uid = @3;
            userC.name = @"张三";
            userC.type = @"学生";
            userC.number = @20150303;
            
            Plan *planE = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            planE.user = userC;
            planE.date = [NSDate date];
            planE.content = @"张三今天去玩";
            
            Plan *planF = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:[[WTCoreDataStack defaultStack] managedObjectContext]];
            planF.user = userC;
            planF.date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
            planF.content = @"张三明天去吃";
            
            userC.plans = [NSOrderedSet orderedSetWithArray:@[planE,planF]];
        }
        
        [[WTCoreDataStack defaultStack]saveContext];
    }
}

@end
