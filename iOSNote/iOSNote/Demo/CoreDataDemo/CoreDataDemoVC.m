//
//  CoreDataDemoVC.m
//  iOSNote
//
//  Created by wangdong on 2016/11/29.
//  Copyright © 2016年 yozoe. All rights reserved.
//

#import "CoreDataDemoVC.h"
#import "Employee+CoreDataClass.h"
#import "Department+CoreDataClass.h"
#import <MagicalRecord/MagicalRecord.h>


@interface CoreDataDemoVC ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation CoreDataDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 创建上下文对象，并发队列设置为主队列
//    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    
//    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
//    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"iOSNote" withExtension:@"momd"];
//    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
//    
//    // 创建持久化存储调度器
//    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
//    
//    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"iOSNote"];
//    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
//    
//    // 上下文对象设置属性为持久化存储器
//    context.persistentStoreCoordinator = coordinator;
//    
//    self.context = context;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    + [NSManagedObjectContext MR_context] : 设置默认的上下文为它的父级上下文.并发类型为**NSPrivateQueueConcurrencyType**.
//    + [NSManagedObjectContext MR_newMainQueueContext]: 并发类型为 ** NSMainQueueConcurrencyType**.
//    + [NSManagedObjectContext MR_newPrivateQueueContext] : 并发类型为 **NSPrivateQueueConcurrencyType**.
//    + [NSManagedObjectContext MR_contextWithParent:…] : 允许自定义父级上下文.并发类型为**NSPrivateQueueConcurrencyType**.
//    + [NSManagedObjectContext MR_contextWithStoreCoordinator:…] :允许自定义持久化存储协调器.并发类型为**NSPrivateQueueConcurrencyType**.
    
    
    
    
    
    
    
    
    
    
    
//    // 获取上下文环境
//    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_context];
//    
//    // 在当前上下文环境中创建一个新的 Person 对象.
//    Employee *zsEmployee = [Employee MR_createEntityInContext:localContext];
//    zsEmployee.name = @"hehe";
//    zsEmployee.height = @1.9f;
//    zsEmployee.brithday = [NSDate date];
//    
//    // 保存修改到当前上下文中.
//    [localContext MR_saveToPersistentStoreAndWait];
//    
//
//    NSArray *people = [Employee MR_findAll];
//    NSLog(@"%@", people);
    
    
    
    
    
    
    
    
    
    
    
    // 获取上下文环境
//    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
//    
//    
//    // 在当前上下文环境中创建一个新的 Person 对象.
//    Employee *zsEmployee = [Employee MR_createEntityInContext:defaultContext];
//    zsEmployee.name = @"defaultContext";
//    zsEmployee.height = @1.9f;
//    zsEmployee.brithday = [NSDate date];
//    
//    // 保存修改到当前上下文中.
//    [defaultContext MR_saveToPersistentStoreAndWait];
//    
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
//        
//        Employee *zsEmployee = [Employee MR_createEntityInContext:localContext];
//        zsEmployee.name = @"localContext";
//        zsEmployee.height = @1.9f;
//        zsEmployee.brithday = [NSDate date];
//
//    }];
    
    
    
    
    
    
    
    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
//        
//        Employee *zsEmployee = [Employee MR_createEntityInContext:localContext];
//        zsEmployee.name = @"localContext";
//        zsEmployee.height = @1.9f;
//        zsEmployee.brithday = [NSDate date];
//
//    }  completion:^(BOOL success, NSError *error) {
//        
//        NSArray * persons = [Employee MR_findAll];
//        
//        [persons enumerateObjectsUsingBlock:^(Employee * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"firstname: %@, lastname: %@\n", obj.name, obj.height);
//        }];
//        
//    }];
//    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    [self search];
    
//    [self delete];
    
//    [self search];
    
//    [self insert2];
    
