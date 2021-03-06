
set foreign_key_checks = 0;

truncate table busi_sales;
truncate table busi_sales_item;
truncate table busi_sales_return;
truncate table busi_sales_return_item;
truncate table busi_sales_makeup;
truncate table busi_sales_clear;
truncate table busi_orders;
truncate table busi_preord;

truncate table sys_dept;

insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (1, '01N', '销售一部', '迈思琪壁纸&墙饰（家天下精品店）', '松原市家天下家居广场一期E04外街门市', '0438-6953030', '0438-6953131', '0438-6593123', 'msneg@163.com', 'dept_logo01.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (2, '02N', '销售二部', '瑞典·摩曼壁纸 松原旗舰店', '松原市康宁街2418号火炬商企楼（昊祥装饰对面）', '0438-6162020', '0438-6953131', '0438-6593123', 'msneg@163.com', 'dept_logo02.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (3, '03N', '销售三部', '维斯戴克（美国）墙纸 家居多媒体验松原馆', '松原中东瑞家 二期 中厅商业步行街', '0438-2982070', '0438-6953131', '0438-6593123', 'msneg@163.com', 'dept_logo03.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (4, '04N', '销售四部', '德国汉高·百得粘合剂全系列 松原总代理', '松原中东瑞家 二期 商业步行街南门', '0438-2982720', '0438-6953131', '15164444966', 'msneg@163.com', 'dept_logo04.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (5, '05N', '销售五部', '美国·铂芙艺术涂漆空间体验馆—松原店', '松原中东瑞家 二期 商业步行街南门', '0438-2982720', '0438-6953131', '0438-6593123', 'msneg@163.com', 'dept_logo05.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (6, '06N', '销售六部', '靓点墙饰·靓点艺术玻璃马赛克销售中心', '松原中东瑞家 二期 中厅商业步行街', '0438-2983645', '0438-6953131', '13756783645', 'msneg@163.com', 'dept_logo06.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (7, '07N', '销售七部', '松原市迈思琪装潢材料有限公司', '松原市家天下家居广场一期E04外街门市', '0438-6953123', '0438-6953131', '15134335988', 'msneg@163.com', 'dept_logo07.jpg', 'A');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (8, '01FINANCE', '财务一部', '', '', '', '', '', 'msneg@163.com', 'dept_logo01.jpg', 'B');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (9, '01ASSIGN', '配货一部', '', '', '', '', '', 'msneg@163.com', 'dept_logo01.jpg', 'C');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (10, '01MANAGER', '总经办（部）', '', '', '', '', '', 'msneg@163.com', 'dept_logo01.jpg', 'M');
insert into sys_dept (dept_id, dept_code, dept_name, dept_remarks, dept_address, dept_phone, dept_fax, dept_service_phone, dept_email, dept_logo, dept_type_key) values (11, '99N', '总经理（部）', '', '', '', '', '', 'msneg@163.com', 'dept_logo01.jpg', 'S');

truncate table sys_user;

insert into sys_user (dept_id, user_name, real_name, passwd) values (10, 'admin', 'admin', 'YL5988');
insert into sys_user (dept_id, user_name, real_name, passwd) values (11, 'YL6555', 'YL6555', 'YL27297479');
insert into sys_user (dept_id, user_name, real_name, passwd) values (1, 'msneg', 'msneg', '6953030');
insert into sys_user (dept_id, user_name, real_name, passwd) values (2, 'mmpaper', 'mmpaper', '6162020');
insert into sys_user (dept_id, user_name, real_name, passwd) values (3, 'versedeco', 'versedeco', '2982070');
insert into sys_user (dept_id, user_name, real_name, passwd) values (4, 'pattex', 'pattex', '15164444966');
insert into sys_user (dept_id, user_name, real_name, passwd) values (5, 'boff', 'boff', '2982720');
insert into sys_user (dept_id, user_name, real_name, passwd) values (6, 'liangdian', 'liangdian', '2983645');
insert into sys_user (dept_id, user_name, real_name, passwd) values (7, 'gongcheng', 'gongcheng', '13756706555');
insert into sys_user (dept_id, user_name, real_name, passwd) values (8, 'caiwu01', 'caiwu01', 'caiwuchen');
insert into sys_user (dept_id, user_name, real_name, passwd) values (9, 'peihuo01', 'peihuo01', 'peihuolang');


truncate table sys_userrole;

insert into sys_userrole (user_id, role_id) values (1, 4);
insert into sys_userrole (user_id, role_id) values (2, 4);
insert into sys_userrole (user_id, role_id) values (3, 1);
insert into sys_userrole (user_id, role_id) values (4, 1);
insert into sys_userrole (user_id, role_id) values (5, 1);
insert into sys_userrole (user_id, role_id) values (6, 1);
insert into sys_userrole (user_id, role_id) values (7, 1);

insert into sys_userrole (user_id, role_id) values (8, 1);
insert into sys_userrole (user_id, role_id) values (9, 1);
insert into sys_userrole (user_id, role_id) values (10, 2);
insert into sys_userrole (user_id, role_id) values (11, 3);



truncate table sys_func;

insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (1, 'menu', '销售开单打印', '/sales', 1, 'lnb01');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (2, 'menu', '单据查看管理', '/busiBills', 2, 'lnb03');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (3, 'menu', '定金预定管理', '/busiOrders', 3, 'lnb02');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (4, 'menu', '财务统计审核', '/busiFinance?form[\'financeStateKey_eq\']=A', 4, 'lnb07');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (5, 'menu', '货物发配管理', '/busiAssign?form[\'assignStateKey_eq\']=A', 5, 'lnb05');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (6, 'menu', '库存管理查询', '/busiStock', 6, 'lnb06');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (7, 'menu', '综合数据分析', '/busiStatis/statis01', 7, 'lnb08');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (8, 'menu', '客户信息整理', '/busiClient', 8, 'lnb11');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (9, 'menu', '报备管理系统', '/busiPreord', 9, 'lnb13');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (10, 'menu', '综合管理系统', '/sysConfig', 10, 'lnb12');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (11, 'mod', '作废单据', '', 1, '');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (12, 'mod', '申请完结单据', '', 2, '');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (13, 'mod', '完结单据', '', 3, '');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (14, 'mod', '客户修改与删除', '', 4, '');

truncate table sys_role;

insert into sys_role (role_name) value ('销售');
insert into sys_role (role_name) value ('财务');
insert into sys_role (role_name) value ('仓库');
insert into sys_role (role_name) value ('总经办');

truncate table sys_rolefunc;

insert into sys_rolefunc (role_id, func_id) values (1, 1);
insert into sys_rolefunc (role_id, func_id) values (1, 2);
insert into sys_rolefunc (role_id, func_id) values (1, 3);
insert into sys_rolefunc (role_id, func_id) values (1, 6);
insert into sys_rolefunc (role_id, func_id) values (1, 8);
insert into sys_rolefunc (role_id, func_id) values (1, 9);
insert into sys_rolefunc (role_id, func_id) values (1, 12);
insert into sys_rolefunc (role_id, func_id) values (2, 2);
insert into sys_rolefunc (role_id, func_id) values (2, 4);
insert into sys_rolefunc (role_id, func_id) values (2, 7);
insert into sys_rolefunc (role_id, func_id) values (2, 8);
insert into sys_rolefunc (role_id, func_id) values (2, 9);
insert into sys_rolefunc (role_id, func_id) values (2, 13);
insert into sys_rolefunc (role_id, func_id) values (3, 2);
insert into sys_rolefunc (role_id, func_id) values (3, 5);
insert into sys_rolefunc (role_id, func_id) values (3, 8);
insert into sys_rolefunc (role_id, func_id) values (3, 9);
insert into sys_rolefunc (role_id, func_id) values (4, 1);
insert into sys_rolefunc (role_id, func_id) values (4, 2);
insert into sys_rolefunc (role_id, func_id) values (4, 3);
insert into sys_rolefunc (role_id, func_id) values (4, 4);
insert into sys_rolefunc (role_id, func_id) values (4, 5);
insert into sys_rolefunc (role_id, func_id) values (4, 6);
insert into sys_rolefunc (role_id, func_id) values (4, 7);
insert into sys_rolefunc (role_id, func_id) values (4, 8);
insert into sys_rolefunc (role_id, func_id) values (4, 9);
insert into sys_rolefunc (role_id, func_id) values (4, 10);
insert into sys_rolefunc (role_id, func_id) values (4, 11);
insert into sys_rolefunc (role_id, func_id) values (4, 12);
insert into sys_rolefunc (role_id, func_id) values (4, 13);
insert into sys_rolefunc (role_id, func_id) values (4, 14);

truncate table busi_category;
/*
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('A', 'NK壁纸1', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('A', 'NK壁纸2', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('A', 'NK壁纸3', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('A', 'NK壁纸4', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('B', 'B类商品1', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('B', 'B类商品2', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('C', 'C类商品1', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('C', 'C类商品1', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('C', 'C类商品1', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('D', 'D类商品1', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('D', 'D类商品2', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('D', 'D类商品3', 0);
insert into busi_category (item_type_key, cate_name, item_stock_amount) values ('D', 'D类商品4', 0);
*/
truncate table busi_item;

insert into busi_item
(item_name, item_unit_key, item_price, item_cnspell, cate_id, item_stock_amount) 
values ('NK', 'D', 100, 'YHBZ', 1, 300);

truncate table busi_client;
/*
insert into busi_client
(client_name, areacode, phone, cell_phone, address) 
values ('张三', '0431', '85112710', '15500440021', '长春市朝阳区红旗街');

insert into busi_client
(client_name, areacode, phone, cell_phone, address) 
values ('李四', '0431', '57413243', '15567105305', '长春市朝阳区湖西路');
*/
set foreign_key_checks = 1;