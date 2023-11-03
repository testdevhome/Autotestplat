addURL = 'user/add/'
addFieldNames = ["user_name", "user_pwd", "contact", "role_name"]
addRequiredFields = [0, 1, 2, 3]

modURL = 'user/mod/'
modFieldNames = ["id", "user_name", "user_pwd", "contact", "role_name"]
modRequiredFields = [1, 2, 3, 4]
modRowIndex = [0, 1, 2, 3, 4]

delURL = 'user/del/'
delFieldNames = ["id"]

getSearchSelectURL = 'user/getSearchSelect/'
getSelectURL = 'user/getSelect/'
searchableTableColumns = [1, 4]

tableURL = 'user/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"showModModal(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">修改</span> </a>\
                        <a href=\"#\" class=\"#\" onclick=\"showDelModal(this)\"> <span class=\"badge badge-danger \" style=\"width: 40px;font-size: 12px\">删除</span> </a>"
tableItemsPerPage = 10
tableColumnsData = [
  { data: 0 ,
    searchable:false,
  },
  { data: 1,
    searchable:true,
  },
  { data: 2,
    render: function(data){
      return "<span>******</span>"
    },
    searchable:false,
  },
  { data: 3,
    searchable:false,
  },
  { data: 4,
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
    getAndShowSelectValue()
    tableDataInit()
}

/**
 * @param {Object} d
 */
function tableSearchDataFunction(d){
  d.user_name = $("[name=searchField]").eq(0).val()
}

/**
 * @returns
 */
 function additionalTips(type = ""){
  return null
}
