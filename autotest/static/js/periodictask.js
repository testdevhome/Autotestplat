addURL = 'periodictask/add/'
addFieldNames = ["name","crontab_id","args","description","enabled"]
addRequiredFields = [0, 1, 2, 3, 4]

runURL = 'periodictask/run/'

modURL = 'periodictask/mod/'
modFieldNames = ["id","name","crontab_id","args","description","enabled"]
modRequiredFields = [0, 1, 2, 3, 4, 5]
modRowIndex = [0, 1, 2, 3, 4, 5]

delURL = 'periodictask/del/'
delFieldNames = ["id"]

getSearchSelectURL = ''
getSelectURL = 'periodictask/getSelect/'
searchableTableColumns = [1, 3]

tableURL = 'periodictask/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"runActions(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">执行</span> </a>\
                        <a href=\"#\" class=\"#\" onclick=\"showModModal(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">修改</span> </a>\
                        <a href=\"#\" class=\"#\" onclick=\"showDelModal(this)\"> <span class=\"badge badge-danger \" style=\"width: 40px;font-size: 12px\">删除</span> </a>"
tableItemsPerPage = 10
tableColumnsData = [
  { data: 0,
    searchable:true,
  },
  { data: 1,
    searchable:true,
  },
  { data: 3,
    searchable:true,
  },
  { data: 5,
    searchable:true,
  },
  { data: 15,
    searchable:true,
  },
  { data: 11,
    searchable:true,
    render: function(data){
                if(data == 0){
                  return "已暂停"
                }
                return "开启中"
              }
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
    getAndShowSelectValue()
    tableDataInit()
    laydate.render({
        elem: '#date_Add',
        type: 'datetime',
        format: 'yyyy-MM-dd HH:mm',
    });
    laydate.render({
        elem: '#date_Mod',
        type: 'datetime',
        format: 'yyyy-MM-dd HH:mm',
    });
    laydate.render({
        elem: '#date_Search',
        type: 'datetime',
        format: 'yyyy-MM-dd HH:mm',
    });
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


/**
 *
 * @returns
 * @param {Element} e
 * @param {*} tips
 */
 function runActions(e,tips="运行成功"){
      run(e)
}

