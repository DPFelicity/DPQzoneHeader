//
//  ViewController.m
//  DPQzoneHeader
//
//  Created by Heaven on 2017/12/21.
//  Copyright © 2017年 heaven. All rights reserved.
//

#import "ViewController.h"

#define scrol 1.6
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)UIImage *im;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.im = [self createAImageWithColor:[UIColor whiteColor] alpha:0.0];
    [self.navigationController.navigationBar setBackgroundImage:self.im forBarMetrics:UIBarMetricsDefault];
    
    
    self.titleArray = @[@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题",@"标题"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
//    背景图放在view上，插入到第一个子视图
    UIImage *image = [UIImage imageNamed:@"picture"];
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Width/scrol)];
    self.imageV.image = image;
    self.imageV.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageV];
    [self.view insertSubview:self.imageV atIndex:0];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Width/scrol-64)];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat h = self.tableView.contentOffset.y;
    if (h<=Width/scrol-64) {
        CGFloat alp = h/(Width/scrol-64);
        self.im = [self createAImageWithColor:[UIColor whiteColor] alpha:alp];
        [self.navigationController.navigationBar setBackgroundImage:self.im forBarMetrics:UIBarMetricsDefault];
    }
    if (h>=0) {
       self.imageV.frame = CGRectMake(0, 0-h, Width, Width/scrol);
        
        
        
    }else{
       self.imageV.frame = CGRectMake(0, 0, (Width/scrol-h)*scrol, Width/scrol-h);
        self.imageV.center = CGPointMake(Width/2, (Width/scrol-h)/2);
    }
}


- (UIImage *)createAImageWithColor:(UIColor *)color alpha:(CGFloat)alpha{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetAlpha(context, alpha);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
