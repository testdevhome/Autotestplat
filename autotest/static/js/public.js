appURL = '/autotest/'
loginPageURL = '/autotest/login/'
loginVerifyURL = '/autotest/login/identify/'
indexURL = '/autotest/index'
loginLastURL = '/autotest/login/last/'
logoutURL = '/autotest/logout/'

function loginVerify(){
            var userObj = JSON.parse(localStorage.getItem('user'))
            var rstStatus = 0
            if(userObj == null){
                rstStatus = 4001
                alert('未登录 请点击确认跳转到登录界面')
                setTimeout(() => window.location = loginPageURL, 300)
            }
            else{
                $.ajax({
                    url: loginLastURL,
                    type: "post",
                    async: false,
                    data:{
                        userName: userObj.userName
                    },
                    success: function(rst){
                        if(rst == 200){
                            showUserName(userObj.userName)
                            rstStatus = 200
                        }
                        else{
                            rstStatus = 400
                            alert('登录已过期 请点击确认跳转到登录界面')
                            setTimeout(() => window.location = loginPageURL, 300)
                        }
                    },
                    error: function(rst){
                        rstStatus = 404
                        console.log(rst)
                        alert(rst)
                    }
                })
            }
            return rstStatus
        }

function logout(){
            var userObj = JSON.parse(localStorage.getItem('user'))
            $.ajax({
                url: logoutURL,
                type: 'POST',
                data: {
                    userName: userObj.userName
                },
                success: function(rst){
                    if(rst == 'logout'){
                        localStorage.removeItem('user')
                        window.location = loginPageURL
                    }
                    else{
                        console.log(rst)
                        alert(rst)
                    }
                },
                error: function(rst){
                    console.log("退出失败！")
                },
            })
        }

function setUser(mKey,mValue){
    var valStr = JSON.stringify(mValue)
    localStorage.setItem(mKey, valStr)
}

function showUserName(str){
    $("#userName").text(str)
}

function tableDataInit(){
    table = $('#table').DataTable({
        dom:'tp',
        pageLength: tableItemsPerPage,
        ajax: {
            url: appURL + tableURL,
            type: "POST",
            data: tableSearchDataFunction
          },
        info: false,
        lengthChange: false,
        searching: true,
        order: [[0, "desc"]],
        columns: tableColumnsData,
    });
}
function run(e,tips="运行成功"){
  selectedRow = e.parentNode.parentNode
  fieldValues3 = selectedRow.children[3].innerText
  fieldValues0 = selectedRow.children[0].innerText

  $.ajax({
      url: appURL + runURL+fieldValues3+'/'+fieldValues0,
      type: "POST",
      aysnc: false,
      data: function(dp){
                dp.fieldValues3 = fieldValues3
                dp.fieldValues0 = fieldValues0
                console.log(dp.fieldValues)
            },
      success: (rst) => {
          if(rst === '200'){
              alert(tips)
              console.log(tips)
              $("#addModal").modal('hide')
          }
          else{
              console.log(rst)
              return alert(rst)
          }
      },
      error: (rst) =>{
          console.log(rst)
          return alert(rst)
      },
  })
    console.log(fieldValues)

}
function AjaxObjectData(keyNames, inputFields){
    var ajaxObject = new Object()
    for(var i = 0; i < keyNames.length; i++){
        console.log(inputFields[i].value)
        ajaxObject[keyNames[i]] = inputFields[i].value
    }
    console.log(ajaxObject)
    return ajaxObject
}
function showAddModal(e){
    var addModal = $("#addModal")
    var inputFields = addModal.find("[name=addInput]")
    for(var i = 0; i < inputFields.length; i++){
        var temp = inputFields[i]
        if(temp.tagName == "INPUT" || temp.tagName == "TEXTAREA"){
            temp.value = ''
        }
        else if(temp.tagName == "SELECT"){
            $(temp).find("option[selected=true]").prop("selected",false)
            $(temp).find("option").eq(0).prop("selected",true)
        }
    }
    addModal.modal('show')
    window.event.stopPropagation()
}
function add(tips="添加成功"){
    var inputFields = $("[name=addInput1]")
    for(var i = 0; i < addRequiredFields.length; i++){
        if(inputFields[addRequiredFields[i]].value == ''){
            return alert("*信息为必填项！")
        }
    }
    $.ajax({
        url: appURL + addURL,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(addFieldNames,inputFields),
        success: (rst) => {
            if(rst === '200'){
                operationSelectValue('add')
                alert(tips)
                $("#addModal").modal('hide')
            }
            else{
                console.log(rst)
                return alert('rst' )
            }
        },
        error: (rst) =>{
            console.log(rst)
            return alert('rst' )
        },
    })
}
function showModModal(e){
    selectedRow = e.parentNode.parentNode
    var inputFields = $("[name=modInput]")
    for(let i = 0; i < inputFields.length; i++){
        var temp = inputFields[i]
        if(temp.tagName == "INPUT"){
            temp.value = selectedRow.children[modRowIndex[i]].innerText
            if(temp.type == "password"){
                temp.value = $(selectedRow.children[modRowIndex[i]]).find("span").attr("pdata")
            }
        }
        else if(temp.tagName == "SELECT"){
            $(temp).find("option[selected=true]").prop("selected",false)
            $(temp).find("option[value='"+ selectedRow.children[modRowIndex[i]].innerText +"']").prop("selected",true)
        }
        else if(temp.tagName == "TEXTAREA"){
            temp.value = $(selectedRow.children[modRowIndex[i]].children[0]).attr("ordata")
        }
    }
    $("#modifyModal").modal('show')
    window.event.stopPropagation()
}

