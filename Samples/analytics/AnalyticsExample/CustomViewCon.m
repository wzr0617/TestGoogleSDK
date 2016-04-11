//
//  CustomViewCon.m
//  AnalyticsExample
//
//  Created by wzr on 2016/04/11.
//  Copyright © 2016年 Google Inc. All rights reserved.
//

#import "CustomViewCon.h"
#import <Google/Analytics.h>

@interface CustomViewCon ()
{
    NSArray *titleList1;
    NSArray *titleList2;
    NSArray *titleList;
}
@end

@implementation CustomViewCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test Analytics SDK";
    titleList1 = @[@"view Screen A",@"view Screen B"];
    titleList2 = @[@"Select cell Action A",@"Select cell Action B trigger crash becasue crash"];
    titleList =@[titleList1,titleList2];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleStr = @"";
    switch (section) {
        case 0:
            titleStr = @"View";
            break;
        case 1:
            titleStr = @"Action";
            break;
        default:
            break;
    }
    return titleStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * showUserInfoCellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:showUserInfoCellIdentifier];
    }
    cell.textLabel.text = [[titleList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
-(void)buildLog
{
    
    
    //
    // [START custom_event_objc]
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:@"Action"
                                            action:@"Share"
                                             label:nil
                                             value:nil] build];
    [tracker send:event];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:{
                id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
                [tracker set:kGAIScreenName value:titleList1[0]];
                [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
            }
                break;
            case 1:{
                id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
                [tracker set:kGAIScreenName value:titleList1[1]];
                [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
            }
                
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:{
                id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
                NSMutableDictionary *event =
                [[GAIDictionaryBuilder createEventWithCategory:@"Action"
                                                        action:titleList2[0]
                                                         label:@"Lablexxx"
                                                         value:@1] build];
                [tracker send:event];
            }
                break;
            case 1:{
                id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
                NSMutableDictionary *event =
                [[GAIDictionaryBuilder createEventWithCategory:@"Action"
                                                        action:titleList2[1]
                                                         label:@"array over"
                                                         value:@100] build];
                [tracker send:event];
                NSArray *array = [NSArray arrayWithObjects:@"",@"",@"", nil];
                [array objectAtIndex:100];
            }
                break;
                
            default:
                break;
        }
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
