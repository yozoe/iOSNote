Data Model Inspector

Transient 不写入持久化存储区的特性
Optional 默认值,表示特性不一定要有值,如果不是optional特性,那么在把这个非optional特性放回存储区的时候,必须具备有效值
Indexed 占用额外空间提升搜索效率
Validation 符合条件的值才可以进入持久化存储区
Reg.EX 正则表达式
Default 除了可变数据类型和二进制数据之外,其余类型的属性都可以具备默认值.
Allows External Storage 开启之类二进制数据的属性就可以把超过!MB数据保存在持久化存储区之外了,不支持xml
Index in Spotlight 
Store in External Record File 
Name 如果某个属性的类型是可变类型,那么名称这一栏种填写的名称会用作NSValueTransformer子类的名称,而这个子类会直到如何在任意的类与NSData之间相互转换

-com.apple.CoreData.SQLDebug 3


-wal -shm ios7默认会采用一种新的"数据库日志记录模式"
禁用NSDictionary *options = @{NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"}};


http://developer.apple.com Predicate Programming Guide




Nullify 大多数情况都可以采用这种默认的Delete规则.如果删除了某个对象,而该对象与其他对象的关系又受制于Nullify规则,那么这些对象就会把指向该对象的关系清空.
假如item关系的delete规则是nullify,那么当把这个名为kg的unit对象删掉之后,与它相关的那些item对象就会将其unit特性设为nil.

Cascade 这种delete规则会沿着关系来传播删除操作.比方把kg删了, 对应item也删了

Deny 有关联会引发错误

No Action 删除某个对象之后,开发者必须手动设定反向的关系,以确保他们都指向有效的对象.
