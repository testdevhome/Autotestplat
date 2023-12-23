addURL = 'user/add/'
addFieldNames = ["username", "password", "email", "is_superuser","last_name"]
addRequiredFields = [0, 1, 2, 3, 4]

modURL = 'user/mod/'
modFieldNames = ["id", "username", "password", "email", "is_superuser","last_name"]
modRequiredFields = [1, 2, 3, 4, 5]
modRowIndex = [0, 1, 2, 3, 4, 5]

setURL='user/mod/'
setFieldNames = ["id", "username", "password", "email", "is_superuser","last_name"]
setRequiredFields = [0, 1,2,3,4,5]
setRowIndex = [0, 1,2,3,4,5]

delURL = 'user/del/'
delFieldNames = ["id"]

getSearchSelectURL = 'user/getSearchSelect/'
getAddSelectURL = 'user/getAddSelect/'
getSelectURL = 'user/getSelect/'
searchableTableColumns = [1, 4]

tableURL = 'user/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"showSetModal(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">设置</span> </a>\
                        <a href=\"#\" class=\"#\" onclick=\"showModModal(this)\"> <span class=\"badge badge-warning \" style=\"width: 40px;font-size: 12px\">修改</span> </a>\
                        <a href=\"#\" class=\"#\" onclick=\"showDelModal(this)\"> <span class=\"badge badge-danger \" style=\"width: 40px;font-size: 12px\">删除</span> </a>"
tableItemsPerPage = 10
tableColumnsData = [
  { data: 0 ,
    searchable:false,
  },
  { data: 4,
    searchable:true,
  },
  { data: 1,
    render: function(data){
      return "<span>******</span>"
    },
    searchable:false,
  },
  { data: 7,
    searchable:false,
  },
  { data: 3,
    render: function(data) {
      if (data == '1')
        data = "管理员";
      else if (data == '0')
        data = "普通用户";
      return data;
    },
    searchable:true,
  },
  { data: 6,
    searchable:true,
  },
  { data: null,
    orderable: false,
    render: function(data){
      return tableButtonOperation
    },
    searchable:false,
  }
]

function infoInit(){
    getAndShowSearchSelectValue()
    getAndShowAddSelectValue()
    getAndShowModSelectValue()
    getAndShowSetSelectValue()
    tableDataInit()
}


function tableSearchDataFunction(d){
  d.user_name = $("[name=searchField]").eq(0).val()
}


 function additionalTips(type = ""){
  return null
}
