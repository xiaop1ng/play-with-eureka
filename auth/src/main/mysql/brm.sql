CREATE TABLE `brm_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `account` varchar(50)  NOT NULL COMMENT '帐号',
  `password` varchar(200) NOT NULL COMMENT '密码',
  `login_salt` varchar(10) DEFAULT NULL COMMENT '盐',
  `go_id` bigint DEFAULT NULL COMMENT '组织ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父级账号ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色id',
  `logo` varchar(200) DEFAULT NULL COMMENT 'logo',
  `area_code` varchar(50) DEFAULT NULL COMMENT '国际代码',
  `phone_number` varchar(50) DEFAULT NULL COMMENT '手机号',
  `company` varchar(50) DEFAULT NULL COMMENT '公司',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `ctime` bigint DEFAULT NULL COMMENT '注册时间',
  `utime` bigint DEFAULT NULL COMMENT '修改时间',
  `status` tinyint DEFAULT '1' COMMENT '状态（0：未激活；1：可用）',
  `is_del` tinyint DEFAULT '0' COMMENT '删除状态（0：未删除;1:已删除）',
  `token` varchar(255) DEFAULT NULL,
  `monitor_token` varchar(64) DEFAULT NULL COMMENT '监控TOKEN',
  `is_initialpass` tinyint DEFAULT '1' COMMENT '是否为初始化密码（0：否；1：是）',
  `department_id` varchar(50) DEFAULT NULL COMMENT '所属部门ID',
  `job` varchar(50) DEFAULT NULL COMMENT '岗位',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `emp_status` tinyint DEFAULT '1' COMMENT '员工状态（0：离职；1：在职）',
  `business_card` varchar(255) DEFAULT NULL COMMENT '名片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户';

CREATE TABLE `brm_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '角色名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `role_type` varchar(32) DEFAULT NULL COMMENT '角色类型',
  `create_id` bigint DEFAULT NULL COMMENT '创建人',
  `create_time` bigint DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色';

CREATE TABLE `brm_role_user_rel` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_id_user_id` (`role_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户角色';

CREATE TABLE `brm_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT NULL COMMENT '父级菜单ID',
  `url` varchar(200) DEFAULT NULL COMMENT '请求路径',
  `icon` varchar(200) DEFAULT NULL COMMENT '菜单图标',
  `seq` int DEFAULT '0' COMMENT '排序',
  `type` tinyint DEFAULT '0' COMMENT '菜单类型',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `admin` tinyint DEFAULT '0' COMMENT '管理员菜单（0；不是；1：是）',
  `ctime` bigint NOT NULL COMMENT '创建时间',
  `utime` bigint DEFAULT NULL COMMENT '更新时间',
  `is_del` tinyint NOT NULL DEFAULT '0' COMMENT '删除状态（0：未删除；1：已删除）',
  `group_type` tinyint DEFAULT '0' COMMENT '分组类型：（0：复选；1：单选）',
  `group_number` tinyint DEFAULT NULL COMMENT '分组号码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='平台菜单';

CREATE TABLE `brm_role_menu_rel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `go_id` int DEFAULT NULL COMMENT '组织机构ID',
  `menu_id` bigint DEFAULT NULL COMMENT '菜单ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_go_id_role_id` (`go_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色菜单表';


