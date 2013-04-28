/**
 * 对form表单的值进行验证操作,提供了2种验证操作, <code>
 * 1,自己取值进行验证
 * 2,对已知(赋值)的值进行验证
 * 
 * 第一种:自己取值进行验证
 * 		var ck = new CheckObj();

		ck.add("select1", "表名称", ck.CHECK_MAXLENGTH, 128, 1);
		ck.add("select1", "表名称", ck.CHECK_NULL);
		
		ck.add("layer_1_form_ENUMCLASS", "枚举类", ck.CHECK_MAXLENGTH, 128, 1);
		ck.add("layer_1_form_BEANID", "自定义BEANID", ck.CHECK_MAXLENGTH, 128, 1);
		ck.add("layer_1_form_PATHJSP", "页面路径", ck.CHECK_MAXLENGTH, 128, 1);

		ck.add("layer_1_form_PATHJS", "js路径", ck.CHECK_MAXLENGTH, 256, 1);

		ck.add("layer_1_form_TITLE", "标题", ck.CHECK_NULL);
		ck.add("layer_1_form_TITLE", "标题", ck.CHECK_MAXLENGTH, 32, 1);

		if (ck.doCheck() == 0) {
			return false;
		}
		
	第二种:	对已知(赋值)的值进行验证
		var ck = new CheckObj();

		var mapArray=form2Map('edit_createpage_form','');
		
		ck.addVal(mapArray['TABLENAME'][0], "表名称", ck.CHECK_MAXLENGTH, 128, 1);
		ck.addVal("", "表名称", ck.CHECK_NULL);
		
		ck.addVal("", "枚举类", ck.CHECK_MAXLENGTH, 128, 1);
		ck.addVal("beanid", "自定义BEANID", ck.CHECK_MAXLENGTH, 128, 1);
		ck.addVal("/app/hello/", "页面路径", ck.CHECK_MAXLENGTH, 128, 1);

		ck.addVal("/html/pf/", "js路径", ck.CHECK_MAXLENGTH, 256, 1);

		ck.addVal("我是标题", "标题", ck.CHECK_NULL);
		ck.addVal("我是标题", "标题", ck.CHECK_MAXLENGTH, 32, 1);

		if (ck.doCheckVal() == 0) {
			return false;
		}
 * </code>
 * 
 * 
 * 
 * 
 * 
 * 
 */