function showSetModal(e){
    selectedRow = e.parentNode.parentNode
    var inputFields = $("[name=setInput]")
    for(let i = 0; i < inputFields.length; i++){
        var temp = inputFields[i]
        if(temp.tagName == "INPUT"){
            temp.value = selectedRow.children[setRowIndex[i]].innerText
            if(temp.type == "password"){
                temp.value = $(selectedRow.children[setRowIndex[i]]).find("span").attr("pdata")
            }
        }
        else if(temp.tagName == "SELECT"){
            $(temp).find("option[selected=true]").prop("selected",false)
            $(temp).find("option[value='"+ selectedRow.children[setRowIndex[i]].innerText +"']").prop("selected",true)
        }
        else if(temp.tagName == "TEXTAREA"){
            temp.value = $(selectedRow.children[setRowIndex[i]].children[0]).attr("ordata")
        }
    }
    $("#setModal").modal('show')
    window.event.stopPropagation()
}


function set(tips="设置成功"){
    var inputFields = $("[name=setInput]")
    for(var i = 0; i < setRequiredFields.length; i++){
        if(inputFields[setRequiredFields[i]].value == ''){
            return alert("*信息为必填项！")
        }
    }
    $.ajax({
        url: appURL + setURL,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(setFieldNames,inputFields),
        success: (rst) => {
            if(rst === '200'){
                operationSelectValue('set')
                alert(tips)
                $("#setModal").modal('hide')
            }
            else{
                console.log(rst)
                return alert(rst)
            }
        },
        error: (rst) => {
            console.log(rst)
            return alert(rst)
        },
    })
}


function mod(tips="修改成功"){
    var inputFields = $("[name=modInput]")
    for(var i = 0; i < modRequiredFields.length; i++){
        if(inputFields[modRequiredFields[i]].value == ''){
            return alert("*信息为必填项！")
        }
    }
    $.ajax({
        url: appURL + modURL,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(modFieldNames,inputFields),
        success: (rst) => {
            if(rst === '200'){
                operationSelectValue('modify')
                alert(tips)
                $("#modifyModal").modal('hide')
            }
            else{
                console.log(rst)
                return alert(rst)
            }
        },
        error: (rst) => {
            console.log(rst)
            return alert(rst)
        },
    })
}

