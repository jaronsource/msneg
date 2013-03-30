
set foreign_key_checks = 0;

truncate table sys_dept;

insert into sys_dept (dept_name, dept_type_key) values ('销售一部', 'A');
insert into sys_dept (dept_name, dept_type_key) values ('销售二部', 'A');
insert into sys_dept (dept_name, dept_type_key) values ('销售三部', 'A');
insert into sys_dept (dept_name, dept_type_key) values ('销售四部', 'A');

truncate table sys_user;

insert into sys_user (dept_id, user_name, real_name, passwd) values (1, 'admin', 'admin', 'admin');

truncate table busi_item;

insert into busi_item
(item_code, item_name, item_format, item_unit, item_price, item_cnspell, item_type_key, item_stock_amount) 
values ('NK-95956', '印花壁纸', '100x50', '卷', 10000, 'YHBZ', 'A', 300);

truncate table busi_client;

insert into busi_client
(client_name, areacode, phone, cell_phone, address) 
values ('张三', '0431', '85112710', '15500440021', '长春市朝阳区红旗街');

insert into busi_client
(client_name, areacode, phone, cell_phone, address) 
values ('李四', '0431', '57413243', '15567105305', '长春市朝阳区湖西路');

set foreign_key_checks = 1;