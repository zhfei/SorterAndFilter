# 筛选与排序
<br>
工程内提供了筛选、排序的工具类，能够根据筛选视图和排序视图的内容多少，动态计算页面的高度；另外，控制器中自带蒙板视图，无需额外添加。
<br>
使用方法：
1.筛选工具类
  首先在工具类中添加筛选选项的数据源；
    NSDictionary *section0=@{@"手机":@[@"全部手机",@"配件",@"手机",@"微外卖"]};
    NSDictionary *section1=@{@"相机":@[@"全部相机",@"数码单反",@"普通相机",@"胶片相机",@"摄像机"]};
    NSDictionary *section2=@{@"电脑":@[@"全部电脑",@"台式机",@"笔记本",@"平板电脑",@"显示器"]};
    self.dataSource=@[section0,section1,section2];
 然后，将工具类控制器添加到要添加的视图上。
 <br>
 效果图如下：
 <br><br>

![截图](https://github.com/zhfei/RepositoryEffectPictures/blob/master/filt1.png)
<br><br>
 
2.排序工具类
  首先在工具类中添加排序选项的数据源；
      self.dataSource=@[@"离我最近",@"距离由远到近",@"距离由近到远"];
  然后，将工具类控制器添加到要添加的视图上。
  <br>
 效果图如下：
 ![截图](https://github.com/zhfei/RepositoryEffectPictures/blob/master/sort1.png)
<br><br>
