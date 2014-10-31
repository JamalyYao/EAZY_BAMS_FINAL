mysql、oracle数据库切换
1.修改 proxool.properties 文件
2.修改 hibernateConfig.properties 文件
3.修改 spring-config-web.xml 节点名称 mappingResources
4.（不使用可以不处理）修改报表数据源 web.xml节点名称  dataSource；数据源的名称 和 tomcat context.xml 以及 报表工具数据源名称 要统一
5.（不使用可以不处理）SysProcessService类中 删除公司方法deleteSysCompanyInfoByPk，sql有差异，具体看注释