//    [self search3];
    
    
//    // 创建托管对象，并指明创建的托管对象所属实体名
//    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_context];
//    emp.name = @"lxz";
//    emp.height = @1.7;
//    emp.brithday = [NSDate date];
//    
//    // 通过上下文保存对象，并在保存前判断是否有更改
//    NSError *error = nil;
//    if (_context.hasChanges) {
//        [_context save:&error];
//    }
//    
//    // 错误处理
//    if (error) {
//        NSLog(@"CoreData Insert Data Error : %@", error);
//    }
}

- (void)search
{
    // 建立获取数据的请求对象，指明操作的实体为Employee
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    // 执行获取操作，获取所有Employee托管对象
    NSError *error = nil;
    NSArray<Employee *> *employees = [self.context executeFetchRequest:request error:&error];
    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Employee Name : %@, Height : %@, Brithday : %@", obj.name, obj.height, obj.brithday);
    }];
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
}

- (void)delete
{
    // 建立获取数据的请求对象，指明对Employee实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"lxz"];
    request.predicate = predicate;
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    NSArray<Employee *> *employees = [self.context executeFetchRequest:request error:&error];
    
    // 遍历符合删除要求的对象数组，执行删除操作
    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context deleteObject:obj];
    }];
    
    // 保存上下文
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }
}

- (void)search2
{
    // 建立获取数据的请求对象，并指明操作Employee表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    // 设置请求条件，通过设置的条件，来过滤出需要的数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"lxz"];
    request.predicate = predicate;
    
    // 设置请求结果排序方式，可以设置一个或一组排序方式，最后将所有的排序方式添加到排序数组中
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    // NSSortDescriptor的操作都是在SQLite层级完成的，不会将对象加载到内存中，所以对内存的消耗是非常小的
    request.sortDescriptors = @[sort];
    
    // 执行获取请求操作，获取的托管对象将会被存储在一个数组中并返回
    NSError *error = nil;
    NSArray<Employee *> *employees = [self.context executeFetchRequest:request error:&error];
    [employees enumerateObjectsUsingBlock:^(Employee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Employee Name : %@, Height : %@, Brithday : %@", obj.name, obj.height, obj.brithday);
    }];
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Fetch Data Error : %@", error);
    }
}

- (void)search3
{
    // 创建获取数据的请求对象，并指明操作Department表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Department"];
    
    // 设置请求条件，设置employee的name为请求条件。NSPredicate的好处在于，可以设置keyPath条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"departName = %@", @"android"];
    request.predicate = predicate;
    
    // 执行查找操作
    NSError *error = nil;
    NSArray<Department *> *departments = [self.context executeFetchRequest:request error:&error];
    [departments enumerateObjectsUsingBlock:^(Department * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Department Search Result DepartName : %@, employee name : %@", obj.departName, obj.employee);
    }];
    
    // 错误处理
    if (error) {
        NSLog(@"Department Search Error : %@", error);
    }
}

- (void)insert2
{
    // 创建托管对象，并将其关联到指定的MOC上
    Employee *zsEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    zsEmployee.name = @"zhangsan";
    zsEmployee.height = @1.9f;
    zsEmployee.brithday = [NSDate date];
    
    Employee *lsEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    lsEmployee.name = @"lisi";
    lsEmployee.height = @1.7f;
    lsEmployee.brithday = [NSDate date];
    
    Department *iosDepartment = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    iosDepartment.departName = @"iOS";
    iosDepartment.createDate = [NSDate date];
//    iosDepartment.employee = zsEmployee;
    [iosDepartment addEmployeeObject:zsEmployee];
    
    Department *androidDepartment = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    androidDepartment.departName = @"android";
    androidDepartment.createDate = [NSDate date];
//    androidDepartment.employee = lsEmployee;
    [androidDepartment addEmployeeObject:lsEmployee];
    
    // 执行存储操作
    NSError *error = nil;
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"Association Table Add Data Error : %@", error);
    }
}

@end


