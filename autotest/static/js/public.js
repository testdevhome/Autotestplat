appURL = '/autotest/'
loginPageURL = '/autotest/login/'
loginVerifyURL = '/autotest/login/identify/'
indexURL = '/autotest/apitestcase/'
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
                            var uiDropdown = document.getElementById('uiDropdown');
                            var uiDropdownMenu = document.getElementById('uiDropdownMenu');
                            var userDropdown = document.getElementById('navUser');
                            var userDropdownMenu = document.getElementById('userDropdownMenu');
                            function showUIDropdown() {
                                uiDropdownMenu.style.display = 'block';
                            }
                            function showUserDropdown() {
                                userDropdownMenu.style.display = 'block';
                            }
                            function hideUIDropdown() {
                                uiDropdownMenu.style.display = 'none';
                            }
                            function hideUserDropdown() {
                                userDropdownMenu.style.display = 'none';
                            }
                            uiDropdown.addEventListener('mouseover', showUIDropdown);
                            uiDropdown.addEventListener('mouseout', hideUIDropdown);
                            userDropdown.addEventListener('mouseover', showUserDropdown);
                            userDropdown.addEventListener('mouseout', hideUserDropdown);
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

                $(document).ready(function() {
                    $.ajax({
                        url: '/autotest/user/get/',
                        type: 'POST',
                        success: function(response) {
                            if (response) {
                                $('#select-option').val(response);
                            }
                        },
                        error: function(error) {
                            console.log('Error value:', error);
                        }
                    });
                });
            };
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

function saveOption() {
    var selectedOption = $("#select-option").val();
    if (selectedOption) {
        $.ajax({
            url: '/autotest/user/set/',
            type: 'POST',
            data: { 'product_name': selectedOption },
            success: function(response) {
                console.log('Saved successfully');
                location.reload();
                },
            error: function(error) {
                console.log('Error saving to database:', error);
            }
        });
    }
}

function setUser(mKey,mValue){
    var valStr = JSON.stringify(mValue)
    localStorage.setItem(mKey, valStr)
}

function showUserName(str){
    $("#userName").html('<img src="/static/src/pic/user.png" width="15px" style="border-radius: 50%" alt="UserAvatar">' + str);
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
        order: [[0, "id"]],
        columns: tableColumnsData,
        columnDefs: [
            {
                targets: [],
                visible: false,
            }
        ]
    });
}

function appCaseTableDataInit(){
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
        order: [[7, "order"]],
        columns: tableColumnsData,
        columnDefs: [
            {
                targets: [],
                visible: false,
            }
        ]
    });
}