function showDelModal(e){
    selectedRow = e.parentNode.parentNode
    var inputFields = $("[name=delInput]")
    for(let i = 0; i < inputFields.length; i++){
        if(inputFields[i].tagName == "INPUT"){
            inputFields[i].value = selectedRow.children[i].innerText
        }
        else if(inputFields[i].tagName == "TEXTAREA"){
            // console.log($(selectedRow.children[i]))
            inputFields[i].value = $(selectedRow.children[i].children[0]).attr("ordata")
        }
    }
    $("#deleteModal").modal('show')
    window.event.stopPropagation()
}

function del(tips="删除成功"){
    var inputFields = $("[name=delInput]")
    $.ajax({
        url: appURL + delURL,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(delFieldNames,inputFields),
        success: (rst) => {
            if(rst === '200'){
                operationSelectValue('delete')
                alert("删除成功")
                $("#deleteModal").modal('hide')
            }
            else{
                console.log(rst)
                return alert(rst)
            }
        },
        error: (rst) => {
            console.log(rst)
            return alert(rst)
        },
    })
}

function searchClick(){
    var filter = $("[name=searchField]")
    var filterList = []
    for(let i = 0; i < filter.length; i++){
        filterList[i] = filter[i].value
    }
    sessionStorage.setItem('filter', JSON.stringify(filterList))

    table.ajax.reload(null, false)

    var storage = table
    for(let i = 0; i < filterList.length; i++){
        storage = storage.column(searchableTableColumns[i]).search(filterList[i])
    }
    storage.draw()
}

function getAndShowSearchSelectValue(){
    if(getSearchSelectURL.length == 0)
        return
    $.ajax({
        url: appURL + getSearchSelectURL,
        async: false,
        success: (rst) => {
            searchFieldsOptions = rst
            console.log(searchFieldsOptions)
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
        }
    })

    var searchFieldsSlt = $("#searchFields").find("select")
    for(let i = 0; i < searchFieldsOptions.length; i++){
        $(searchFieldsSlt[i]).empty()
        var optionNode = document.createElement('option')
        optionNode.innerText = '--请选择--'
        optionNode.value = ''
        searchFieldsSlt[i].append(optionNode)
        for(let j = 0; j < searchFieldsOptions[i].length; j++){
            var optionNode = document.createElement('option')
            optionNode.innerText = searchFieldsOptions[i][j]
            optionNode.value = searchFieldsOptions[i][j]
            searchFieldsSlt[i].append(optionNode)
        }
    }
}

function getAndShowAddSelectValue(){
    if(getAddSelectURL.length == 0)
        return
    $.ajax({
        url: appURL + getAddSelectURL,
        async: false,
        success: (rst) => {
            FieldsOptions = rst
            console.log(FieldsOptions)
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
        }
    })
    var addModalSlt = $("#addModal").find("select")
    var Slt = []
    if(addModalSlt.length > 0){
        Slt.push(addModalSlt)
    }
    for(let i = 0; i < FieldsOptions.length; i++){
        for(let j = 0; j < Slt.length; j++){
            $(Slt[j][i]).empty()
            var optionNode = document.createElement('option')
            optionNode.innerText = '--请选择--'
            optionNode.value = ''
            Slt[j][i].append(optionNode)
        }
        for(let j = 0; j < FieldsOptions[i].length; j++){
            var optionValue = FieldsOptions[i][j]
            for(let k = 0; k < Slt.length; k++){
                var optionNode = document.createElement('option')
                optionNode.innerText = optionValue
                optionNode.value = optionValue
                Slt[k][i].append(optionNode)
            }
        }
    }
}


function getAndShowSetSelectValue(){
    if(getAddSelectURL.length == 0)
        return
    $.ajax({
        url: appURL + getAddSelectURL,
        async: false,
        success: (rst) => {
            FieldsOptions = rst
            console.log(FieldsOptions)
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
        }
    })
    var setModalSlt = $("#setModal").find("select")
    var Slt = []
    if(setModalSlt.length > 0){
        Slt.push(setModalSlt)
    }
    for(let i = 0; i < FieldsOptions.length; i++){
        for(let j = 0; j < Slt.length; j++){
            $(Slt[j][i]).empty()
            var optionNode = document.createElement('option')
            optionNode.innerText = '--请选择--'
            optionNode.value = ''
            Slt[j][i].append(optionNode)
        }
        for(let j = 0; j < FieldsOptions[i].length; j++){
            var optionValue = FieldsOptions[i][j]
            for(let k = 0; k < Slt.length; k++){
                var optionNode = document.createElement('option')
                optionNode.innerText = optionValue
                optionNode.value = optionValue
                Slt[k][i].append(optionNode)
            }
        }
    }
}


