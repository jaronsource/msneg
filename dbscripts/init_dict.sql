set foreign_key_checks = 0;

truncate table sys_dict;

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'sales_type', '商品类别');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_type', 'A', '外销');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_type', 'B', '内销');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'item_type', '商品类别');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_type', 'A', 'A类');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_type', 'B', 'B类');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_type', 'C', 'C类');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_type', 'D', 'D类');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'serv_logis', '物流信息');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_logis', 'A', '正常');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_logis', 'B', '加急');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'serv_getmethod', '取送方式');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_getmethod', 'A', '自取');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_getmethod', 'B', '送货');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_getmethod', 'C', '异地发送');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'serv_installmethod', '安装方式');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_installmethod', 'A', '工费自负');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_installmethod', 'B', '托管安装');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('serv_installmethod', 'C', '店付');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'return_reason', '返销事由');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('return_reason', 'A', '剩余');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('return_reason', 'B', '破损');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('return_reason', 'C', '误差');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('return_reason', 'D', '工时');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('return_reason', 'E', '协商');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'clear_method', '结算形式');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('clear_method', 'A', '现金');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('clear_method', 'B', '刷卡');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('clear_method', 'C', '内部抵扣');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'orders_state', '定金单状态');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_state', 'A', '未使用');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_state', 'B', '已使用');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_state', 'C', '已退');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'dept_type', '部门类型');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('dept_type', 'A', '销售');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('dept_type', 'B', '财务');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('dept_type', 'C', '仓库');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('dept_type', 'A', '业务部');

 	
insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'orders_type', '定金类型');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_type', 'A', '量尺定金');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_type', 'B', '服务定金');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_type', 'C', '特价商品');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_type', 'D', '优惠折扣');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_type', 'E', '活动预定');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'orders_type', '定金类型');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'orders_use', '定金用途');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_use', 'A', '定金作为选购商品时的预付款');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_use', 'B', '定金作为选购商品时的尾款');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'orders_return', '定金返还');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_return', 'A', '定金劵');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_return', 'B', '定金可退 ');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('orders_return', 'C', '定金不可退');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'sales_state', '销售单状态');

/*
insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_state', 'A', '已定');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_state', 'B', '已备货');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_state', 'C', '已到货');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_state', 'D', '已安装');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('sales_state', 'O', '已完结');
*/

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'finance_state', '财务状态');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('finance_state', 'A', '未确认');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('finance_state', 'B', '已确认');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'assign_state', '备货状态');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('assign_state', 'A', '待备货');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('assign_state', 'B', '已备货');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('assign_state', 'C', '已到货');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'bill_state', '单据状态');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('bill_state', 'A0', '正常');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('bill_state', 'A1', '申请完结 ');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('bill_state', 'B', '作废 ');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('bill_state', 'C', '已完结');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'item_unit', '商品单位');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_unit', 'A', '卷');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_unit', 'B', '平米 ');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_unit', 'C', '米');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('item_unit', 'D', '套');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'preord_state', '报备状态');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('preord_state', 'A', '未成交');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('preord_state', 'B', '成交');


insert into sys_dict (dict_type, dict_key, dict_value0)
values ('KIND', 'stock_reason', '入库原因');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('stock_reason', 'A', '历史库存');

insert into sys_dict (dict_type, dict_key, dict_value0)
values ('stock_reason', 'B', '返销');

set foreign_key_checks = 1;

