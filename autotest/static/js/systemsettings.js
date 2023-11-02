addURL = 'systemsettings/add/'
addFieldNames = ["product_name","type", "name", "keywords", "value"]
addRequiredFields = [0, 1, 2, 3, 4]

modURL = 'systemsettings/mod/'
modFieldNames = ["id", "product_name","type", "name", "keywords", "value" ]
modRequiredFields = [0, 1, 2, 3, 4, 5]
modRowIndex = [0, 1, 2, 3, 4, 5]

delURL = 'systemsettings/del/'
delFieldNames = ["id","keywords"]

getSearchSelectURL = 'systemsettings/getSearchSelect/'
getSelectURL = 'systemsettings/getSelect/'
searchableTableColumns = [3, 2, 4]

tableURL = 'systemsettings/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"showModModal(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">修改</span> </a>\
                        <a href=\"#\" class=\"#\" onclick=\"showDelModal(this)\"> <span class=\"badge badge-danger \" style=\"width: 40px;font-size: 12px\">删除</span> </a>"
tableItemsPerPage = 10
tableColumnsData = [
  { data: 0 ,
    searchable:true,
  },
  { data: 7,
    searchable:true,
  },
  { data: 9,
   render: function(data){
      if (data == 'con')
          data = "常量";
      else if (data == 'var')
          data = "变量";
      else if (data == 'env')
          data = "环境设置";
      else
          data = "未知";
      return data;
    },
    searchable:true,
  },
  { data: 1,
    searchable:true,
  },
  { data: 2,
    searchable:true,
  },
  { data: 3,
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
    return null
}


/**
 * @returns
 */
 function additionalTips(type = ""){
  return null
}