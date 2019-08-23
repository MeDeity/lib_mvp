class Api{
  ///网络请求根地址
  static const String base_url = 'http://rap2api.taobao.org/app/mock/226055/';
  ///登录接口根地址
  static const String oauth_base_url = 'http://192.168.1.13:8080/';
  ///服务接口根地址
  static const String service_base_url = 'http://192.168.1.13:80/';
  ///测试用接口
  static const String users = 'users/MeDeity';
  /// 获取出库申请分页列表(待审核、审核通过、驳回等各种状态)
  static const String get_archives_out_list = 'lycomponents-services/rest/file_outbound_application/get_file_outbound_application_paging';
  /// 出库申请对应明细分页列表
  static const String get_archives_out_detail = 'lycomponents-services/rest/file_outbound_application_detail/get_file_outbound_application_detail_paging';
  /// 获取入库申请分页列表(待审核、审核通过、驳回等各种状态)
  static const String get_archives_in_list = 'lycomponents-services/rest/file_warehousing_application/get_file_warehousing_application_paging';
  /// 入库申请对应明细分页列表
  static const String get_archives_in_detail = 'lycomponents-services/rest/file_warehousing_application_detail/get_file_warehousing_application_detail_paging';
  ///盘点任务分页列表
  static const String get_file_inventory_task_paging_by_user = 'lycomponents-services/rest/file_inventory_task/get_file_inventory_task_paging_by_user';
  ///盘点任务详情
  static const String archives_task_list = 'lycomponents-services/rest/file_inventory_list/get_file_inventory_list_paging';
  ///盘点任务更新(盘点中、盘点结束等状态变更)
  static const String update_file_inventory_task_for_equipment = 'lycomponents-services/rest/file_inventory_task/update_file_inventory_task_for_equipment';
  ///盘点任务结果数据返回
  static const String batch_update_fileInventory_list_result = 'lycomponents-services/rest/file_inventory_list/batch_update_fileInventory_list_result';
  ///损毁盘点上报（针对盘点清单逐条上报）
  static const String update_file_inventory_list_for_equipment = 'lycomponents-services/rest/file_inventory_list/update_file_inventory_list_for_equipment';
  ///档案信息更新（无盘点任务的异常上报）
  static const String add_file_info = 'lycomponents-services/rest/file_info/add_file_info';
  ///档案分页列表接口
  static const String archives_list = 'lycomponents-services/rest/file_info/get_file_info_paging';
  ///单个档案详情接口
  static const String archives_single_detail = 'lycomponents-services/rest/file_info/get_file_info';
  ///获取当前用户详情接口
  @deprecated
  static const String get_user_detail = 'lycomponents-services/rest/users/get_user_info';
  ///获取当前用户的详情
  static const String get_current_user_info = 'lycomponents-services/rest/users_roles/get_current_user_info';
  ///用户登录接口
  static const String user_login = 'lycomponents-oauth/rest/shiro/login';
  ///获取档案信息的分页列表接口
  static const String get_archives_list = 'lycomponents-services/rest/file_info/get_file_info_paging';
  ///字典接口
  static const String get_multiple_bussiness_dict = 'lycomponents-services/rest/bussiness_dict/get_multiple_bussiness_dict';

  ///------------操作接口------------
  ///生成出库申请单(待审核)
  static const String add_file_outbound_application = 'lycomponents-services/rest/file_outbound_application/add_file_outbound_application';
  ///出库确认单修改(待确认)
  static const String add_affirm_and_detail = 'lycomponents-services/rest/file_outbound_affirm/add_affirm_and_detail';
  ///出库确认单提交接口(确认)
  static const String add_file_outbound_affirm = 'lycomponents-services/rest/file_outbound_affirm/add_file_outbound_affirm';

  ///修改入库申请单（待审核）
  static const String add_file_warehousing_application = 'lycomponents-services/rest/file_warehousing_application/add_file_warehousing_application';
  ///入库确认修改（待确认）
  static const String add_file_warehousing_affirm = 'lycomponents-services/rest/file_warehousing_affirm/add_file_warehousing_affirm';
  ///入库归还确认接口(确认)
  static const String return_file_affirm = 'lycomponents-services/rest/file_warehousing_affirm/return_file_affirm';
  ///关联电子标签 添加时间 2019-8-13 09:18:10
  static const String get_rfid = 'lycomponents-services/rest/file_warehousing_affirm/get_rfid';
  ///根据参数查询入库库确认单详情接口
  static const String get_file_warehousing_affirm_by_params = 'lycomponents-services/rest/file_warehousing_affirm/get_file_warehousing_affirm_by_params';
  ///根据参数查询出库确认单详情接口
  static const String get_file_outbound_affirm_by_params = 'lycomponents-services/rest/file_outbound_affirm/get_file_outbound_affirm_by_params';
  ///全局数量盘点最终上报接口
  static const String update_global_file_inventory_task_for_equipment = 'lycomponents-services/rest/file_inventory_task/update_global_file_inventory_task_for_equipment';


}