function CheckObj() {
	this.checkfields = new Array();

	/**
	 * 想获取对象值,再进行检查操作,验证通过add()注册的数据
	 * 
	 * @param {int}
	 *            errorThenReturn 遇到错误是否直接退出标记 值为1时遇错退出
	 */
	this.doCheck = function(errorThenReturn) {
		return this.checkallfields(this.checkfields);
	};

	/**
	 * 根据已经设置好的值进行验证操作.验证通过addVal()注册的数据
	 * 
	 * @param {int}
	 *            errorThenReturn 遇到错误是否直接退出标记 值为1时遇错退出
	 */
	this.doCheckVal = function(errorThenReturn) {
		return this.checkVal(this.checkfields);
	};

	/**
	 * 字段校验
	 * 
	 * @param {String}
	 *            fieldname Form字段的id或者name,如果是多选,参数为name否则应该为id
	 * @param {String}
	 *            fieldname_cn Form字段中文名称
	 * @param {int}
	 *            checktype 校验类型 NULL_CHECK-非空校验 NUM_CHECK-数字校验 3-日期校验 4-身份证号校验
	 *            5-长度校验 6-日期时间校验 7-小于他时间比较 8-大于其他时间 9-检测号牌号码 10-非空且不允许有特异字符
	 *            11-车辆类型校验
	 * @param {}
	 *            otherinfo
	 * @param {int}
	 *            canfocus 错误后是否允许聚焦 =1代表对一个错误进行聚焦
	 */
	this.add = function(fieldname, fieldname_cn, checktype, otherinfo, canfocus) {

		this.checkfields.push(new doCheckField(fieldname, fieldname_cn,
				checktype, otherinfo, canfocus));
	};
	/**
	 * 对字段的值进行校验
	 * 
	 * @param {String}
	 *            formVal Form字段具体的value值
	 * @param {String}
	 *            fieldname_cn Form字段中文名称
	 * @param {int}
	 *            checktype 校验类型 NULL_CHECK-非空校验 NUM_CHECK-数字校验 3-日期校验 4-身份证号校验
	 *            5-长度校验 6-日期时间校验 7-小于他时间比较 8-大于其他时间 9-检测号牌号码 10-非空且不允许有特异字符
	 *            11-车辆类型校验
	 * @param {}
	 *            otherinfo
	 * @param {int}
	 *            canfocus 错误后是否允许聚焦 =1代表对一个错误进行聚焦
	 */
	this.addVal = function(formVal, fieldname_cn, checktype, otherinfo) {

		this.checkfields.push(new doCheckField('', fieldname_cn, checktype,
				otherinfo, 0, formVal));
	};

	/**
	 * 检查arr中所有字段
	 * 
	 * @param {Array
	 *            <doCheckField>} arr 需要检查的doCheckField对象数组,
	 * @param {int}
	 *            errorThenReturn 遇到错误是否直接退出标记 值为1时遇错退出
	 * @return {Number}0=有错误，1=没有错误
	 */
	this.checkallfields = function(arr, errorThenReturn) {
		var obj;
		var errfield;
		var result = "";
		var len = arr.length;

		// log('len='+len);
		for (var i = 0; i < len; i++) {
			obj = arr[i];
			obj.checkdata(this);

			// log(obj._fieldname + obj._checktype + obj._result +
			// obj._resultdesc);
			if (obj._result != 1) {
				// 对第一个进行焦点
				if (obj._canfocus == 1 && errfield == undefined) {
					// if (obj._formname != "") {
					// errfield =
					// document.all[obj._formname].all[obj._fieldname];
					// } else {

					errfield = getS(obj._fieldname);

					// }
				}
				result = result + obj._resultdesc + "\n";
				if (errorThenReturn == 1) {
					break;
				}
			}
		}
		if (result != "") {
			if (errfield != undefined) {
				errfield.focus();
			}

			// log('提示:' + result);
			alert(result);
			return 0;
		} else {
			return 1;
		}
	};
	/**
	 * 验证传人的值是否正确
	 * 
	 * @param {Array
	 *            <doCheckField>} arr 需要检查的doCheckField对象数组,
	 * @param {int}
	 *            errorThenReturn 遇到错误是否直接退出标记 值为1时遇错退出
	 * @return {Number}0=有错误，1=没有错误
	 */
	this.checkVal = function(arr, errorThenReturn) {
		var obj;
		var errfield;
		var result = "";
		var len = arr.length;

		// log('len='+len);
		for (var i = 0; i < len; i++) {
			obj = arr[i];
			obj.checkValue(obj._tmpVal, this);

			// log(obj._fieldname + obj._checktype + obj._result +
			// obj._resultdesc);
			if (obj._result != 1) {
				// 对第一个进行焦点
				if (obj._canfocus == 1 && errfield == undefined) {

					errfield = getS(obj._fieldname);

				}
				result = result + obj._resultdesc + "\n";
				if (errorThenReturn == 1) {
					break;
				}
			}
		}
		if (result != "") {
			if (errfield != undefined) {
				errfield.focus();
			}

			// log('提示:' + result);
			alert(result);
			return 0;
		} else {
			return 1;
		}
	};
	/**
	 * 验证是否为null 单个函数 _checknull或者checknull
	 * 
	 * @type Number
	 */
	this.CHECK_NULL = 1;
	/**
	 * 验证数字 单个函数 _checknum或者checknum
	 * 
	 * @type Number
	 */
	this.CHECK_NUMBER = 2;
	/**
	 * 验证日期 _checkdate或者checkdate
	 * 
	 * @type Number
	 */
	this.CHECK_DATE = 3;
	/**
	 * 身份证明号码 _checkallsfzmhm或者checkallsfzmhm
	 * 
	 * @type Number
	 */
	this.CHECK_SFZMHM = 4;

	/**
	 * 长度 _checklength或者checklength
	 * 
	 * @type Number
	 */
	this.CHECK_LENGTH = 5;

	/**
	 * 时间 _checkdate1或者checkdate1
	 * 
	 * @type Number
	 */
	this.CHECK_DATETIME = 6; // 
	/**
	 * 
	 * @type Number
	 */
	this.CHECK_LESS_DATETIME = 7;
	/**
	 * 
	 * @type Number
	 */
	this.CHECK_LARGE_DATETIME = 8;
	/**
	 * 号牌号码 _checkHphm或者checkHphm
	 * 
	 * @type Number
	 */
	this.CHECK_HPHM = 9; //
	/**
	 * _checkSpecilCharAndNull 包含英文字母和数字 或者checkSpecilCharAndNull
	 * 
	 * @type Number
	 */
	this.CHECK_SPECIAL_CHAR = 10; //

	/**
	 * 准驾车型 _check_zjcx 或者check_zjcx
	 * 
	 * @type Number
	 */
	this.CHECK_ZJCX = 11; //
	/**
	 * 证件号码检测 otherinfo是证件名称信息 A代表身份证 _check_zjhm 或者check_zjhm
	 * 
	 * @type Number
	 */
	this.CHECK_ZJHM = 12; // 
	/**
	 * 驾驶证证芯编号 //_zxbhCheck 或者zxbhCheck
	 * 
	 * @type Number
	 */
	this.CHECK_JSZZXBH = 13;// 
	/**
	 * IP地址校验 _checkIp 或者 checkIp
	 * 
	 * @type Number
	 */
	this.CHECK_IPDZ = 14;
	/**
	 * _checkminlength或者checkminlength
	 * 
	 * @type Number
	 */
	this.CHECK_MINLENGTH = 15;

	/**
	 * 检查电子邮箱 _checkemail或者checkmail
	 * 
	 * @type Number
	 */
	this.CHECK_EMAIL = 16;
	/**
	 * 检查手机号码 _checksjhm或者checksjhm
	 * 
	 * @type Number
	 */
	this.CHECK_SJHM = 17;
	/**
	 * 检查联系电话 _checklxdh或者checklxdh
	 * 
	 * @type Number
	 */
	this.CHECK_LXDH = 18;
	/**
	 * 全IP地址校验 _checkIpAll 或者 checkIpAll
	 * 
	 * @type Number
	 */
	this.CHECK_IPDZ_ALL = 19;
	/**
	 * 省份代码校验 _checkSfdm 或者 checkSfdm
	 * 
	 * @type Number
	 */
	this.CHECK_SFDM = 20;
	/**
	 * 检测必须为中文
	 * 
	 * @type Number
	 */
	this.CHECK_CHINESE = 21;
	/**
	 * 不大于最大长度的校验
	 * 
	 * @type Number
	 */
	this.CHECK_MAXLENGTH = 22;

	this.supportTypeMap = null;
	this.supportTypeList = null;
	/**
	 * 取得一个验证项的配置信息
	 * @param {} checkType
	 * @return {map} { id : '变量名类型名',
						name : '中文名',
						id1 : 内部值,
						id2 : '表达式'
					}
	 */
	this.getTypeConfig=function(checkType){
		var v=this.initST();
		return this.supportTypeMap[checkType]||{};
	},
	this.initST=function(){
		var v = this.supportTypeList;
		if (v === null) {
			v = [{
						id : 'CHECK_NULL',
						name : '验证为空',
						id1 : this.CHECK_NULL,
						/* 表达式 */
						id2 : 'CHECK_NULL'
					}, {
						id : 'CHECK_NUMBER',
						name : '验证数字',
						id1 : this.CHECK_NUMBER,
						id2 : 'CHECK_NUMBER'
					}, {
						id : 'CHECK_DATE',
						name : '验证日期',
						id1 : this.CHECK_DATE,
						id2 : 'CHECK_DATE'
					}, {
						id : 'CHECK_DATETIME',
						name : '日期和时间',
						id1 : this.CHECK_DATETIME,
						id2 : 'CHECK_DATETIME'
					}, {
						id : 'CHECK_LESS_DATETIME',
						name : '小于时间',
						id1 : this.CHECK_LESS_DATETIME,
						id2 : 'CHECK_LESS_DATETIME:?'
					}, {
						id : 'CHECK_LARGE_DATETIME',
						name : '大于时间',
						id1 : this.CHECK_LARGE_DATETIME,
						id2 : 'CHECK_LARGE_DATETIME:?'
					}, {
						id : 'CHECK_SFZMHM',
						name : '身份证明号码',
						id1 : this.CHECK_SFZMHM,
						id2 : 'CHECK_SFZMHM'
					}, {
						id : 'CHECK_HPHM',
						name : '号牌号码',
						id1 : this.CHECK_HPHM,
						id2 : 'CHECK_HPHM'
					}, {
						id : 'CHECK_SPECIAL_CHAR',
						name : '包含英文字母和数字',
						id1 : this.CHECK_SPECIAL_CHAR,
						id2 : 'CHECK_SPECIAL_CHAR'
					}, {
						id : 'CHECK_ZJCX',
						name : '准驾车型',
						id1 : this.CHECK_ZJCX,
						id2 : 'CHECK_ZJCX'
					}, {
						id : 'CHECK_ZJHM',
						name : '证件号码检测',
						id1 : this.CHECK_ZJHM,
						id2 : 'CHECK_ZJHM'
					}, {
						id : 'CHECK_JSZZXBH',
						name : '驾驶证证芯编号',
						id1 : this.CHECK_JSZZXBH,
						id2 : 'CHECK_JSZZXBH'
					}, {
						id : 'CHECK_IPDZ',
						name : '单IP地址校验',
						id1 : this.CHECK_IPDZ,
						id2 : 'CHECK_IPDZ'
					}, {
						id : 'CHECK_IPDZ_ALL',
						name : '全IP地址校验',
						id1 : this.CHECK_IPDZ_ALL,
						id2 : 'CHECK_IPDZ_ALL'
					}, {
						id : 'CHECK_LENGTH',
						name : '长度',
						id1 : this.CHECK_LENGTH,
						id2 : 'CHECK_LENGTH:?'
					}, {
						id : 'CHECK_MINLENGTH',
						name : '最小长度',
						id1 : this.CHECK_MINLENGTH,
						id2 : 'CHECK_MINLENGTH:?'
					}, {
						id : 'CHECK_MAXLENGTH',
						name : '最大长度',
						id1 : this.CHECK_MAXLENGTH,
						id2 : 'CHECK_MAXLENGTH:?'
					}, {
						id : 'CHECK_EMAIL',
						name : '检查电子邮箱',
						id1 : this.CHECK_EMAIL,
						id2 : 'CHECK_EMAIL'
					}, {
						id : 'CHECK_SJHM',
						name : '检查手机号码',
						id1 : this.CHECK_SJHM,
						id2 : 'CHECK_SJHM'
					}, {
						id : 'CHECK_LXDH',
						name : '检查联系电话',
						id1 : this.CHECK_LXDH,
						id2 : 'CHECK_LXDH'
					}, {
						id : 'CHECK_SFDM',
						name : '省份代码',
						id1 : this.CHECK_SFDM,
						id2 : 'CHECK_SFDM'
					}, {
						id : 'CHECK_CHINESE',
						name : '必须为中文',
						id1 : this.CHECK_CHINESE,
						id2 : 'CHECK_CHINESE'
					}];
			this.supportTypeList = v;
		}

		if (this.supportTypeMap === null) {
			this.supportTypeMap = {};
			for (var i = 0; i < v.length; i++) {
				var one = v[i];
				this.supportTypeMap[one.id] = one;
			}
		}
		return v;
	}
	/**
	 * 支持的类型
	 * 
	 * @return {}
	 */
	this.supportType = function(uitype) {
		var v=this.initST();
		if (!uitype) {
			return v;
		}
		var r = [];
		var key = [];
		switch (uitype) {
			case 'P' :
			case 'BR' :
			case 'DIV' :
			case 'SPAN' :
			case 'FILE' :
			case 'FLASH' :
			case 'HIDDEN' :
			case 'SLIDER' :
				break;
			case 'TEXT' :
			case 'TEXTAREA' :
				r = v;// 文本的最新 全部类型
				break;
			case 'CHOSEN_MULTI' :
			case 'SELECT_MULTI' :
			case 'CHECKBOX_MULTI' :
			case 'MULTISELECT_MULTI' :
			case 'EASYUICOMBOTREE_MULTI' :
				key = ['CHECK_NULL', 'CHECK_LENGTH', 'CHECK_MINLENGTH',
						'CHECK_MAXLENGTH'];
				break;
			case 'RADIO' :
			case 'CHOSEN_SINGLE' :
			case 'SELECT_SINGLE' :
			case 'MULTISELECT_SINGLE' :
			case 'EASYUICOMBOTREE_SINGLE' :
				key = ['CHECK_NULL', 'CHECK_LENGTH', 'CHECK_MINLENGTH',
						'CHECK_MAXLENGTH'];
				break;
			case 'DATE' :
			case 'DATETIME' :
			case 'TIMESPINNER' :
				key = ['CHECK_NULL', 'CHECK_DATE', 'CHECK_DATETIME',
						'CHECK_LESS_DATETIME', 'CHECK_LARGE_DATETIME'];
				break;
			case 'NUMBERBOX' :
			case 'NUMBERSPINNER' :
				key = ['CHECK_NULL'];
				break;
		}

		// 根据key查找类型
		for (var i = 0; i < key.length; i++) {
			r.push(this.supportTypeMap[key[i]]);
		}

		return r;
	}
}

