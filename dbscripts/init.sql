
set foreign_key_checks = 0;

truncate table busi_sales;
truncate table busi_sales_item;
truncate table busi_sales_return;
truncate table busi_sales_return_item;
truncate table busi_sales_makeup;
truncate table busi_sales_clear;

truncate table sys_dept;

insert into sys_dept (dept_code, dept_name, dept_type_key) values ('01N', '销售一部', 'A');
insert into sys_dept (dept_code, dept_name, dept_type_key) values ('02N', '销售二部', 'A');
insert into sys_dept (dept_code, dept_name, dept_type_key) values ('03N', '销售三部', 'A');
insert into sys_dept (dept_code, dept_name, dept_type_key) values ('04N', '销售四部', 'A');
insert into sys_dept (dept_code, dept_name, dept_type_key) values ('CW', '财务一部', 'B');
insert into sys_dept (dept_code, dept_name, dept_type_key) values ('CK', '仓库一部', 'C');
insert into sys_dept (dept_code, dept_name, dept_type_key) values ('YEWB', '业务部', 'A');

truncate table sys_user;

insert into sys_user (dept_id, user_name, real_name, passwd) values (7, 'admin', 'admin', 'admin');
insert into sys_user (dept_id, user_name, real_name, passwd) values (7, 'yl', '总经理于林', 'yl');
insert into sys_user (dept_id, user_name, real_name, passwd) values (1, 'xs1', '销售小李', 'xs1');
insert into sys_user (dept_id, user_name, real_name, passwd) values (2, 'xs2', '销售小张', 'xs2');
insert into sys_user (dept_id, user_name, real_name, passwd) values (5, 'cw', '财务小王', 'cw');
insert into sys_user (dept_id, user_name, real_name, passwd) values (6, 'ck', '仓库小赵', 'ck');

truncate table sys_userrole;

insert into sys_userrole (user_id, role_id) values (3, 1);
insert into sys_userrole (user_id, role_id) values (4, 1);
insert into sys_userrole (user_id, role_id) values (5, 2);
insert into sys_userrole (user_id, role_id) values (6, 3);
insert into sys_userrole (user_id, role_id) values (1, 4);
insert into sys_userrole (user_id, role_id) values (2, 4);


truncate table sys_func;

insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (1, 'menu', '销售开单打印', '/sales', 1, 'lnb01');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (2, 'menu', '单据查看管理', '/busiBills', 2, 'lnb03');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (3, 'menu', '定金预定管理', '/busiOrders', 3, 'lnb02');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (4, 'menu', '财务统计审核', '/busiFinance?form[\'salesStateKey_eq\']=A', 4, 'lnb07');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (5, 'menu', '货物发配管理', '/busiAssign?form[\'salesStateKey_eq\']=B', 5, 'lnb05');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (6, 'menu', '库存管理查询', '/busiStock', 6, 'lnb06');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (7, 'menu', '综合数据分析', '/busiStatis/statis01', 7, 'lnb08');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (8, 'menu', '客户信息整理', '/busiClient', 8, 'lnb11');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (9, 'menu', '报备管理系统', '/busiPreord', 9, 'lnb13');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (10, 'menu', '综合管理系统', '/sysConfig', 10, 'lnb12');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (11, 'mod', '作废单据', '', 1, '');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (12, 'mod', '完结单据', '', 2, '');
insert into sys_func (func_id, func_groupcode, func_name, func_url, func_order, func_remarks) values (13, 'mod', '客户修改与删除', '', 3, '');

truncate table sys_role;

insert into sys_role (role_name) value ('销售员');
insert into sys_role (role_name) value ('财务');
insert into sys_role (role_name) value ('仓库');
insert into sys_role (role_name) value ('业务部');

truncate table sys_rolefunc;

insert into sys_rolefunc (role_id, func_id) values (1, 1);
insert into sys_rolefunc (role_id, func_id) values (1, 2);
insert into sys_rolefunc (role_id, func_id) values (1, 3);
insert into sys_rolefunc (role_id, func_id) values (1, 6);
insert into sys_rolefunc (role_id, func_id) values (1, 8);
insert into sys_rolefunc (role_id, func_id) values (1, 9);
insert into sys_rolefunc (role_id, func_id) values (2, 2);
insert into sys_rolefunc (role_id, func_id) values (2, 4);
insert into sys_rolefunc (role_id, func_id) values (2, 7);
insert into sys_rolefunc (role_id, func_id) values (2, 8);
insert into sys_rolefunc (role_id, func_id) values (2, 9);
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

truncate table busi_category;

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

truncate table busi_item;

insert into busi_item
(item_name, item_unit_key, item_price, item_cnspell, cate_id, item_stock_amount) 
values ('NK', 'D', 100, 'YHBZ', 1, 300);

truncate table busi_client;

insert into busi_client
(client_name, areacode, phone, cell_phone, address) 
values ('张三', '0431', '85112710', '15500440021', '长春市朝阳区红旗街');

insert into busi_client
(client_name, areacode, phone, cell_phone, address) 
values ('李四', '0431', '57413243', '15567105305', '长春市朝阳区湖西路');

set foreign_key_checks = 1;