function getAndShowModSelectValue(){
    if(getSelectURL.length == 0)
        return
    $.ajax({
        url: appURL + getSelectURL,
        async: false,
        success: (rst) => {
            FieldsOptions = rst
            console.log(FieldsOptions)
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
        }
    })
    var modModalSlt = $("#modifyModal").find("select")
    var Slt = []
    if(modModalSlt.length > 0){
        Slt.push(modModalSlt)
    }
    for(let i = 0; i < FieldsOptions.length; i++){
        for(let j = 0; j < Slt.length; j++){
            $(Slt[j][i]).empty()
            var optionNode = document.createElement('option')
            optionNode.innerText = '--请选择--'
            optionNode.value = ''
            Slt[j][i].append(optionNode)
        }
        for(let j = 0; j < FieldsOptions[i].length; j++){
            var optionValue = FieldsOptions[i][j]
            for(let k = 0; k < Slt.length; k++){
                var optionNode = document.createElement('option')
                optionNode.innerText = optionValue
                optionNode.value = optionValue
                Slt[k][i].append(optionNode)
            }
        }
    }
}

function getAndShowSelectValue(){
    if(getSelectURL.length == 0)
        return
    $.ajax({
        url: appURL + getSelectURL,
        async: false,
        success: (rst) => {
            FieldsOptions = rst
            console.log(FieldsOptions)
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
        }
    })
    var addModalSlt = $("#addModal").find("select")
    var modModalSlt = $("#modifyModal").find("select")
    var Slt = []
    if(addModalSlt.length > 0){
        Slt.push(addModalSlt)
    }
    if(modModalSlt.length > 0){
        Slt.push(modModalSlt)
    }
    for(let i = 0; i < FieldsOptions.length; i++){
        for(let j = 0; j < Slt.length; j++){
            $(Slt[j][i]).empty()
            var optionNode = document.createElement('option')
            optionNode.innerText = '--请选择--'
            optionNode.value = ''
            Slt[j][i].append(optionNode)
        }
        for(let j = 0; j < FieldsOptions[i].length; j++){
            var optionValue = FieldsOptions[i][j]
            for(let k = 0; k < Slt.length; k++){
                var optionNode = document.createElement('option')
                optionNode.innerText = optionValue
                optionNode.value = optionValue
                Slt[k][i].append(optionNode)
            }
        }
    }
}
function searchSelectValueUpdate(){
    var searchFields = $("#searchFields").find("[name=searchField]")
    var filterSessionObj = JSON.parse(sessionStorage.getItem("filter"))
    if(filterSessionObj != null){
        for(let i = 0; i < filterSessionObj.length; i++){
            if(filterSessionObj[i] != "" && searchFields[i].tagName == "SELECT"){
                if($(searchFields[i]).find("option[value='"+ filterSessionObj[i] +"']").length == 1){
                    $(searchFields[i]).find("option[selected=true]").prop("selected", false)
                    $(searchFields[i]).find("option[value='"+ filterSessionObj[i] +"']").prop("selected", true)
                }
                else{
                    searchClick()
                }
            }
        }
    }
}
function operationSelectValue(type = ""){
    getAndShowSearchSelectValue()
    searchSelectValueUpdate()
    additionalTips(type)
    table.ajax.reload(null, false)
}
function jumpToPage() {
    var pageInput = document.getElementById("page-input");
    var goButton = document.getElementById("go-button");
    var currentUrl = window.location.href;
    var newUrl = currentUrl.split("?")[0] + "?page=" + pageInput.value;
    window.location.href = newUrl;
}

function goBack() {
      window.location.replace(document.referrer);
    }


