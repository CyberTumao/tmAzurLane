# tmAzurLane

## 简介
纪录科研收益，为科研提供参考
## 用法
1. 收获科研成果时截屏
2. 在正确的科研项下导入图片
3. 选择收益的具体数目，默认为1

## Pictures.zip内容说明
1. Database/ 数据库
2. Pictures/ 资源图片
3. ShowPictures/ 用于扫描对比的图片

## tmAL.db
+ Tech

  id 主键

  number 编号

  name 名称
+ ProfitMaterial

  id 主键

  name 名称

  picture 图片路径

  reference 预留字段

+ TechDetailidInfo

  id 主键

  tech_number 几期科研

  name 名称

  number 编号

  quality 品质 0蓝1紫2金

  scale 规模 0小1中2大

  addition 船名，用于定向研发时

+ historyAdd

  id 主键

  techInfoId 科研项目id

  historyId 纪录id

  date 日期

+ history

  id 主键

  number 纪录id

  profitMeterialId 图纸id

  profitNumber 数量