CREATE TABLE `brm_department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `go_id` int DEFAULT NULL COMMENT '组织ID',
  `name` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `parent_id` bigint DEFAULT '0' COMMENT '上级部门ID',
  `sort` int DEFAULT NULL COMMENT '排序',
  `intro` varchar(500) DEFAULT NULL COMMENT '部门简介',
  `type` tinyint DEFAULT '0' COMMENT '部门类型：0-其他 默认是0',
  `is_del` tinyint DEFAULT '0' COMMENT '是否删除：0 正常  1 删除',
  `create_time` bigint DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门';

CREATE TABLE `brm_self_help_meet` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `meeting_id` varchar(100) DEFAULT NULL COMMENT '会议ID',
  `meeting_code` varchar(20) DEFAULT NULL COMMENT '会议号码',
  `subject` varchar(255) DEFAULT NULL COMMENT '会议主题',
  `ctime` bigint DEFAULT NULL COMMENT '会议创建时间',
  `stime` bigint DEFAULT NULL COMMENT '会议预计开始时间',
  `etime` bigint DEFAULT NULL COMMENT '会议预计结束时间',
  `cname` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `ctelephone` varchar(64) DEFAULT NULL COMMENT '创建人手机号',
  `duration_in_minute` bigint DEFAULT NULL COMMENT '会议时长(分)',
  `status` int DEFAULT NULL COMMENT '1:待开始  2: 进行中  3:已结束  4:已取消 5:空状态 6:错误状态 7:已删除',
  `is_show_applet` int DEFAULT '0' COMMENT '是否在小程序中展示',
  `go_id` int DEFAULT NULL COMMENT '机构id',
  `create_id` bigint DEFAULT NULL COMMENT '创建人id',
  `create_time` bigint DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint DEFAULT NULL COMMENT '修改时间',
  `is_del` tinyint DEFAULT NULL COMMENT '是否删除',
  `type` int DEFAULT NULL COMMENT '会议类型 0:预约会议  6: 网络研讨会',
  `is_del_srs` tinyint DEFAULT '0' COMMENT '数据在投研平台的删除状态(0未删除 1已删除)',
  `sponsor` varchar(100) DEFAULT NULL COMMENT '举办方',
  `admission_type` int DEFAULT NULL COMMENT '参会方式：0：公开  1：报名  2 密码',
  `host_phone` varchar(255) DEFAULT NULL COMMENT '主持人手机号(多个用,隔开)',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `share` varchar(1024) DEFAULT NULL COMMENT '分享摘要',
  `poster` varchar(500) DEFAULT NULL COMMENT '海报',
  `enable_auto_duit` tinyint DEFAULT '0' COMMENT '报名设置 成员需报名参会:0 自动审核:1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci  COMMENT='自助会议主表';

CREATE TABLE `brm_organization` (
  `id` int NOT NULL AUTO_INCREMENT,
  `go_id` int DEFAULT NULL COMMENT '组织机构ID',
  `user_id` bigint NOT NULL COMMENT '超管ID',
  `telephone` varchar(50) DEFAULT NULL COMMENT '电话',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `organization_name` varchar(255)  DEFAULT NULL COMMENT '机构名称',
  `introduce` varchar(500) DEFAULT NULL COMMENT '机构介绍',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注说明',
  `create_time` bigint DEFAULT NULL COMMENT '创建时间',
  `update_time` bigint DEFAULT NULL COMMENT '更新时间',
  `is_del` tinyint DEFAULT '0' COMMENT '是否删除 未删除:0 已删除:1',
  `logo` varchar(200) DEFAULT NULL COMMENT 'logo',
  `invite_code` varchar(200) DEFAULT NULL COMMENT '机构邀请码',
  `code_expire_time` bigint DEFAULT NULL COMMENT '邀请码过期时间',
  `enable_question` tinyint DEFAULT '0' COMMENT '是否允许提问 不允许:0 允许:1',
  `enable_hands` tinyint DEFAULT '0' COMMENT '是否允许举手 不允许:0 允许:1',
  `enable_join` tinyint DEFAULT '0' COMMENT '是否允许申请加入 不允许:0 允许:1',
  `enable_auto_duit` tinyint DEFAULT '0' COMMENT '是否自动审核 否:0 是:1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci  COMMENT='机构';

CREATE TABLE `brm_user_apply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报名审核自增id',
  `go_id` int DEFAULT NULL COMMENT '组织机构ID',
  `apply_name` varchar(255) DEFAULT NULL COMMENT '用户姓名',
  `apply_telephone_code` varchar(30) DEFAULT NULL COMMENT '国际代码',
  `apply_telephone` varchar(50) DEFAULT NULL COMMENT '用户手机号',
  `apply_mail` varchar(32) DEFAULT NULL COMMENT '用户邮箱',
  `apply_department_id` varchar(50) DEFAULT NULL COMMENT '申请加入部门ID',
  `apply_job` varchar(50) DEFAULT NULL COMMENT '岗位',
  `business_card_url` varchar(255) DEFAULT NULL COMMENT '名片(url)',
  `create_time` bigint DEFAULT NULL COMMENT '数据创建时间(即活动报名时间)',
  `audit_time` bigint DEFAULT NULL COMMENT '审核时间',
  `auditor` varchar(255) DEFAULT NULL COMMENT '审核人',
  `audit_status` tinyint DEFAULT '0' COMMENT '审核状态(0:待审核,1:审核通过,2:审核未通过)',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注',
  `update_time` bigint DEFAULT NULL COMMENT '数据最新更新时间',
  `remark1` varchar(255) DEFAULT NULL COMMENT '备用1',
  `remark2` varchar(255) DEFAULT NULL COMMENT '备用2',
  `remark3` varchar(255) DEFAULT NULL COMMENT '备用3',
  `create_id` bigint DEFAULT NULL COMMENT '创建人id',
  `operator_id` bigint DEFAULT NULL COMMENT '修改人id',
  `is_del` int DEFAULT '0' COMMENT '是否删除 0 未删除 ，1已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_telephone` (`apply_telephone`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='员工报名审核表';
