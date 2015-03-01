//
//  MainViewModel.m
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "MainViewModel.h"
#import "LoginUser.h"

@interface MainViewModel ()<NSFetchedResultsControllerDelegate>

@end

@implementation MainViewModel

- (instancetype)init{
    if(self = [super init]){

    }
    return self;
}

-(NSInteger)numberOfSections{
    return [[self.fetchedResultsController sections]count];
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

-(NSString *)titleForSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSArray *sectionObjects = [sectionInfo objects];
    LoginUser *representativeObject = [sectionObjects firstObject];

    return representativeObject.type;
}

-(NSString *)titleAtIndexPath:(NSIndexPath *)indexPath{
    LoginUser *user = [self userAtIndexPath:indexPath];
    return [user valueForKey:@keypath(user,name)];
}

-(NSString *)subtitleAtIndexPath:(NSIndexPath *)indexPath{
    LoginUser *user = [self userAtIndexPath:indexPath];
    return [user valueForKey:@keypath(user,number)];
}

-(LoginUser *)userAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSFetchedResultsController *)fetchedResultsController{
    if(!_fetchedResultsController){
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"LoginUser" inManagedObjectContext:[WTCoreDataStack defaultStack].managedObjectContext];
        [fetchRequest setEntity:entity];
        // Specify criteria for filtering which objects to fetch
        NSNumber *uid = @10;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid < %d", uid];
        [fetchRequest setPredicate:predicate];
        // Specify how the fetched objects should be sorted
//        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid"
//                                                                       ascending:YES];
        [fetchRequest setSortDescriptors:
         [NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES],
                                   [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:YES],nil]];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[WTCoreDataStack defaultStack].managedObjectContext sectionNameKeyPath:@"type" cacheName:@"Master"];
        _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
}

@end
