SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `msneg` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `msneg` ;

-- -----------------------------------------------------
-- Table `msneg`.`busi_client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_client` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_client` (
  `client_id` INT NOT NULL AUTO_INCREMENT COMMENT '客户ID' ,
  `client_name` VARCHAR(255) NULL COMMENT '客户姓名' ,
  `areacode` VARCHAR(255) NULL COMMENT '区号' ,
  `phone` VARCHAR(255) NULL COMMENT '电话' ,
  `cell_phone` VARCHAR(255) NULL COMMENT '手机' ,
  `address` VARCHAR(255) NULL COMMENT '地址' ,
  PRIMARY KEY (`client_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_dept`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_dept` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_dept` (
  `dept_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键' ,
  `dept_name` VARCHAR(255) NULL COMMENT '名称' ,
  `dept_remarks` VARCHAR(255) NULL COMMENT '描述' ,
  `dept_type_key` VARCHAR(255) NULL COMMENT '部门类型' ,
  PRIMARY KEY (`dept_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_user` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_user` (
  `user_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键' ,
  `dept_id` INT NOT NULL COMMENT '部门' ,
  `user_name` VARCHAR(255) NULL COMMENT '用户名' ,
  `real_name` VARCHAR(255) NULL COMMENT '姓名' ,
  `passwd` VARCHAR(255) NULL COMMENT '密码' ,
  `is_available` INT NULL COMMENT '是否可用' ,
  PRIMARY KEY (`user_id`) ,
  INDEX `fk_sys_user_sys_dept1_idx` (`dept_id` ASC) ,
  CONSTRAINT `fk_sys_user_sys_dept1`
    FOREIGN KEY (`dept_id` )
    REFERENCES `msneg`.`sys_dept` (`dept_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales` (
  `sales_id` INT NOT NULL AUTO_INCREMENT COMMENT '销售单ID' ,
  `sales_code` VARCHAR(255) NOT NULL COMMENT '编码' ,
  `dept_id` INT NOT NULL COMMENT '销售部门' ,
  `user_id` INT NOT NULL COMMENT '经手人' ,
  `create_time` VARCHAR(255) NULL COMMENT '创建时间' ,
  `sales_remarks` VARCHAR(255) NULL COMMENT '备注' ,
  `sales_type_key` VARCHAR(255) NULL COMMENT '销售单类型' ,
  `client_id` INT NOT NULL COMMENT '客户ID' ,
  `sales_state_key` VARCHAR(255) NULL COMMENT '状态' ,
  `serv_logis_key` VARCHAR(255) NULL COMMENT '物流信息' ,
  `serv_getmethod_key` VARCHAR(255) NULL COMMENT '取货方式' ,
  `serv_installmethod_key` VARCHAR(255) NULL COMMENT '安装方式' ,
  `fee_sum` INT NULL DEFAULT 0 COMMENT '总金额' ,
  `fee_prepay` INT NULL DEFAULT 0 COMMENT '预付金额' ,
  `fee_prepay_cash` INT NULL DEFAULT 0 COMMENT '预付金现金' ,
  `fee_prepay_card` INT NULL DEFAULT 0 COMMENT '预付金刷卡' ,
  `fee_remain` INT NULL DEFAULT 0 COMMENT '剩余尾款' ,
  `other_remarks` VARCHAR(255) NULL COMMENT '其他备注' ,
  `sales_contract` VARCHAR(255) NULL COMMENT '合同条款' ,
  PRIMARY KEY (`sales_id`) ,
  INDEX `fk_busi_sales_sys_dept1_idx` (`dept_id` ASC) ,
  INDEX `fk_busi_sales_sys_user1_idx` (`user_id` ASC) ,
  INDEX `fk_busi_sales_busi_client1_idx` (`client_id` ASC) ,
  CONSTRAINT `fk_busi_sales_sys_dept1`
    FOREIGN KEY (`dept_id` )
    REFERENCES `msneg`.`sys_dept` (`dept_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_sys_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_busi_client1`
    FOREIGN KEY (`client_id` )
    REFERENCES `msneg`.`busi_client` (`client_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_item` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_item` (
  `item_id` INT NOT NULL AUTO_INCREMENT COMMENT '商品ID' ,
  `item_code` VARCHAR(255) NOT NULL COMMENT '货号' ,
  `item_name` VARCHAR(255) NULL COMMENT '名称' ,
  `item_format` VARCHAR(255) NULL COMMENT '型号' ,
  `item_unit` VARCHAR(255) NULL COMMENT '单位' ,
  `item_price` INT NULL DEFAULT 0 COMMENT '单价' ,
  `item_cnspell` VARCHAR(255) NULL COMMENT '助记符' ,
  `item_type_key` VARCHAR(255) NULL COMMENT '类别' ,
  `item_stock_amount` INT NULL DEFAULT 0 COMMENT '库存数量' ,
  PRIMARY KEY (`item_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_dict`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_dict` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_dict` (
  `record_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键' ,
  `dict_type` VARCHAR(255) NULL COMMENT '类型' ,
  `dict_key` VARCHAR(255) NULL COMMENT '键' ,
  `parent_key` VARCHAR(255) NULL COMMENT '父级键' ,
  `dict_value0` VARCHAR(255) NULL COMMENT '值0' ,
  `dict_value1` VARCHAR(255) NULL COMMENT '值1' ,
  `dict_value2` VARCHAR(255) NULL COMMENT '值2' ,
  `dict_value3` VARCHAR(255) NULL COMMENT '值3' ,
  PRIMARY KEY (`record_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_role` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_role` (
  `role_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键' ,
  `role_name` VARCHAR(255) NULL COMMENT '角色名' ,
  `role_remarks` VARCHAR(255) NULL COMMENT '描述' ,
  PRIMARY KEY (`role_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_userrole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_userrole` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_userrole` (
  `user_id` INT NOT NULL ,
  `role_id` INT NOT NULL ,
  INDEX `fk_sys_userrole_sys_user_idx` (`user_id` ASC) ,
  INDEX `fk_sys_userrole_sys_role1_idx` (`role_id` ASC) ,
  CONSTRAINT `fk_sys_userrole_sys_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_userrole_sys_role1`
    FOREIGN KEY (`role_id` )
    REFERENCES `msneg`.`sys_role` (`role_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_func`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_func` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_func` (
  `func_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键' ,
  `func_name` VARCHAR(255) NULL COMMENT '名称' ,
  `func_url` VARCHAR(255) NULL COMMENT '地址' ,
  `func_remarks` VARCHAR(255) NULL COMMENT '描述' ,
  `parent_id` INT NULL COMMENT '父功能' ,
  `func_groupcode` VARCHAR(255) NULL COMMENT '功能组' ,
  `func_order` INT NULL COMMENT '序号' ,
  PRIMARY KEY (`func_id`) ,
  INDEX `fk_sys_func_sys_func1_idx` (`parent_id` ASC) ,
  CONSTRAINT `fk_sys_func_sys_func1`
    FOREIGN KEY (`parent_id` )
    REFERENCES `msneg`.`sys_func` (`func_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`sys_rolefunc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`sys_rolefunc` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`sys_rolefunc` (
  `role_id` INT NOT NULL ,
  `func_id` INT NOT NULL ,
  INDEX `fk_sys_rolefunc_sys_role1_idx` (`role_id` ASC) ,
  INDEX `fk_sys_rolefunc_sys_func1_idx` (`func_id` ASC) ,
  CONSTRAINT `fk_sys_rolefunc_sys_role1`
    FOREIGN KEY (`role_id` )
    REFERENCES `msneg`.`sys_role` (`role_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sys_rolefunc_sys_func1`
    FOREIGN KEY (`func_id` )
    REFERENCES `msneg`.`sys_func` (`func_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_item` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_item` (
  `sales_item_id` INT NOT NULL AUTO_INCREMENT COMMENT '销售商品ID' ,
  `sales_id` INT NOT NULL COMMENT '销售单ID' ,
  `item_id` INT NOT NULL COMMENT '商品ID' ,
  `item_amount` INT NULL DEFAULT 0 COMMENT '商品数量' ,
  `item_sum` INT NULL DEFAULT 0 COMMENT '合计' ,
  `item_remarks` VARCHAR(255) NULL COMMENT '信息备注' ,
  PRIMARY KEY (`sales_item_id`) ,
  INDEX `fk_busi_sales_item_busi_sales1_idx` (`sales_id` ASC) ,
  INDEX `fk_busi_sales_item_busi_category1_idx` (`item_id` ASC) ,
  CONSTRAINT `fk_busi_sales_item_busi_sales1`
    FOREIGN KEY (`sales_id` )
    REFERENCES `msneg`.`busi_sales` (`sales_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_item_busi_category1`
    FOREIGN KEY (`item_id` )
    REFERENCES `msneg`.`busi_item` (`item_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_return`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_return` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_return` (
  `return_id` INT NOT NULL AUTO_INCREMENT COMMENT '返销单ID' ,
  `sales_id` INT NOT NULL COMMENT '销售单ID' ,
  `user_id` INT NOT NULL COMMENT '经手人' ,
  `return_sum` INT NULL DEFAULT 0 COMMENT '应返金额' ,
  `return_loss` INT NULL DEFAULT 0 COMMENT '返销破损' ,
  `rerate_loss` INT NULL DEFAULT 0 COMMENT '折扣破损' ,
  `return_remarks` VARCHAR(255) NULL COMMENT '备注' ,
  `act_return_sum` INT NULL DEFAULT 0 COMMENT '实返金额' ,
  `clear_method_key` VARCHAR(255) NULL COMMENT '结算方式' ,
  `other_remarks` VARCHAR(255) NULL COMMENT '其他备注' ,
  `dept_id` INT NULL COMMENT '部门ID' ,
  `create_time` VARCHAR(255) NULL COMMENT '创建时间' ,
  PRIMARY KEY (`return_id`) ,
  INDEX `fk_busi_sales_return_busi_sales1_idx` (`sales_id` ASC) ,
  INDEX `fk_busi_sales_return_sys_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_busi_sales_return_busi_sales1`
    FOREIGN KEY (`sales_id` )
    REFERENCES `msneg`.`busi_sales` (`sales_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_return_sys_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_return_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_return_item` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_return_item` (
  `return_item_id` INT NOT NULL AUTO_INCREMENT COMMENT '返销商品ID' ,
  `return_id` INT NOT NULL COMMENT '返销单ID' ,
  `return_price` INT NULL COMMENT '返销单价' ,
  `return_amount` INT NULL COMMENT '返销数量' ,
  `return_sum` INT NULL COMMENT '返销合计' ,
  `return_reason_key` VARCHAR(255) NULL COMMENT '返销事由' ,
  `return_remarks` VARCHAR(255) NULL COMMENT '备注' ,
  `sales_item_id` INT NOT NULL ,
  PRIMARY KEY (`return_item_id`) ,
  INDEX `fk_busi_sales_return_item_busi_sales_return1_idx` (`return_id` ASC) ,
  INDEX `fk_busi_sales_return_item_busi_sales_item1_idx` (`sales_item_id` ASC) ,
  CONSTRAINT `fk_busi_sales_return_item_busi_sales_return1`
    FOREIGN KEY (`return_id` )
    REFERENCES `msneg`.`busi_sales_return` (`return_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_return_item_busi_sales_item1`
    FOREIGN KEY (`sales_item_id` )
    REFERENCES `msneg`.`busi_sales_item` (`sales_item_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_clear`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_clear` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_clear` (
  `clear_id` INT NOT NULL AUTO_INCREMENT COMMENT '结算单ID' ,
  `sales_id` INT NOT NULL COMMENT '销售单ID' ,
  `user_id` INT NOT NULL COMMENT '经手人' ,
  `create_time` VARCHAR(255) NULL COMMENT '创建时间' ,
  PRIMARY KEY (`clear_id`) ,
  INDEX `fk_busi_sales_clear_busi_sales1_idx` (`sales_id` ASC) ,
  INDEX `fk_busi_sales_clear_sys_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_busi_sales_clear_busi_sales1`
    FOREIGN KEY (`sales_id` )
    REFERENCES `msneg`.`busi_sales` (`sales_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_clear_sys_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_working`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_working` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_working` (
  `working_id` INT NOT NULL AUTO_INCREMENT COMMENT '工时单ID' ,
  `other_item_name` VARCHAR(255) NULL COMMENT '其他项目名称' ,
  `other_item_price` INT NULL DEFAULT 0 COMMENT '其他项目单价' ,
  `other_item_amount` INT NULL DEFAULT 0 COMMENT '其他项目数量' ,
  `other_item_sum` INT NULL DEFAULT 0 COMMENT '其他项目合计' ,
  `other_item_remarks` VARCHAR(255) NULL COMMENT '项目备注' ,
  `fee_sum` INT NULL COMMENT '工时总额' ,
  `clear_method_key` VARCHAR(255) NULL COMMENT '结算形式' ,
  `install_dept_id` INT NOT NULL COMMENT '安装部门' ,
  `other_remarks` VARCHAR(255) NULL ,
  `create_time` VARCHAR(255) NULL COMMENT '创建时间' ,
  `user_id` INT NOT NULL COMMENT '经手人' ,
  PRIMARY KEY (`working_id`) ,
  INDEX `fk_busi_working_sys_dept1_idx` (`install_dept_id` ASC) ,
  INDEX `fk_busi_working_sys_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_busi_working_sys_dept1`
    FOREIGN KEY (`install_dept_id` )
    REFERENCES `msneg`.`sys_dept` (`dept_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_working_sys_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_working_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_working_item` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_working_item` (
  `working_item_id` INT NOT NULL AUTO_INCREMENT COMMENT '工时单商品ID' ,
  `working_id` INT NOT NULL COMMENT '工时单ID' ,
  `return_visit_key` VARCHAR(255) NULL COMMENT '回访' ,
  `item_remarks` VARCHAR(255) NULL COMMENT '备注' ,
  `sales_item_id` INT NOT NULL ,
  PRIMARY KEY (`working_item_id`) ,
  INDEX `fk_busi_working_item_busi_working1_idx` (`working_id` ASC) ,
  INDEX `fk_busi_sales_working_item_busi_sales_item1_idx` (`sales_item_id` ASC) ,
  CONSTRAINT `fk_busi_working_item_busi_working1`
    FOREIGN KEY (`working_id` )
    REFERENCES `msneg`.`busi_sales_working` (`working_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_working_item_busi_sales_item1`
    FOREIGN KEY (`sales_item_id` )
    REFERENCES `msneg`.`busi_sales_item` (`sales_item_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_makeup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_makeup` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_makeup` (
  `makeup_id` INT NOT NULL AUTO_INCREMENT COMMENT '补价单ID' ,
  `makeup_sum` INT NULL DEFAULT 0 COMMENT '补价总额' ,
  `clear_method_key` VARCHAR(255) NULL COMMENT '结算方式' ,
  `user_id` INT NOT NULL COMMENT '经手人' ,
  `add_item1` INT NULL DEFAULT 0 COMMENT '新增临时性损耗费用' ,
  `add_item2` INT NULL DEFAULT 0 COMMENT '增值服务取费' ,
  `add_item3` INT NULL DEFAULT 0 COMMENT '上衣托管安装（含多施工费用）' ,
  `add_item4` INT NULL DEFAULT 0 COMMENT '变更议价补价' ,
  `add_item5` INT NULL DEFAULT 0 COMMENT '新增运输及商品管理费用' ,
  `add_item6` INT NULL DEFAULT 0 COMMENT '其他商议费用' ,
  `minus_item1` INT NULL DEFAULT 0 COMMENT '递减临时性损耗费用' ,
  `minus_item2` INT NULL DEFAULT 0 COMMENT '补退议价差额' ,
  `minus_item3` INT NULL DEFAULT 0 COMMENT '递减托管安装（含少施工费用）' ,
  `minus_item4` INT NULL DEFAULT 0 COMMENT '遇零取整差价' ,
  `minus_item5` INT NULL DEFAULT 0 COMMENT '商品瑕疵/破损议价差额' ,
  `minus_item6` INT NULL COMMENT ' 其他商议费用' ,
  `makeup_remarks` VARCHAR(255) NULL COMMENT '补价信息备注' ,
  `other_remarks` VARCHAR(255) NULL COMMENT '其他备注' ,
  `create_time` VARCHAR(255) NULL COMMENT '创建时间' ,
  `sales_id` INT NOT NULL ,
  PRIMARY KEY (`makeup_id`) ,
  INDEX `fk_busi_margin_sys_user1_idx` (`user_id` ASC) ,
  INDEX `fk_busi_sales_makeup_busi_sales1_idx` (`sales_id` ASC) ,
  CONSTRAINT `fk_busi_margin_sys_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_makeup_busi_sales1`
    FOREIGN KEY (`sales_id` )
    REFERENCES `msneg`.`busi_sales` (`sales_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_brokerage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_brokerage` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_brokerage` (
  `brok_id` INT NOT NULL AUTO_INCREMENT COMMENT '提成单ID' ,
  `brok_sum` INT NULL DEFAULT 0 COMMENT '提成总额' ,
  `clear_method_key` VARCHAR(255) NULL COMMENT '结算方式' ,
  `brok_person_name` VARCHAR(255) NULL COMMENT '提成人' ,
  `user_id` INT NOT NULL COMMENT '经手人' ,
  `create_time` VARCHAR(255) NULL COMMENT '创建时间' ,
  PRIMARY KEY (`brok_id`) ,
  INDEX `fk_busi_percent_sys_user2_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_busi_percent_sys_user2`
    FOREIGN KEY (`user_id` )
    REFERENCES `msneg`.`sys_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_sales_brokerage_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_sales_brokerage_item` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_sales_brokerage_item` (
  `brok_item_id` INT NOT NULL AUTO_INCREMENT COMMENT '提成商品ID' ,
  `brok_id` INT NOT NULL COMMENT '提成单ID' ,
  `brok_return` INT NULL DEFAULT 0 COMMENT '返销' ,
  `brok_install` INT NULL DEFAULT 0 COMMENT '安装' ,
  `brok_makeup` INT NULL DEFAULT 0 COMMENT '辅差' ,
  `brok_ratio` INT NULL DEFAULT 0 COMMENT '比率' ,
  `brok_mere_price` INT NULL DEFAULT 0 COMMENT '净价' ,
  `brok_mere_amount` INT NULL DEFAULT 0 COMMENT '净量' ,
  `brok_sum` INT NULL DEFAULT 0 COMMENT '提成合计' ,
  `sales_item_id` INT NOT NULL ,
  INDEX `fk_table1_busi_percent1_idx` (`brok_id` ASC) ,
  PRIMARY KEY (`brok_item_id`) ,
  INDEX `fk_busi_sales_brokerage_item_busi_sales_item1_idx` (`sales_item_id` ASC) ,
  CONSTRAINT `fk_table1_busi_percent1`
    FOREIGN KEY (`brok_id` )
    REFERENCES `msneg`.`busi_sales_brokerage` (`brok_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_busi_sales_brokerage_item_busi_sales_item1`
    FOREIGN KEY (`sales_item_id` )
    REFERENCES `msneg`.`busi_sales_item` (`sales_item_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `msneg`.`busi_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `msneg`.`busi_orders` ;

CREATE  TABLE IF NOT EXISTS `msneg`.`busi_orders` (
  `orders_id` INT NOT NULL AUTO_INCREMENT COMMENT '主键' ,
  `client_id` INT NOT NULL COMMENT '客户ID' ,
  `orders_type_keys` VARCHAR(255) NULL COMMENT '定金类型' ,
  `orders_remarks` VARCHAR(255) NULL COMMENT '备注' ,
  `orders_use_key` VARCHAR(255) NULL COMMENT '定金用途' ,
  `orders_return_key` VARCHAR(255) NULL COMMENT '定金返还' ,
  `orders_sum` INT NULL COMMENT '总金额' ,
  `orders_cash` INT NULL COMMENT '现金' ,
  `orders_card` INT NULL COMMENT '刷卡' ,
  `other_remarks` VARCHAR(255) NULL COMMENT '其他信息部分' ,
  PRIMARY KEY (`orders_id`) ,
  INDEX `fk_busi_orders_busi_client1_idx` (`client_id` ASC) ,
  CONSTRAINT `fk_busi_orders_busi_client1`
    FOREIGN KEY (`client_id` )
    REFERENCES `msneg`.`busi_client` (`client_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `msneg` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
