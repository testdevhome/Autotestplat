addURL = 'product/add/'
addFieldNames = ["product_name", "product_type", "product_introduction","charger"]
addRequiredFields = [0, 1, 2, 3]

modURL = 'product/mod/'
modFieldNames = ["id","product_name", "product_type", "product_introduction","charger"]
modRequiredFields = [0, 1, 2, 3]
modRowIndex = [0, 1, 2, 3, 4]

delURL = 'product/del/'
delFieldNames = ["id"]

getSearchSelectURL = ''
getSelectURL = ''
searchableTableColumns = [1,2,3,4]

tableURL = 'product/getTableData/'
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
    searchable:true,
  },
  { data: 3,
    searchable:true,
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
    tableDataInit()
}

/**
 * @param {Object} d
 */
function tableSearchDataFunction(d){
  return
}

/**
 * @returns
 */
 function additionalTips(type = ""){
  return null
}