/**
 * 字段校验
 * 
 * @param {String}
 *            fieldname Form字段的id或者name,如果是多选,参数为name否则应该为id
 * @param {String}
 *            fieldname_cn Form字段中文名称
 * @param {int}
 *            checktype 校验类型 NULL_CHECK-非空校验 NUM_CHECK-数字校验 3-日期校验 4-身份证号校验
 *            5-长度校验 6-日期时间校验 7-小于他时间比较 8-大于其他时间 9-检测号牌号码 10-非空且不允许有特异字符
 *            11-车辆类型校验
 * @param {}
 *            otherinfo
 * @param {int}
 *            canfocus 错误后是否允许聚焦 =1代表对一个错误进行聚焦
 * @param{String}tmpVal 记录的值,用来处理已经获取到值进行的验证,就不需要getVal的操作了
 */
function doCheckField(fieldname, fieldname_cn, checktype, otherinfo, canfocus,
		tmpVal) {
	this._fieldname = fieldname;
	this._fieldname_cn = fieldname_cn;
	this._checktype = checktype;
	this._otherinfo = otherinfo;
	this._canfocus = canfocus;
	this._result = 0;
	this._resultdesc = "";
	this._errorinfo = "";
	this._disabledfield = ""; // 控制是否失效字段
	this._disabledvalue = ""; // 控制是否失效字段值
	this._enabledfield = ""; // 控制是否有效字段
	this._enabledvalue = ""; // 控制是否有效字段值
	this._otherfield = "";// 其他比较字段
	this._formname = "";// 指定Formname

	this._tmpVal = tmpVal;

};

/**
 * 
 * @param {CheckObj}
 *            ck
 */
doCheckField.prototype.checkdata = function(ck) {

	if (this._checktype == undefined) {
		this._resultdesc = "请定义this._checktype对象";
		return;
	}
	var value1;
	var k;

	var fieldObj = getS(this._fieldname);

	if (!fieldObj[0]) {
		this._result = 0;
		this._resultdesc = "没找到id为'" + this._fieldname + "'的表单对象";
		return;
	}

	// log('this._fieldname='+this._fieldname+"\t"+this._checktype);

	switch (this._checktype) {
		case ck.CHECK_ZJCX :
		case ck.CHECK_SFZMHM :
		case ck.CHECK_ZJHM :

			if (this._formname == "") {

				var val = fieldObj.val().toUpperCase();

				fieldObj.val(val);
			} else {
				// document.all[this._formname].all[this._fieldname].value =
				// document.all[this._formname].all[this._fieldname].value
				// .toUpperCase();

				var val = getTextValue(this._fieldname).toUpperCase();
				changeTxtValue(this._fieldname, val);
			}

			break;
	}

	// log("val=" + fieldObj.val());
	if (isdebug())
		log("checkdata.val=" + fieldObj.val());
	// if (this._formname == "") {
	value1 = jax.util.trim(fieldObj.val());
	fieldObj.val(value1);

	this.checkValue(value1, ck);
};
/**
 * 拼凑错误的文本描述
 * 
 * @param {String}
 *            result
 */
doCheckField.prototype.addErrDesc = function(result) {
	this._result = 0;
	if (this._errorinfo == "")
		this._resultdesc = this._fieldname_cn + result;
	else
		this._resultdesc = this._errorinfo;
};

/**
 * 验证表单对象的值
 * 
 * @param {}
 *            value1
 * @param {}
 *            ck
 */
