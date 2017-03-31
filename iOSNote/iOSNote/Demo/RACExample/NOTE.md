#RACSignal
RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    return [RACDisposable disposableWithBlock:^{

    }];
}];

RACSignal创建的信号是RACDynamicSignal类型

RACDynamicSignal的@property (nonatomic, copy, readonly) RACDisposable * (^didSubscribe)(id<RACSubscriber> subscriber);
用来保存^RACDisposable *(id<RACSubscriber> subscriber)


ISSUE
RACDisposable的disposableWithBlock何时调用
当一个RACSignal调用
subscribeNext
subscribeError
subscribeCompleted
会生成一个RACSubscriber
RACSubscriber没有强引用,创建之后随即销毁
RACSubscriber销毁时会调用RACDisposable
另外subscribeError和subscribeCompleted


RACSignal的下列行为
subscribeNext
subscribeError
subscribeCompleted
将生成的RACSubscriber传入自身的subscribe方法,将RACSubscriber转成RACPassthroughSubscriber,然后调用didSubscribe将RACPassthroughSubscriber做为参数传入
然后调用RACPassthroughSubscriber的
sendNext
sendError(会自动调用RACDisposable)
sendCompleted(会自动调用RACDisposable)

RACSubscriber即是个对象,也是个协议,包含以下方法
- (void)sendNext:(id)value;
- (void)sendError:(NSError *)error;
- (void)sendCompleted;
- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable;


#RACSubject
RACSubject继承RACSignal,实现了RACSubscriber协议,所以RACSubject能够sendNext,sendError,sendCompleted





#RACSignal和RACSubject区别
1.RACSubject实现了RACSubscriber协议,本身可以send
2.RACSubject拥有@property (nonatomic, strong, readonly) NSMutableArray *subscribers;
3.RACSubject调用subscribeNext不用触发block,而是将生成的subscriber存入数组
4.RACSubject的send,遍历所有subscriber,调用block
5.结论:RACSubject订阅之后将订阅者存入数组.RACSingla订阅之后会立即执行block.






#RACMulticastConnection
- (id)initWithSourceSignal:(RACSignal *)source subject:(RACSubject *)subject
没有订阅也会发送block
当一个RACSignal调用publish,内部会创建一个RACSubject,用来初始化RACMulticastConnection并返回.
当一个RACMulticastConnection调用connet,source signal会直接订阅创建的RACSubject,即用RACSubject来充当订阅者.

结论:public-connect不需要被订阅即可发送信号
