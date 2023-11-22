
runURL = 'apitestplan/run/'


function infoInit(){
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