doCheckField.prototype.checkValue = function(value1, ck) {

	// log("value1=" + value1);
	// } else {
	// document.all[this._formname].all[this._fieldname].value =
	// document.all[this._formname].all[this._fieldname].value
	// .trim();
	// value1 = document.all[this._formname].all[this._fieldname].value;
	// }
	var result;
	if (this._disabledfield != "") {
		// alert(this._disabledfield);
		// alert(document.all[this._disabledfield].value);
		// alert(this._disabledvalue);
		var arr = this._disabledvalue.split(",");
		for (var k = 0; k < arr.length; k++) {
			if ((getTextValue(this._disabledfield) + "") == arr[k]) {
				this._result = 1;
				return;
			}
		}
	}
	if (this._enabledfield != "") {
		// alert(this._enabledfield);
		// alert(this._enabledvalue);
		// alert(document.all[this._enabledfield].value);
		if (getTextValue(this._enabledfield) != this._enabledvalue) {
			this._result = 1;
			return;
		}
	}
	if (this._otherfield != "") {
		// if (this._formname == "") {
		this._otherinfo = getTextValue(this._otherfield);
		// } else {
		// this._otherinfo =
		// document.all[this._formname].all[this._otherfield].value;
		// }
	}

	if (isdebug())
		log('this._checktype=' + this._checktype);
	switch (this._checktype) {
		case ck.CHECK_NULL :
			// 非空校验
			result = jax.util._checknull(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);

			}
			break;
		case ck.CHECK_NUMBER :
			// 数字
			result = jax.util._checknum(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_DATE :
			// 日期校验
			result = jax.util._checkdate(value1);
			if (result == "1") {
				if (value1 && value1.length == 8) {
					// if (this._formname == "") {
					var tmpVal = value1.substr(0, 4) + "-"
							+ value1.substr(4, 2) + "-" + value1.substr(6, 2);
					changeTxtValue(this._fieldname, tmpVal);
					// } else {
					// document.all[this._formname].all[this._fieldname].value =
					// value1
					// .substr(0, 4)
					// + "-"
					// + value1.substr(4, 2)
					// + "-"
					// + value1.substr(6, 2)
					// }
				}
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_SFZMHM :
			// 身份证号校验
			result = jax.util._checkallsfzmhm(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_LENGTH :
			// 长度校验
			result = jax.util._checklength(value1, this._otherinfo);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;

		case ck.CHECK_MAXLENGTH :// 不大于最大长度

			result = jax.util._checkMaxlength(value1, this._otherinfo);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;

		case ck.CHECK_DATETIME :
			// 日期时间校验
			result = jax.util._checkdate1(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this._result = 0;
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_LESS_DATETIME :
			// 小于等于目标值
			if (value1 == "") {
				this._result = 1;
				break;
			}
			if (typeof(this._otherinfo) == "object") {
				if (value1 <= this._otherinfo.value) {
					this._result = 1;
				} else {
					this._result = 0;
				}
			} else {
				if (value1 <= this._otherinfo) {
					this._result = 1;
				} else {
					this._result = 0;
				}
			}
			if (this._result == 0) {
				if (this._errorinfo == "") {
					if (typeof(this._otherinfo) == "object") {
						this._resultdesc = this._fieldname_cn + "必须小于"
								+ this._otherinfo.value + "！";
					} else {
						this._resultdesc = this._fieldname_cn + "必须小于"
								+ this._otherinfo + "！";
					}
				} else
					this._resultdesc = this._errorinfo;
			}
			break;
		case ck.CHECK_LARGE_DATETIME :
			// 大于目标值
			if (value1 == "") {
				this._result = 1;
				break;
			}
			if (typeof(this._otherinfo) == "object") {
				if (value1 > this._otherinfo.value) {
					this._result = 1;
				} else {
					this._result = 0;
				}
			} else {
				if (value1 > this._otherinfo) {
					this._result = 1;
				} else {
					this._result = 0;
				}
			}
			if (this._result == 0) {
				if (this._errorinfo == "") {
					if (typeof(this._otherinfo) == "object") {
						this._resultdesc = this._fieldname_cn + "必须大于"
								+ this._otherinfo.value + "！";
					} else {
						this._resultdesc = this._fieldname_cn + "必须大于"
								+ this._otherinfo + "！";
					}
				} else
					this._resultdesc = this._errorinfo;
			}
			break;
		case ck.CHECK_HPHM :
			result = jax.util._checkHphm(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_SPECIAL_CHAR :
			result = jax.util._checkSpecilCharAndNull(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_ZJCX :
			result = jax.util._check_zjcx(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this._result = 0;
				this._resultdesc = this._fieldname_cn + "不合法!";
			}
			break;
		case ck.CHECK_ZJHM :
			if (typeof(this._otherinfo) == "object") {
				result = jax.util._check_zjhm(this._otherinfo.value, value1);
			} else {
				result = jax.util._check_zjhm(this._otherinfo, value1);
			}
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_JSZZXBH :
			result = jax.util._zxbhCheck(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_IPDZ :
			result = jax.util._checkIp(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_MINLENGTH :
			result = jax.util._checkminlength(value1, this._otherinfo);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_EMAIL :
			result = jax.util._checkEmail(value1);
			log(value1 + '  result=' + result);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_SJHM :
			result = jax.util._checksjhm(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_LXDH :
			result = jax.util._checklxdh(value1, this._otherinfo);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_IPDZ_ALL :
			result = jax.util._checkIpAll(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
		case ck.CHECK_CHINESE :
			result = jax.util._checkChinese(value1);
			if (result == "1") {
				this._result = 1;
			} else {
				this.addErrDesc(result);
			}
			break;
	}
};
var jax = {
	/** 工具方法 */
	util : {
		isEmpty : function(v, allowBlank) {
			return v === null || v === undefined
					|| (!allowBlank ? v === "" : false)
		},
		/**
		 * 判断数组时候为空
		 * 
		 * @param {}
		 *            v
		 * @return {true=空,false=非空}
		 */
		isEmptyArray : function(v) {
			return v === null || v === undefined || (v.length <= 0);
		},
		/**
		 * 判断如果 text 字符串 为空就返回 ''
		 * 
		 * @param {String}
		 *            text
		 */
		sNull : function(text) {
			return this.isEmpty(text) ? "" : text;
		},

		/**
		 * <code>
		 * var CURDEnum={"C2_ADD":2,"UPDATE":"update","C3_UPDATE":3,"QUERY":"QUERY","DELETE":"delete","INSERT":"insert","C1_QUERY":1,"C4_DEL":4};
		 * </code>
		 */
		parseJsDefineEnum : function(enumDicts) {
			// {"color":"#009900","state":"1","fieldName":"C1_QUERY","chName":"查询"}
			var map = {};
			for (var i = 0; i < enumDicts.length; i++) {
				var one = enumDicts[i];
				map[one.fieldName] = one.state;
			}
			return map;
		},
		/**
		 * 根据数据字典,从而把数据字典的数组[]形式的数据,转换为 按照 theKey结构的{}类型的数据
		 * 
		 * @param {}
		 *            dictType String 或者数组方式的数据字典对象 格式同 _dictTypes[dictType]
		 * @param {}
		 *            theKey 按照哪个数据字典列进行构造数据 默认为id,可选值包括 id1-7,name,pid
		 * @param {boolean
		 *            }clone 是否对数据clone
		 * @return {}
		 */
		dictMap : function(dictType, theKey, clone) {
			var dicts = {};
			if (jQuery.type(dictType) === "string") {
				dicts = _dictTypes[dictType];
			} else {
				dicts = dictType;
			}
			var dict = jax.util.parseMappingRenderData(dicts, theKey, function(
							map) {
						if (clone) {
							return jQuery.extend({}, map);
						}
						return map;
					});
			return dict;
		},
		/**
		 * <code>
		 * var xtlbRenderer=jax.util.mappingRenderer(
		 * jax.util.parseMappingRenderData(_dictTypes.PF_XTLB) );
		 * 
		 * 
		 * 
		 * var xtlbRenderer=jax.util.mappingRenderer(
		 * jax.util.parseMappingRenderData(_dictTypes.PF_XTLB,'id',['id','name']));
		 * 
		 * 
		 * 
		 * var xtlbRenderer=jax.util.mappingRenderer(
		 * jax.util.parseMappingRenderData(_dictTypes.PF_XTLB,'id',
		 * 		function (data){ 
		 * 			return "("+data['id']+")"+data['name']; 
		 * 		})
		 * );
		 * </code>
		 * 
		 * @param {Map}
		 *            dict
		 * @param {String}
		 *            idKey
		 * @param {String/array/function(oneDictMap)}
		 *            viewKeys
		 */
		parseMappingRenderData : function(dict, idKey, viewKeys) {
			var v = {};
			if (!dict)
				return v;
			if (!idKey) {
				idKey = "id";
			}
			if (!viewKeys) {
				viewKeys = "name";
			}

			var idIsStr = jQuery.type(idKey) === "string";
			var idIsFunc = jQuery.isFunction(idKey);
			var idIsArray = jQuery.isArray(idKey);
			function getKey(one) {
				return _2get(one, idKey, idIsStr, idIsFunc, idIsArray);
			}
			var vkIsStr = jQuery.type(viewKeys) === "string";
			var vkIsFunc = jQuery.isFunction(viewKeys);
			var vkIsArray = jQuery.isArray(viewKeys);
			function getVal(one) {
				return _2get(one, viewKeys, vkIsStr, vkIsFunc, vkIsArray);
			}
			function _2get(map, key, keyIsStr, keyIsFunc, keyIsArray) {

				// 对应枚举对象进行控制
				if (map.fieldName && keyIsStr) {
					if (key === 'id') {
						key = "state";
					} else if (key === 'name') {
						key = "chName";
					}
				}
				var v = '';
				// 是函数
				if (keyIsStr) {
					v = map[key];
				} else if (keyIsFunc) {
					v = key(map);
				} else if (keyIsArray) {
					var t = [];
					for (var i = 0; i < key.length; i++) {
						t.push(map[key[i]]);
					}
					if (t.length == 2) {
						v = "(" + t[0] + ")" + t[1];
					} else {
						v = t.join(' ');
					}
				}
				return v;
			}
			for (var i = 0; i < dict.length; i++) {
				var one = dict[i];
				var key = getKey(one);
				var val = getVal(one);
				v[key] = val;
			}
			return v;
		},
		dictRenderer : function(dictObjOrKey) {
			var dict;
			var type = jQuery.type(dictObjOrKey);
			if (type === "string") {
				dict = _dictTypes[dictObjOrKey];
			} else {
				dict = dictObjOrKey;
			}
			// 先把数据字典转换为render识别的形式
			return jax.util.mappingRenderer(jax.util
					.parseMappingRenderData(dict));
		},
		/**
		 * 例子:<br>
		 * 1,定义 render:<br>
		 * var dvdMoneyStateRenderer=jax.util.mappingRenderer(
		 * {'0':'未付款','1':'已付款','2':'无效汇款'},'未定义' );
		 * 
		 * 2,使用render,<br>
		 * alert( '对于状态1的描述是:'+dvdMoneyStateRenderer('1') ); 程序就会 输出 '已付款'
		 * 这句了.从而达到map的效果
		 * 
		 * 
		 * java: <br>
		 * var awardState=jax.util.mappingRenderer(
		 * <%=EnumEx.getGTMappingRenderer((IState[]) AwardStateEnum.values())%> );
		 * 
		 * 调用的时候提供第二个参数:来取代操作的类型,目前支持 keys,values, 得到 array数组对象
		 * 
		 * var keys=render_cllb2('','keys');
		 * 
		 * 例子: <code>
		 * 	var render_sczt = jax.util.mappingRenderer({
						'0' : '初始',
						'1' : '采集完成',
						'2' : '需重新采集',
						'3' : '重新采集完成',
						'6' : '已上传'
					}, '未定义');

			var keys = render_sczt('', 'keys');
			console.debug("render_keys=" + json(keys));//输出 render_keys=["0","1","2","3","6"]
			
			var values = render_sczt('', 'values');
			console.debug("render_values=" + json(values));//输出 render_values=["初始","采集完成","需重新采集","重新采集完成","已上传"]

			console.debug(' keys.length=' + keys.length);
			for (var i = 0; i < keys.length; i++) {
				console.debug('j=' + i + "\tkeys=" + keys[i] + "\tvalue="
						+ render_sczt(keys[i]));
			}
		以下是输出的内容:
			render_keys=["0","1","2","3","6"]
			render_values=["初始","采集完成","需重新采集","重新采集完成","已上传"]
			keys.length=5
			j=0 keys=0 value=初始
			j=1 keys=1 value=采集完成
			j=2 keys=2 value=需重新采集
			j=3 keys=3 value=重新采集完成
			j=4 keys=6 value=已上传
		 * </code>
		 * 
		 * @param {}
		 *            json
		 * @param {}
		 *            defaultVal
		 * @return {function} 能够进行 从 json 中取得对应关系的 方式操作
		 */
		mappingRenderer : function(_json, defaultVal) {
			/**
			 * @param keyOrValueInJson
			 *            key或者value值.
			 * @param type,操作类型,包括
			 * 
			 * <pre>
			 * { 	
			 * 		keys:json的key列表 , 
			 * 		values:json的value列表,
			 *      byvalue:通过value取key, 
			 *      editoptions: 用于jqgrid的editoptions格式,比如 1:男;2:女
			 * }
			 * </pre>
			 * 
			 */
			return function(keyOrValueInJson, type) {
				if (_json == null) {
					return jax.util.sNull(defaultVal);
				}
				if (type) {
					if ('keys' == type) {
						var keys = [];
						for (var i in _json) {
							keys.push(i);
						}
						return keys;
					} else if ('values' == type) {
						var v = [];
						for (var i in _json) {
							v.push(_json[i]);
						}
						return v;
					} else if ('byvalue' == type) {
						// 通过值来取得key
						for (var i in _json) {
							var noHtml = jax.string.removeHtml(_json[i]);
							if (noHtml == keyOrValueInJson) {
								return i;
							}
						}
						return 'unknow';
					} else if ('editoptions' == type) {
						// 1:男;2:女
						var a = [], f = '{val}:{view}';
						for (var i in _json) {
							var noHtml = jax.string.removeHtml(_json[i]);
							a.push(f.format({
										'val' : i,
										'view' : noHtml
									}));
						}
						return a.join(';');
					}
					// return
					// '';//如果未匹配就继续往下走,因为在grid中也要用到这个render对象,但是grid的render函数有多个参数.所以不匹配就进行render原本的操作
				}

				if (keyOrValueInJson == null) {
					return defaultVal;
				} else
					return _json[keyOrValueInJson]
							|| (defaultVal === undefined || defaultVal === null
									? keyOrValueInJson
									: defaultVal + '(' + keyOrValueInJson + ')');
			};
		},

		/**
		 * 返回一个本次 页面中的不相同的数值
		 */
		getNextId : function() {
			SYS_RANDOM_NEXT_ID++;
			return SYS_RANDOM_NEXT_ID;
		},
		/**
		 * money判断函数，允许第一位为"-"来表示欠钱 返回true表示格式正确，返回false表示格式错误
		 */
		isMoney : function(str) {
			if ("" == str) {
				return false;
			}
			var tmp;
			if (str == "")
				return true;
			var re = /^[\-\+]?([0-9]\d*|0|[1-9]\d{0,2}(,\d{3})*)(\.\d+)?$/;
			return re.test(str);
		}

		,
		/**
		 * 数字判断函数，返回true表示是全部数字，返回false表示不全部是数字
		 */
		isNumber : function(str) {
			if ("" == str) {
				return false;
			}
			var reg = /\D/;
			return str.match(reg) == null;
		},
		/**
		 * 压缩空格
		 * 
		 * @param {}
		 *            txt
		 * @return {}
		 */
		trim : function(txt) {
			return $.trim(txt);
		},
		/**
		 * 判断邮箱的格式是否正确, 返回true表示不是邮件,false表示是邮件
		 */
		notEmail : function(strEmail) {
			if (strEmail
					.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
				return false;
			else
				return true;
		},
		/*
		 * 电话判断函数，允许“数字”、“;”、“-”、“(”、”)“， true表示是电话号码
		 */
		isTelephone : function(str) {
			var trueChar = "()-;1234567890";
			if ("" == str) {
				return false;
			}
			for (var i = 0; i < str.length; i++) {
				var c = str.charAt(i); // 字符串str中的字符
				if (trueChar.indexOf(c) == -1)
					return false;
			}
			return true;
		},

		/*
		 * 判断用户名是否为数字、字母、下划线
		 */
		notChinese : function(str) {
			var reg = /[^A-Za-z0-9_]/g
			if (reg.test(str)) {
				return (false);
			} else {
				return (true);
			}
		},
		/*
		 * 中文判断函数，允许生僻字用英文“*”代替 返回true表示是符合条件，返回false表示不符合
		 */
		isChinese : function(str) {
			var badChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			badChar += "abcdefghijklmnopqrstuvwxyz";
			badChar += "0123456789";
			badChar += ".@-_";
			if ("" == str) {
				return false;
			}
			for (var i = 0; i < str.length; i++) {
				var c = str.charAt(i);
				if (badChar.indexOf(c) > -1) {
					return false;
				}
			}
			return true;
		},

		/* 判断是否是数字 */
		checkRate : function(input) {
			var re = /^[0-9]+.?[0-9]*$/;
			if (!re.test(input.rate.value)) {
				alert("请输入数字(例:0.02)");
				input.rate.focus();
				return false;
			}
		},

		/*
		 * 判断给定的字符串是否为指定长度的数字 是返回true，不是返回false
		 */
		isNumber_Ex : function(str, len) {
			if ("" == str) {
				return false;
			}
			if (str.length != len) {
				return false;
			}
			if (!isNumber(str)) {
				return false;
			}
			return true;
		},
		/*
		 * 英文判断函数，返回true表示是全部英文，返回false表示不全部是英文
		 */
		isLetter : function(str) {
			if ("" == str) {
				return false;
			}
			for (var i = 0; i < str.length; i++) {
				var c = str.charAt(i);
				if ((c < "a" || c > "z") && (c < "A" || c > "Z")) {
					return false;
				}
			}
			return true;
		},
		/*
		 * 空格判断，当包含有空格返回false，当不包含一个空格返回true ""不能被判断
		 */
		notInSpace : function(str) {
			if ("" == str) {
				return false;
			}
			var badChar = " ";
			badChar += "　";
			for (var i = 0; i < str.length; i++) {
				var c = str.charAt(i);// 字符串str中的字符
				if (badChar.indexOf(c) > -1) {
					return false;
				}
			}
			return true;
		},

		/**
		 * 学制可以为1-7，也可以为3.5这种形式，不能超过7年或者低于1年
		 */
		isXZ : function(str) {
			if ("" == str) {
				return false;
			}
			var reg = /^[1-6](\.5)?$/;
			var r = str.match(reg);
			if (null != r) {
				return true;
			} else {
				if (str == "7") {
					return true;
				} else {
					return false;
				}
			}
		},
		/*
		 * 身份证判断函数，是返回true，不是返回false 15位数字，18位数字或者最后一位为X（大写）
		 */
		isSFZ : function(str) {
			if ("" == str) {
				return false;
			}
			if (str.length != 15 && str.length != 18) {// 身份证长度不正确
				return false;
			}
			if (str.length == 15) {
				if (!isNumber(str)) {
					return false;
				}
			} else {
				var str1 = str.substring(0, 17);
				var str2 = str.substring(17, 18);
				var alpha = "X0123456789";
				if (!isNumber(str1) || alpha.indexOf(str2) == -1) {
					return false;
				}
			}
			return true;
		},

		/**
		 * 判断是否数字 三种调用方式: 1.一个参数,简单判断是否为数字,但长度不超过10位 2.三个参数,第二个参数为 '>'(大于) 或 '<'(小于),第3个参数为要比较的数字
		 * 3.三个参数，第二个参数与第三个参数均为整数，判断传入的第一个参数值是否在他们中间。（含边界）
		 */
		judgeDigit : function() {
			var s = arguments[0];
			if (arguments.length == 1) {
				return isDigit(s);
			} else if (arguments.length == 3) {
				// 通过验证
				var patrn = /^-?[0-9]{1,10}$/;
				if (patrn.test(s)) {
					var p1 = arguments[1];
					var sint = parseInt(s);
					if (isDigit(arguments[2])) {
						var pint = parseInt(arguments[2]);
						if (p1 == '>' || p1 == '<') {
							if (p1 == '>') {
								return sint > pint;
							} else if (p1 == '<') {
								return sint < pint;
							}
						} else if (isDigit(p1)) {
							var pmin = parseInt(p1);
							return (sint >= pmin) && (sint <= pint);
						} else {
							alert('arguments error,the 2nd argument is not a number and not an operation:greater|less|equals.');
						}
					} else {
						alert('arguments error,the 3rd argument is not a number.');
					}
				}
			}
			return false;
		},
		/**
		 * 是否数字
		 */
		isDigit : function(s) {
			var patrn = /^-?[0-9]{1,10}$/;
			return patrn.test(s);
		},
		/**
		 * 判断标识符或是登录名，以字母开头,可带数字、"_"、"." 的字串
		 * 限定最小长度(第二个参数)与最大长度(第三个参数)(默认为2--32位)
		 * 
		 * @param string
		 * @param min
		 *            length
		 * @param max
		 *            length
		 */
		isSignName : function() {
			var s = arguments[0];
			if (arguments.length == 1) {
				var patrn = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){1,31}$/;
				return patrn.test(s);
			} else if (arguments.length == 3) {
				if (isDigit(arguments[1]) && isDigit(arguments[2])) {
					eval("var patrn=/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){"
							+ (parseInt(arguments[1]) - 1) + ","
							+ (parseInt(arguments[2]) - 1) + "}$/;");
					return eval("patrn.test(s);");
				} else {
					alert('Error:the 2nd argument and the 3rd argument must be number.');
					return false;
				}
			} else {
				alert('method invoke error.error arguments number.');
				return false;
			}
		},
		/**
		 * 判断是否是真实姓名
		 */
		isRealName : function(s) {
			var patrn = /^([a-zA-Z0-9]|[._ ]){2,64}$/; // 英文名
			var p2 = /^([^\x00-\xff]|[\s]){2,32}$/; // 双字节名
			return patrn.test(s) || p2.test(s);
		},
		/**
		 * 电话号码 必须以数字开头，除数字外，可含有"-"
		 */
		isTel : function(s) {
			var patrn = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
			return patrn.test(s);
		},
		/** 中国大陆地区手机号码 以13或15开头，使用时请根据变化修改 校验普通电话，除数字外，可用"-"或空格分开 */
		isMobileCN : function(s) {
			var patrn = /^1[3|5|8]{1}[0-9]{1}[-| ]?\d{8}$/;
			return patrn.test(s);
		},
		/** 中国地区邮编 */
		isPostalCodeCN : function(s) {
			var patrn = /^[1-9]\d{5}$/;
			return patrn.test(s);
		},
		/**
		 * 验证电子邮件
		 * 
		 * @param {}
		 *            s
		 * @return {Boolean} true=验证成功,false=验证失败
		 */
		isEmail : function(s) {
			if (jax.util.isEmpty(s))
				return false;
			if (s
					.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
				return true;
			else
				return false;

		},
		/** URL */
		isURL : function(s) {
			var patrn = /^http:\/\/([\w-]+(\.[\w-]+)+(\/[\w-   .\/\?%&=\u4e00-\u9fa5]*)?)?$/;
			return patrn.test(s);
		},
		/**
		 * IP
		 */
		isIP : function(s) {
			var patrn = /^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/;
			return patrn.test(s);
		},
		/**
		 * 是否是完整的正则表达式 只有开始标记与结束标记相匹配才为TRUE HTML Tag
		 */
		isHtmlTag : function(s) {
			var patrn = /^<(.*)>.*<\/\1>|<(.*) \/>$/;
			return patrn.test(s);
		},
		/**
		 * 身份证号 这里的省与地区码还没有判断 15位
		 */
		isIDNumber15 : function(s) {
			var patrn = /^[\d]{6}((\d{2}((0[13578]|1[02])(0[1-9]|[12]\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\d|30)|02(0[1-9]|1\d|2[0-8])))|([02468][048]|[13579][26])0229)[\d]{3}$/;
			return patrn.test(s);
		},
		/**
		 * 身份证号 这里的省与地区码还没有判断 18位
		 */
		isIDNumber18 : function(s) {
			var patrn = /^[\d]{6}[0-9]{4}(((0[13578]|(10|12))(0[1-9]|[1-2][0-9]|3[0-1]))|(02(0[1-9]|[1-2][0-9]))|((0[469]|11)(0[1-9]|[1-2][0-9]|30)))[\d]{3}[\d|x|X]$/;
			return patrn.test(s);
		},
		/**
		 * 中文
		 */
		isChineseString : function(s) {
			var patrn = /^[\u4e00-\u9fa5]+$/
			return patrn.test(s);
		},
		/**
		 * 双字节
		 */
		isDoubleByteString : function(s) {
			var patrn = /^[^x00-xff]+$/;
			return patrn.test(s);
		},
		/**
		 * 是否包含首尾空格，如果包含，返回TRUE
		 */
		hasHESpace : function(s) {
			var patrn = /^\s+|\s+$/;
			return patrn.test(s);
		},
		/**
		 * 判断 element 是否存在于 arrayOrMap中
		 * 
		 * @param {object}
		 *            key
		 * @param {Map}
		 *            arrayOrMap
		 * @return {boolean} true=存在,false=不存在
		 */
		isInMap : function(key, map) {
			var is = false;
			is = (key in map);
			return is;
		},
		/**
		 * 判断map中包含对应的key值,并且不为空
		 * 
		 * @param {String}
		 *            key
		 * @param {Map}
		 *            map
		 * @return {boolean}
		 */
		inMapNotNull : function(key, map) {
			if (!key || !map)
				return false;
			var is = false;
			var val = map[key];

			if (val) {
				is = !this.isEmpty(val);
			}
			return is;
		},
		/**
		 * 通过这个操作实现的eval可以函数内定义全局代码 <br>
		 * <code>
		 * var  s = 'global' ;
		 function  demo3 (){
		 jax.util.Eval( 'var s="local"' );
		 }
		 demo3 ();
		 alert ( s );  //->'local'

		 * </code>
		 * 
		 * @type
		 */
		Eval : function(code) {
			if (!!(window.attachEvent && !window.opera)) {
				// ie
				execScript(code);
			} else {
				// not ie
				window.eval(code);
			}
		},

		// 检测中文
		_checkChinese : function(value1) {
			var result = "1";
			var i = 0;
			if (value1.length > 0) {
				for (var i = 0; i < value1.length; i++) {
					if (value1.substring(i, i + 1).charCodeAt(0) <= 255) {
						return "必须为中文！";
					}
				}
				return "1";
			} else {
				return result;
			}
		},

		// 检测手机号码的合法性
		_checksjhm : function(value1) {
			var result = "1";
			if (value1.length > 0) {
				result = this._checknum(value1);
				if (result != "1") {
					return result;
				}
				if (value1.length < 7 || value1.length > 12) {
					result = "7位到12位";
					return result;
				}
				return "1";
			} else {
				return result;
			}
		},

		_checkallsfzmhm : function(value1) {
			if (value1.length != 0) {
				if (!(value1.length == 15 || value1.length == 18)) {
					return "身份证长度不对,请检查！";
				}
				var zjhm2;
				var zjhm1 = value1;
				if (value1.length == 18) {
					zjhm1 = value1.substr(0, 17);
					zjhm2 = value1.substr(17, 1);
				}
				var re = new RegExp("[^0-9]");
				var s = zjhm1.match(re);
				if (s) {
					return "输入的值中含有非法字符'" + s + "'请检查！";
				}
				var birthday;
				if (value1.length == 15) {
					birthday = "19" + value1.substr(6, 6);
				} else {
					re = new RegExp("[^0-9A-Z]");
					if (s = zjhm2.match(re)) {
						// 18位身份证对末位要求数字或字符
						return "输入的值中含有非法字符'" + s + "'请检查！";
					}
					birthday = value1.substr(6, 8);
				}
				birthday = birthday.substr(0, 4) + "-" + birthday.substr(4, 2)
						+ "-" + birthday.substr(6, 2);
				var result = this._checkdate(birthday);
				if (result != "1") { // 检查日期的合法性
					return result;
				}
				if (value1.length == 18) {
					result = this._checksfzmhm(value1);
					if (result != "1") {
						return result;
					}
				}
			}
			return "1";
		},
		// 检测输入项中是否存在特殊字符
		_checkSpecilCharAndNull : function(tmpvalues) {
			var s_tmp, s;

			if (!tmpvalues)
				return "输入值为空！";
			s_tmp = tmpvalues.trim();

			if (s_tmp.length == 0) {
				return "输入值为空！";
			}
			// 检测是否有特殊符号
			var re = new RegExp("[^0-9A-Za-z]");
			if (s = s_tmp.match(re)) {
				return "输入的值只允许字母和数字,当前含有非法字符'" + s + "'请检查！";
			}
			return "1";
		},
		// -------------------------------
		// 功能介绍：对18位长的身份证进行末位校验
		// 参数说明：身份证号码
		// 返回值 ：1-符合,0-不符合
		// -------------------------------
		_checksfzmhm : function(value1) {
			var w = new Array();
			var ll_sum;
			var ll_i;
			var ls_check;
			w[0] = 7;
			w[1] = 9;
			w[2] = 10;
			w[3] = 5;
			w[4] = 8;
			w[5] = 4;
			w[6] = 2;
			w[7] = 1;
			w[8] = 6;
			w[9] = 3;
			w[10] = 7;
			w[11] = 9;
			w[12] = 10;
			w[13] = 5;
			w[14] = 8;
			w[15] = 4;
			w[16] = 2;
			ll_sum = 0;

			for (ll_i = 0; ll_i <= 16; ll_i++) {
				ll_sum = ll_sum + (value1.substr(ll_i, 1) - 0) * w[ll_i];
			}
			ll_sum = ll_sum % 11;
			switch (ll_sum) {
				case 0 :
					ls_check = "1";
					break;
				case 1 :
					ls_check = "0";
					break;
				case 2 :
					ls_check = "X";
					break;
				case 3 :
					ls_check = "9";
					break;
				case 4 :
					ls_check = "8";
					break;
				case 5 :
					ls_check = "7";
					break;
				case 6 :
					ls_check = "6";
					break;
				case 7 :
					ls_check = "5";
					break;
				case 8 :
					ls_check = "4";
					break;
				case 9 :
					ls_check = "3";
					break;
				case 10 :
					ls_check = "2";
					break;
			}
			if (value1.substr(17, 1) != ls_check) {
				return "身份证校验错误！------ 末位应该:" + ls_check + " 实际:"
						+ value1.substr(17, 1);
			}
			return "1";
		},
		_checknum : function(value1) {
			var re = new RegExp("[^0-9]");
			var s;
			if (s = value1.match(re)) {
				return "输入的值中含有非法字符'" + s + "'请检查！";
			} else {
				return "1";
			}
		},
		_checknull : function(value1) {
			value1 = jax.util.trim(value1);
			if (value1.length == 0) {
				return "不能为空！";
			} else {
				return "1";
			}
		},
		// -------------------------------
		// 函数名：isDate(i_field,thedate)
		// 功能介绍：校验字符串是否为日期格式
		// 参数说明：数据项，输入的字符串
		// 返回值 ：0-不是，1--是
		// -------------------------------
		_isDate : function(i_field, thedate) {
			if (!(thedate.length == 8 || thedate.length == 10)) {
				return "'" + i_field + "'日期格式不对,\n要求为yyyymmdd或yyyy-mm-dd！";
			}
			if (thedate.length == 8) {
				thedate = thedate.substr(0, 4) + "-" + thedate.substr(4, 2)
						+ "-" + thedate.substr(6, 2);
			}
			var reg = /^(\d{1,4})(-)(\d{1,2})\2(\d{1,2})$/;
			var r = thedate.match(reg);

			if (r == null) {
				return "请输入正确的'" + i_field + "' ！";
			}
			var d = new Date(r[1], r[3] - 1, r[4]);
			var newStr = d.getFullYear() + r[2] + (d.getMonth() + 1) + r[2]
					+ d.getDate()
			var newDate = r[1] + r[2] + (r[3] - 0) + r[2] + (r[4] - 0)

			if (newStr == newDate) {
				return 1;
			}
			return "'" + i_field + "'日期格式不对,\n要求为yyyymmdd或yyyy-mm-dd！";
		},
		// 驾驶证证芯编号校验位判断
		_zxbhCheck : function(hm) {
			if (hm.length == 0)
				return "1";
			try {
				var w = new Array();
				var ll_sum;
				var ll_i;
				var ls_check;
				w[0] = 9;
				w[1] = 8;
				w[2] = 0;
				w[3] = 8;
				w[4] = 7;
				w[5] = 3;
				w[6] = 2;
				w[7] = 3;
				w[8] = 5;
				w[9] = 6;
				w[10] = 7;
				w[11] = 8;
				w[12] = 9;
				ll_sum = 0;
				hm = hm.substr(0, 2).replace(/4/g, "8") + hm.substr(2, 1)
						+ hm.substr(3).replace(/4/g, "8");

				if (hm.length < 13) {
					return "驾驶证证芯编号录入有误，请核对！";
				}
				for (ll_i = 0; ll_i <= 12; ll_i++) {
					if (ll_i != 2) {
						if (hm.substr(ll_i, 1) < "0"
								|| hm.substr(ll_i, 1) > "9") {
							return "驾驶证证芯编号录入有误，请核对！";
						}
						ll_sum = ll_sum + (hm.substr(ll_i, 1) - 0) * w[ll_i];
					} else {
						if ((hm.substr(ll_i, 1) < "0" || hm.substr(ll_i, 1) > "9")
								&& hm.substr(ll_i, 1) != "X") {
							return "驾驶证证芯编号录入有误，请核对！";
						}
					}
				}
				ll_sum = ll_sum % 11;
				if (ll_sum == 10)
					ls_check = "X";
				else
					ls_check = ll_sum;
				if (hm.substr(2, 1) != ls_check) {
					return "驾驶证证芯编号录入有误，请核对！";
				}
				return "1";
			} catch (err) {
				return err.description;
			}
		},
		_checkIp : function(ipdz) {
			var s_tmp, s;
			var iValue;
			s_tmp = ipdz.trim();
			if (s_tmp.length == 0) {
				return "输入值不能为空!";
			}
			// 检测是否有特殊符号
			var re = new RegExp("[^0-9]");
			if (s = s_tmp.match(re)) {
				return "输入值中含有非法字符'" + s + "'请检查！";
			}
			iValue = parseInt(ipdz);
			if (iValue > 255) {
				return "输入的值" + iValue + "大于255，请检查！";
			}
			return "1";
		},

		// -------------------------------
		// 函数名：check_zjhm(zjmc,obj)
		// 参数说明：证件名称，证件号码。
		// 功能介绍：检查身份证号码合法性。
		// 对身份证检查是否为全数字；出生日期格式是否正确；是否<=18,<=70；校验码检查
		// 返回值 ：1-是，0-不
		// -------------------------------
		_check_zjhm : function(zjmc, zjhm) {
			var birthday = "", zjhm1 = "", zjhm2 = "", s = "", result = "";
			if (zjhm.length == 0) {
				return "1";
			}
			if (zjmc == "A") { // 身份证号码
				if (!(zjhm.length == 15 || zjhm.length == 18)) {
					return "身份证长度不对,请检查！";
				}
				zjhm1 = zjhm;
				if (zjhm.length == 18) {
					zjhm1 = zjhm.substr(0, 17);
					zjhm2 = zjhm.substr(17, 1);
				}
				var re = new RegExp("[^0-9]");
				if (s = zjhm1.match(re)) {
					return "输入的值中含有非法字符'" + s + "'请检查！";
				}
				// 取出生日期
				if (zjhm.length == 15) {
					birthday = "19" + zjhm.substr(6, 6);
				} else {
					re = new RegExp("[^0-9X]");
					if (s = zjhm2.match(re)) { // 18位身份证对末位要求数字或字符

						return "输入的值中含有非法字符'" + s + "'请检查！";
					}
					birthday = zjhm.substr(6, 8);
				}
				birthday = birthday.substr(0, 4) + "-" + birthday.substr(4, 2)
						+ "-" + birthday.substr(6, 2)
				result = _isDate("证件号码", birthday);
				if (result != "1") { // 检查日期的合法性
					return result;
				}
				if (zjhm.length == 18) {
					result = this._sfzCheck(zjhm); // 对18位长的身份证进行末位校验
					if (result != "1") {
						return result;
					}
				}
			} else {
				if (zjhm.length > 17) {
					return "非‘居民身份证’长度不得超过17位,请检查！";
				}
			}
			return "1";
		},

		// -------------------------------
		// 函数名 ：check_zjcx(s_value，s_cx_dm)
		// 参数说明：准驾车型字符串，合法的准驾车行字符串数组。
		// 功能介绍：检查车型输入是否正确，只检查是否包含合法的准驾车行字符串，重复、次序颠倒不认为是错误
		// 返回值 ：1-包含合法的准驾车行，0-不合法
		//
		// -------------------------------
		_check_zjcx : function(s_value) {
			// 合法的准驾车行字符串数组
			var s_cx_dm = new Array("A1", "A2", "A3", "B1", "B2", "C1", "C2",
					"C3", "C4", "C5", "D", "E", "F", "M", "N", "P");
			// 字符串数组的长度
			var s_cx_input;// 存放需要检验的字符串
			var i_pos;// 查找子串定位
			var i;
			s_cx_input = s_value;
			if (s_cx_input == "无") {
				return "1";
			}
			for (i in s_cx_dm)// 对合法准驾车行字符串数组轮循
			{
				do {
					i_pos = s_cx_input.indexOf(s_cx_dm[i]);// 是否包含当前车型
					if (i_pos != -1)
					// 包含
					{
						// 去掉找到的子串
						s_cx_input = s_cx_input.slice(0, i_pos)
								+ s_cx_input.slice(i_pos + s_cx_dm[i].length);
					}
				} while (i_pos != -1);// 找不到当前车型子串，进入下一车型子串查找
			}
			if (s_cx_input.length == 0)// 输入字符串包含的都是合法的车型子串（全部被去掉了）
				return "1";
			else
				// 输入字符串还包含有非法的字符串
				return "0";
		},
		// 检测号牌号码
		_checkHphm : function(value1) {
			if (value1 != "无") {
				if (value1.length == 0) {
					return "不能为空！";
				}
				if (value1.length < 5) {
					return "输入不正确！";
				}
				if (value1.length > 10) {
					return "输入不正确！";
				}
				var re = new RegExp("[^0-9A-Za-z]");
				var s = value1.substring(1, value1.length - 1)
				if (s.match(re)) {
					return "输入的值中含有非法字符'" + s + "'请检查！";
				}
				return "1";
			} else
				return "1";
		},
		_checkdate : function(value1) {
			if ($.isArray(value1)) {
				if (value1.length > 0) {
					value1 = value1[0];
				} else {
					value1 = '';
				}
			}
			try {
				if (!(value1 == null || value1.length == 0)) {
					var oldValue = value1;
					if (value1.length == 8) {
						oldValue = value1.substr(0, 4) + "-"
								+ value1.substr(4, 2) + "-"
								+ value1.substr(6, 2);
					}
					var reg = /^(\d{1,4})(-)(\d{1,2})\2(\d{1,2})$/;
					var r = oldValue.match(reg);
					if (r != null) {
						var d = new Date(r[1], r[3] - 1, r[4]);
						var newStr = d.getFullYear() + r[2]
								+ (d.getMonth() + 1) + r[2] + d.getDate()
						var newDate = r[1] + r[2] + (r[3] - 0) + r[2]
								+ (r[4] - 0)
						if (newStr != newDate) {
							return "日期格式错误,\n正确格式为yyyy-mm-dd"
						} else {
							return "1";
						}
					} else {
						return "日期格式错误,\n正确格式为yyyy-mm-dd"
					}
				}
			} catch (e) {
				if (isdebug()) {
					console.debug(e);
				} else {
					alert(e);
				}
			}
			return "1";
		},
		_isTrueDateTime : function(day, month, year, hour, min, second) {
			if (month < 1 || month > 12) {
				return false;
			}
			if (day < 1 || day > 31) {
				return false;
			}
			if ((month == 4 || month == 6 || month == 9 || month == 11)
					&& (day == 31)) {
				return false;
			}
			if (month == 2) {
				var leap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
				if (day > 29 || (day == 29 && !leap)) {
					return false;
				}
			}
			if (hour < 0 || hour > 23) {
				return false;
			}
			if (min < 0 || min > 59) {
				return false;
			}
			if (second < 0 || second > 59) {
				return false;
			}
			return true;
		},
		_checkdate1 : function(value1) {
			if (value1 == "") {
				return "不能为空！";
			}
			if (value1.length == 16) {
				value1 = value1 + ":00";
			}
			if (!(value1.length == 19)) {
				return "格式不对,请输入正确的格式：yyyy-mm-dd hh24:mi！";
			}
			var dateRegexp = new RegExp("^(\\d{4})[-](\\d{2})[-](\\d{2})[ ](\\d{2})[:](\\d{2})[:](\\d{2})$");
			var matched = dateRegexp.exec(value1);
			if (matched != null) {
				if (!this._isTrueDateTime(matched[3], matched[2], matched[1],
						matched[4], matched[5], matched[6])) {
					return "'格式不对，请输入正确的格式：yyyy-mm-dd hh24:mi！";
				}
				return "1";
			} else {
				return "1";
			}
		},

		_checklength : function(value1, iLength) {
			if (value1.length == 0) {
				return "1"
			}
			if (value1.length != iLength) {
				return "长度必须为" + iLength + "位！";
			} else {
				return "1";
			}
		},

		_checkMaxlength : function(value1, maxLength) {
			var maxLength = parseInt(maxLength);
			if (!value1) {
				return "1";
			}
			if (value1.length == 0) {
				return "1"
			}
			if (value1.length > maxLength) {
				return "长度不允许大于" + maxLength + "位！";
			} else {
				return "1";
			}
		},

		_checkminlength : function(value1, iLength) {
			var minlength = parseInt(iLength);
			if (!value1) {
				if (minlength === 0) {
					return '1';
				} else {
					return ' 无值,请设置值！';
				}
			}
			// console.debug(value1, value1.length, minlength);
			if (value1.length < minlength) {
				return "长度最少为" + minlength + "位！";
			} else {
				return "1";
			}
		},
		// 检测Email地址的合法性
		_checkEmail : function(value1) {
			if (this.isEmail(value1)) {
				return "1";
			} else {
				return "Email地址输入有误！";
			}

		},
		// 检测省份代码
		_checkSfdm : function(value1) {
			var result = "1";
			if (value1.length > 0) {
				if ("11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65"
						.indexOf(value1) < 0) {
					return "无效省份代码";
				}
				return "1";
			} else {
				return result;
			}
		},
		_checklxdh : function(value1, hmcd) {
			var result = "1";
			var i = 0;
			if (value1.length > 0) {
				var iPos = value1.indexOf("-");
				var iLength = 0;
				while (iPos >= 0) {
					iLength = iLength + 1;
					iPos = value1.indexOf("-", iPos + 1);
				}
				if (iLength == 0) {
					if (this._checknum(value1) != "1") {
						return "必须为数字";
					}
					if (hmcd == undefined) {
						if (value1.length < 7) {
							return "至少7位";
						}
					} else {
						if (value1.length != hmcd) {
							return "长度必须为" + hmcd;
						}
					}
					if (value1.substring(0, 1) == "1") {
						return "第1位不能为'1'"
					}
				} else if (iLength == 1) {
					var zjhm = value1.substring(0, iPos);
					var fjhm = value1.substr(iPos + 1);
					if (this._checknum(zjhm) != "1") {
						return "必须为数字";
					}
					if (hmcd == undefined) {
						if (zjhm.length < 7) {
							return "至少7位";
						}
					} else {
						if (zjhm.length != hmcd) {
							return "长度必须为" + hmcd;
						}
					}
					if (zjhm.substring(0, 1) == "1") {
						return "第1位不能为'1'"
					}
					if (this._checknum(fjhm) != "1") {
						return "分机号必须为数字";
					}
				} else {
					return "格式不正确"
				}
				return "1";
			} else {
				return result;
			}
		},

		// 检测全IP地址
		_checkIpAll : function(value1) {
			var result = "1";
			var i = 0;
			if (value1.length > 0) {
				var iparr = value1.split(".");
				if (iparr.length != 4) {
					return "格式不正确";
				} else {
					for (i = 0; i < iparr.length; i++) {
						result = this._checkIp(iparr[i]);
						if (result != "1") {
							return result;
						}
					}
				}
				return "1";
			} else {
				return result;
			}
		}
	}
	
};

/**
 * 取得文本框对象的内容
 * 
 * @param {}
 *            elementId 对象的id
 */
function getTextValue(elementObjOrId) {
	// 验证码
	var obj = getObject(elementObjOrId);
	if (obj) {
		var val = obj.val();// attr("value");
		return jax.util.sNull(val);
	}
	return '';
}
/**
 * 更新文本的值
 * 
 * @param {}
 *            id
 * @param {}
 *            value
 */
function changeTxtValue(elementObjOrId, value) {
	var obj = getObject(elementObjOrId);
	obj.val(value);
}
/**
 * 判断是否进行debug
 * 
 * @return {Boolean}
 */
function isdebug() {// 在火狐下调试
//	return true && $.browser.mozilla;
	return false;
}
/**
 * 根据 elementObjOrId 来得到对象
 * 
 * @param {}
 *            elementObjOrId
 * @return {}
 */
function getObject(elementObjOrId) {
	return getS(elementObjOrId);
}
/**
 * 
 * @param {}
 *            id
 * @return {}
 */
function getS(id) {
	if (isString(id)) {
		if (id.startWith('#')) {
			return jQuery(id);
		} else {
			return jQuery('#' + id);
		}
	} else {
		return jQuery(id);
	}
}
/**
 * 判断对象是否为字符类型
 * 
 * @param {}
 *            str
 * @return {}
 */
function isString(str) {
	if (str == null)
		return false;
	return (typeof str == 'string') && str.constructor == String;
}
/**
 * 数量信息到控制台中
 * 
 * @param {}
 *            value
 */
function log() {
	var txt = Array.prototype.join.call(arguments, '');
	if (window.console && window.console.debug && arguments) {
		var errTxt = '';
		var isError = false;
		if (arguments.length >= 1) {
			// 判断 参数是否是错误信息
			if (arguments[0]) {
				var type = arguments[0].constructor;
				if (type == TypeError || (typeof arguments[0] == "object")) {
					isError = true;
					if (isError === true) {
						var err = arguments[0];
						// var errTxt = "There was an error on this page.\n";

						if (!isNaN(err.description)) {
							errTxt += "\nError description : "
									+ err.description;
						}
						if (!isNaN(err.number)) {
							errTxt += "\nError number : " + err.number;
						}
						errTxt += "\nerr.name : " + err.name;
						errTxt += "\nerr.message : " + err.message;
						errTxt += "\n\nClick OK to continue.\n";
					}
				}
			}
		}

		var txt = Array.prototype.join.call(arguments, '');
		// 在ie下,不显示调用者,发现ie把调用者的代码都输出了
		var _caller = arguments.callee.caller;
		if (jQuery.browser) {
			_caller = (jQuery.browser.msie || jQuery.browser.safari) ? '' : // 
					(arguments.callee.caller) ? arguments.callee.caller : '';
		}
		var title = (isError == true) ? errTxt : "";
		window.console.debug('%s: %o', title + txt, _caller);// this
		// console.debug("%s: %o", msg, this);
	} else if (true) {/* isdebug() && false 调试模式下 */
		var id = "___com_log_div";
		if (!exist(id)) {
			$(document.body)
					.append("<br/>"
							+ "<div style='height: 0; overflow: hidden;'></div>"
							+ "<div style='clear:both;'></div>" //
							+ "<div id='"
							+ id
							+ "' style='height: 1200px;overflow: auto;width: 95%' ></div>");

		}
		var $log = $("#" + id);
		// 在后面插入
		$log.html($log.html() + "<br>" + txt);

		// 在前面放置
		// $log.html(txt + "<br>" + $log.html());

	}
}