function webCaseTableDataInit(){
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
        order: [[7, "order"]],
        columns: tableColumnsData,
        columnDefs: [
            {
                targets: [],
                visible: false,
            }
        ]
    });
}
function run(e,tips="运行成功,请在测试报告中查看结果"){
  fieldValues =  e.getAttribute('data-fieldvalues');
  var intervalId = setInterval(function() {
      $.ajax({
          url: appURL+getProgressURL+fieldValues+'/',
          type: 'POST',
          data: {
              suit_id: fieldValues
          },
          success: (rst) => {
              var progressBarId = 'progressBar_' + fieldValues;
              var progressBar = document.getElementById(progressBarId);
              progressBar.value = rst.progress;
              var runTimeId = 'run_time_' + fieldValues;
              var runTime = document.getElementById(runTimeId);
              runTime.textContent = rst.run_time;
              if (progressBar.value === progressBar.max) {
                  clearInterval(intervalId);
              }
              },
          });
      }, 100);

  $.ajax({
      url: appURL + runURL+fieldValues+'/',
      type: "POST",
      aysnc: false,
      data: function(dp){
                dp.fieldValues = fieldValues
                console.log(dp.fieldValues)
            },
      success: (rst) => {
          if(rst === '200'){
              setTimeout(function() {
                console.log(tips);
                return alert(tips);
              }, 1000);
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
                return alert(rst)
            }
        },
        error: (rst) =>{
            console.log(rst)
            return alert(rst)
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
            temp.value = selectedRow.children[modRowIndex[i]].innerText
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
            console.log(i)
            console.log(setRowIndex[i])
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
                window.location.reload()
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


function modUser(tips="修改成功"){
    var inputFields = $("[name=modInput]")
    for(var i = 0; i < modRequiredFields.length; i++){
        if(inputFields[modRequiredFields[i]].value == ''){
            return alert("*信息为必填项！")
        }
    }
    var userObj = JSON.parse(localStorage.getItem('user')).userName
    $.ajax({
        url: appURL + modURL+userObj,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(modFieldNames,inputFields),
        success: (rst) => {
            if(rst.includes('200')){
                operationSelectValue('modify')
                var modUserId = inputFields[modRowIndex[0]].value
                cur_id=rst.split(',')[1]
                if(cur_id===modUserId){
                    alert("修改成功，请重新登录")
                    $("#modifyModal").modal('hide')
                    setTimeout(() => window.location = loginPageURL, 300)
                }
                else {
                    alert(tips)
                    $("#modifyModal").modal('hide')
                }
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
            console.log(inputFields[modRequiredFields[i]].value)
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
            inputFields[i].value = selectedRow.children[i].innerText
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


function getAndShowSecondSelectValue(){
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
            $(Slt[j][1]).empty()
            var optionNode = document.createElement('option')
            optionNode.innerText = '--请选择--'
            optionNode.value = ''
            Slt[j][1].append(optionNode)
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


function checkAll(chkall) {
  let checked = chkall.checked;
  let currentPageCheckboxes = $("#blocks tbody input[type=checkbox]").filter(":visible"); // 获取当前页面的复选框元素
  currentPageCheckboxes.each(function() {
    $(this).prop('checked', checked);
  });
}

function checkPage(checkbox) {
    let currentPageCheckboxes = $("#blocks tbody input[type=checkbox]").filter(":visible").get(); // 获取当前页面的复选框元素
    let allChecked = currentPageCheckboxes.every(function(index, element) {
        return $(element).prop('checked');
    });
    $.each(currentPageCheckboxes, function() {
        console.log($(this).prop('checked'));
    });
    var cur_count = $('#blocks tbody input[type="checkbox"]').filter(":visible").length;
    var count = $('#blocks tbody input[type="checkbox"]:checked').filter(":visible").length;
    if (count==cur_count){
        allChecked = true
    }
    $('#blocks input[name="chkall"]').prop('checked', allChecked);
}

function checkEditAll(chkeditall) {
  let checked = chkeditall.checked;
  let currentPageCheckboxes = $("#add_interface_table1 tbody.tbody_interface1 input[type=checkbox]").filter(":visible"); // 获取当前页面的复选框元素
  currentPageCheckboxes.each(function() {
    $(this).prop('checked', checked);
  });
}

function checkEditPage(checkbox) {
    let currentPageCheckboxes = $("#add_interface_table1 tbody.tbody_interface1 input[type=checkbox]").filter(":visible").get(); // 获取当前页面的复选框元素
    let allChecked = currentPageCheckboxes.every(function(index, element) {
        return $(element).prop('checked');
    });
    $.each(currentPageCheckboxes, function() {
        console.log($(this).prop('checked'));
    });
    var cur_count = $('#add_interface_table1 tbody.tbody_interface1 input[type="checkbox"]').filter(":visible").length;
    var count = $('#add_interface_table1 tbody.tbody_interface1 input[type="checkbox"]:checked').filter(":visible").length;
    if (count==cur_count){
        allChecked = true
    }
    $('#add_interface_table1 input[name="chkeditall"]').prop('checked', allChecked);
}

function multipleAdd(ele){
    var checkBoxList = $("#blocks tbody input[type=checkbox]")
    var rownumList =[]
    var tableList = []
    var idList = []
    var nameList =[]
    for(let i = 0; i < checkBoxList.length; i++){
        let cb = checkBoxList[i]
        if(cb.checked == true){
            rownumList.push(cb.parentNode.nextElementSibling.innerText)
            tableList.push(cb.parentNode.nextElementSibling.nextElementSibling.innerText)
            idList.push(cb.parentNode.nextElementSibling.nextElementSibling.nextElementSibling.innerText)
            nameList.push(cb.parentNode.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.innerText)
        }
    }
    if(idList.length <= 0){
        alert("当前未选中任何信息！")
        return
    }
    for (i=0;i<idList.length;i++) {
        var head_line = $(ele).parent().parent().parent().parent().parent().parent().find('h4')[0].textContent;
        var flag = head_line.substring(0, 2);
        if (flag == '添加') {
            var tmp = document.getElementsByClassName("interface_name");
        }
        else if (flag == '编辑') {
            tmp = document.getElementsByClassName("interface_name1");
        }
        var suit_interface_id = document.getElementsByClassName("suit_interface_id");
        var suit_interface_id1 = document.getElementsByClassName("suit_interface_id1");
        rownumList[i]=parseInt(rownumList[i])-1
        rownumList[i]=rownumList[i].toString()
        tmp[i].innerHTML = tableList[i] + '_' + idList[i] + '_' + nameList[i];
        add_multi_row(ele)
    }
    del_last_row(ele)
    set_no_select(ele)
}


function add_params_add_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = paramsInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    paramsInputs += 1
}


function del_params_add_row(e){
  if(paramsInputs == 1){
    alert("至少保留一个输入框")
    return
  }
  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  paramsInputs -= 1
}



function add_head_add_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = headInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    headInputs += 1
}


function del_head_add_row(e){
    if(headInputs == 1){
        alert("至少保留一个输入框")
        return
    }
    e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
    headInputs -= 1
}


function add_head_edit_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = headEditInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    headEditInputs += 1
}

/**
 * @param {*} e
 */
function del_head_edit_row(e){
  if(headEditInputs == 1){
    alert("至少保留一个输入框")
    return
  }
  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  headEditInputs -= 1
}


function add_auth_edit_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = authEditInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    authEditInputs += 1
}


function del_auth_edit_row(e){
  if(authEditInputs == 1){
    alert("至少保留一个输入框")
    return
  }
  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  authEditInputs -= 1
}


function add_params_edit_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = paramsEditInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    paramsEditInputs += 1
}


function del_params_edit_row(e){
  if(paramsEditInputs == 1){
    alert("至少保留一个输入框")
    return
  }
  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  paramsEditInputs -= 1
}


function add_res_add_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = resInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    resInputs += 1
}


function del_res_add_row(e){
  if(resInputs == 1){
    alert("至少保留一个输入框")
    return
  }
  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  resInputs -= 1
}


function add_res_edit_row(e) {
    var elm1 = document.createElement('div')
    elm1.setAttribute('class', 'row')
    elm1.setAttribute('style',"margin-left: 0px")
    elm1.innerHTML = resEditInput_innerHtml
    e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
    resEditInputs += 1
}

function del_res_edit_row(e){
  if(resEditInputs == 1){
    alert("至少保留一个输入框")
    return
  }
  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  resEditInputs -= 1
}


function showAddModule(){
  var addModuleModal = $("#addModuleModal")
  var inputFields = addModuleModal.find("[name=addInput1]")
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
  addModuleModal.modal('show')
  window.event.stopPropagation()
}


function showAddChildModule(ele){
    curModuleName=ele.split('+')[0]
    var addChildModuleModal = $("#addChildModuleModal")
    var inputFields = addChildModuleModal.find("[name=addInput2]")
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
  var aa=document.getElementsByName('addInput2')
  console.log(aa)
  document.getElementsByName('addInput2')[0].value = curModuleName;
  addChildModuleModal.modal('show')
  window.event.stopPropagation()
}

function showModModule(id,ele){
    curModuleId=id
    curModuleName=ele.split('+')[0]
    var modModuleModal = $("#modModuleModal")
    var inputFields = $("[name=modInput1]")
    inputFields[0].value = curModuleId
    inputFields[1].value = curModuleName
    modModuleModal.modal('show')
    window.event.stopPropagation()
}

function showAddNextChildModule(ele){
    alert("仅支持添加到二级节点")
    window.event.stopPropagation()
}

function showDelMoudle(id,name){
    curModuleId=id
    curModuleName=name.split('+')[0]
    var inputFields = $("[name=delInput1]")
    inputFields[0].value = curModuleId
    inputFields[1].value = curModuleName
    $("#deleteModuleModal").modal('show')
    window.event.stopPropagation()
}

function showDelChildMoudle(id,name){
    curModuleId=id
    curModuleName=name.split('+')[0]
    var inputFields = $("[name=delInput2]")
    inputFields[0].value = curModuleId
    inputFields[1].value = curModuleName
    $("#deleteChildModuleModal").modal('show')
    window.event.stopPropagation()
}

function addModuleSave(tips="新增成功"){
  var inputFields = $("[name=addInput1]")
  for(var i = 0; i < addModuleRequiredFields.length; i++){
      if(inputFields[addModuleRequiredFields[i]].value == ''){
          return alert("*信息为必填项！")
      }
  }
  $.ajax({
      url: appURL + addModulURL,
      type: "POST",
      aysnc: false,
      data: AjaxObjectData(addModuleFieldNames,inputFields),
      success: (rst) => {
          if(rst === '200'){
              alert(tips)
              $("#addModal").modal('hide')
              window.location.reload()
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert(rst)
      },
  })
}


function addChildModuleSave(tips="新增成功"){
  var inputFields = $("[name=addInput2]")
  for(var i = 0; i < addChildModuleRequiredFields.length; i++){
      if(inputFields[addChildModuleRequiredFields[i]].value == ''){
          return alert("*信息为必填项！")
      }
  }
  $.ajax({
      url: appURL + addModulURL,
      type: "POST",
      aysnc: false,
      data: AjaxObjectData(addChildModuleFieldNames,inputFields),
      success: (rst) => {
          if(rst === '200'){
              alert(tips)
              $("#addModal").modal('hide')
              window.location.reload()
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert(rst)
      },
  })
}


function modModuleSave(tips="修改成功"){
  var inputFields = $("[name=modInput1]")
  for(var i = 0; i < modModuleRequiredFields.length; i++){
      if(inputFields[modModuleRequiredFields[i]].value == ''){
          return alert("*信息为必填项！")
      }
  }
  $.ajax({
      url: appURL + modModulURL,
      type: "POST",
      aysnc: false,
      data: AjaxObjectData(modModuleFieldNames,inputFields),
      success: (rst) => {
          if(rst === '200'){
              alert(tips)
              $("#modModuleModal").modal('hide')
              window.location.reload()
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert(rst)
      },
  })
}


function delModule(tips="删除成功"){
    var inputFields = $("[name=delInput1]")
    $.ajax({
        url: appURL + delModuleURL,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(delModuleFieldNames,inputFields),
        success: (rst) => {
            if(rst === '200'){
                alert("删除成功")
                $("#deleteModuleModal").modal('hide')
                window.location.reload()
            }
            else{
                console.log(rst)
                alert(rst)
                $("#deleteModuleModal").modal('hide')
            }
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
            $("#deleteModuleModal").modal('hide')
        },
    })
}


function delChildModule(tips="删除成功"){
    var inputFields = $("[name=delInput2]")
    $.ajax({
        url: appURL + delModuleURL,
        type: "POST",
        aysnc: false,
        data: AjaxObjectData(delModuleFieldNames,inputFields),
        success: (rst) => {
            if(rst === '200'){
                alert("删除成功")
                $("#deleteModuleModal").modal('hide')
                window.location.reload()
            }
            else{
                console.log(rst)
                alert(rst)
                $("#deleteModuleModal").modal('hide')
            }
        },
        error: (rst) => {
            console.log(rst)
            alert(rst)
            $("#deleteModuleModal").modal('hide')
        },
    })
}

function apiCaseTableDataInit(id){
    table = $('#table').DataTable({
        dom:'tp',
        pageLength: tableItemsPerPage,
        ajax: {
            url: appURL + tableURL+id+'/',
            type: "POST",
            data: tableSearchDataFunction
          },
        info: false,
        lengthChange: false,
        searching: true,
        order: [[0, "id"]],
        columns: tableColumnsData,
        columnDefs: [
            {
                targets: [],
                visible: false,
            }
        ]
    });
}

function apiCaseTableData(id){
    var table = $('#table').DataTable();
    table.destroy();
    table.draw();
    table = $('#table').DataTable({
        dom:'tp',
        pageLength: tableItemsPerPage,
        ajax: {
            url: appURL + tableURL+id+'/',
            type: "POST",
            data: tableSearchDataFunction
          },
        info: false,
        lengthChange: false,
        searching: true,
        order: [[0, "id"]],
        columns: tableColumnsData,
        columnDefs: [
            {
                targets: [],
                visible: false,
            }
        ]
    });
}