/*
 NSArray *allSubVideos = [VideoMO MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", VideoMORelationships.game, game, VideoMOAttributes.isCollection, @NO]];
 
 NSArray *videos = [VideoMO MR_findAllSortedBy:[VideoMOAttributes createDate] ascending:NO withPredicate:[BMUtils filterPredicateWithType:_bestMomentType]];
 
 NSUInteger count = [VideoMO MR_countOfEntitiesWithPredicate:[BMUtils filterPredicateWithType:_bestMomentType]];
 
 _dataSource = [VideoMO MR_fetchAllSortedBy:[VideoMOAttributes createDate] ascending:NO withPredicate:filter groupBy:nil delegate:nil];
 
 _dataSource = [VideoMO MR_fetchAllGroupedBy:NSStringFromSelector(@selector(groupMonthString)) withPredicate:filter sortedBy:[VideoMOAttributes createDate] ascending:NO];
 
 NSArray *array = [VideoMO MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"bmType == nil AND %K = %@", [VideoMOAttributes authorId], user.identifier]];
 
 
 
 
 
 NSManagedObjectContext *context = [ZPCoreDataStore mainThreadContext];
 
 NSFetchedResultsController *aFetchedResultsController = [GameMO MR_fetchAllSortedBy:GameMOAttributes.creatTimeDate
 ascending:NO
 withPredicate:[NSPredicate predicateWithFormat:@" %K = %@ AND %K != %@", GameMORelationships.user, _user , GameMOAttributes.endTimeDate, [NSNull null]]
 groupBy:nil
 delegate:delegate
 inContext:context];
 NSError *error = nil;
 
 if (![aFetchedResultsController performFetch:&error]) {
 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
 abort();
 }
 
 
 
 
 
 
 
 NSFetchedResultsController *controller = [DailyReportMO MR_fetchAllGroupedBy:[[self class] getGroupKeyWithFilterType:type]
 withPredicate:nil
 sortedBy:DailyReportMOAttributes.dateString
 ascending:NO
 delegate:nil];
 NSArray *reports = nil;
 for (id<NSFetchedResultsSectionInfo> sectionInfo in controller.sections) {
 if ([[sectionInfo name] isEqualToString:dateString]) {
 reports = [sectionInfo objects];
 }
 }
 
 if (!reports || reports.count == 0) {
 return nil;
 }else{
 NSDictionary *mergeDict = nil;
 for (DailyReportMO *dailyReport in reports) {
 NSDictionary *dictReport = dailyReport.reportDic;
 mergeDict = [[self class] _mergeReport1:mergeDict report2:dictReport];
 }
 return mergeDict;
 }
 
 
 
 
 
 NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K = %@ AND %K = NO AND %K = %@" ,
 DailyReportMORelationships.user , user ,
 DailyReportMOAttributes.isServerData,
 DailyReportMOAttributes.dateString,dateString];
 NSArray *reports = [DailyReportMO MR_findAllWithPredicate:pre
 inContext:[ZPCoreDataStore mainThreadContext]];
 
 
 
 
 DailyReportMO *dailyReport = [DailyReportMO MR_createEntityInContext:[ZPCoreDataStore mainThreadContext]];
 dailyReport.dateString = dateString ;
 dailyReport.report = reportJsonString;
 dailyReport.user = [[NSManagedObjectContext MR_defaultContext] objectWithID:user.objectID];
 
 
 
  self.currentUser = [UserMO MR_findFirstByAttribute:UserMOAttributes.identifier withValue:userId];
 
 
 
 
 GameMO *game = [GameMO MR_createEntity];
	game.creatTimeDate = MR_dateFromNumber(model.createdAt, YES);
	game.endTimeDate = MR_dateFromNumber(model.endTime, YES);
 
 
 
 
 [[[self class] mainThreadContext] MR_saveToPersistentStoreAndWait];
 [[[self class] rootSavingContext] MR_saveToPersistentStoreAndWait];
 
 
 
 GameUserMO *gameUser = [GameUserMO MR_createEntityInContext:[ZPCoreDataStore mainThreadContext]];
 gameUser.game = [[NSManagedObjectContext MR_defaultContext] objectWithID:game.objectID];
 gameUser.user = [[NSManagedObjectContext MR_defaultContext] objectWithID:user.objectID];
 
 */
