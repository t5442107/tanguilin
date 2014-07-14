//
//  SoViewController.m
//  tanguilin
//
//  Created by yangyuji on 14-3-16.
//  Copyright (c) 2014年 com.tanguilin. All rights reserved.
//

#import "SoViewController.h"

#import "JSONHTTPClient.h"
#import <sqlite3.h>
#import "DB.h"

#define CreateSql @"CREATE TABLE 'ksb_recipes_so' (\"rid\" integer NOT NULL PRIMARY KEY AUTOINCREMENT,\"title\" text(50,0) NOT NULL)"
#define CreateSql1 @"CREATE UNIQUE INDEX \"ksb_recipes_so\".\"rid\" ON \"ksb_recipes_so\" (\"rid\")"
#define ksb_recipes_so @"ksb_recipes_so"

@implementation SoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _data = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    titleView.tag = 100;
    titleView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:titleView];
    [titleView release];
    
    _soText = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 320 - 130, 44 - 10 - 10)];
    _soText.backgroundColor  = [UIColor whiteColor];
    _soText.layer.masksToBounds = YES;
    _soText.layer.cornerRadius = 6.0;
    _soText.delegate = self;
    [titleView addSubview:_soText];
    
    UIButton *cansoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cansoButton.frame = CGRectMake( 5, 10, 50, 44-10-10);
    [cansoButton setTitle:@"取消" forState:UIControlStateNormal];
    [cansoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cansoButton addTarget:self action:@selector(cansoAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cansoButton];
    
    UIButton *soButton = [UIButton buttonWithType:UIButtonTypeCustom];
    soButton.frame = CGRectMake( _soText.right + 10, 10, 50, 44-10-10);
    [soButton setTitle:@"搜索" forState:UIControlStateNormal];
    [soButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [soButton addTarget:self action:@selector(soAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:soButton];
    
    [DB creatTable:@"ksb_recipes_so" createSql:CreateSql]; //创建表
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, titleView.bottom, ScreenWidth, 300) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.hidden = YES;
    [self.view addSubview:_tableView];
   
    
    
}



#pragma mark cansoAction

- (void)cansoAction{
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)soAction{
    
//    __block SoViewController *soVC = self;
    if (_soText.text != Nil || [_soText.text isEqualToString:@""]) {
        
        if (_block != Nil) {
            _block(_soText.text);
            Block_release(_block);
            _block = Nil;
            
            FMDatabase *db = [DB creatDatabase];
            if ([db open]) {
                
                [db setShouldCacheStatements:YES];
                
                if ([db tableExists:ksb_recipes_so]) {
                    
                    NSString *sql = [NSString stringWithFormat:@"insert into %@ (title) values ('%@')",ksb_recipes_so,_soText.text];
                    
                    NSString *sqlCheck = [NSString stringWithFormat:@"select title from %@ where title = '%@'",ksb_recipes_so,_soText.text];
                    
                    FMResultSet *rw = [db executeQuery:sqlCheck];
                    if (![rw next]) {
                        
                        if([db executeUpdate:sql]){
                            NSLog(@"成功写入,%@",_soText.text);
                        }
                    }else{
                        NSLog(@"以有数据，%@",_soText.text);
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
           
            
            
        }
        [self cansoAction];
       
        
        
    }
    
//    [self cansoAction];
}
#pragma mark  UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];//查一下resign这个单词的意思就明白这个方法了
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"fffff");
     FMDatabase *db = [DB creatDatabase];
    
    if ([db open]) {
        
        [db setShouldCacheStatements:YES];
        if ([db tableExists:ksb_recipes_so]) {
            
            NSString *sql = [NSString stringWithFormat:@"select title from %@ order by rid desc",ksb_recipes_so];
            
            
            
            FMResultSet *rw = [db executeQuery:sql];
            [_data removeAllObjects];
            if (rw) {
                
                while ([rw next]) {
                    
                   NSString *title =  [rw stringForColumn:@"title"];
                    [_data addObject:title];
                }
                
                if (_data.count > 0) {
                    [_tableView reloadData];
                    _tableView.hidden = NO;
                }
               
                
            }
            
        }
    }
    
    NSLog(@"开始-textFieldDidBeginEditing");
}


#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier]autorelease];
    }
    
    cell.textLabel.text = [_data objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _soText.text = [_data objectAtIndex:indexPath.row];
    _tableView.hidden = YES;
}


- (void)dealloc
{
    [super dealloc];
    [_soText release];
    [_tableView release];
    [_data release];
    NSLog(@"SoView dealloc");
}

 

@end
