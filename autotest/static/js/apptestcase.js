addURL = 'apptestcase/addApptestcase/'
addFieldNames = ['app_testcase_name', 'app_testcase_step',  'app_testcase_objname', 'app_testcase_findmethod', 'app_testcase_evelement', 'app_testcase_optmethod', 'app_testcase_testdata', 'app_testcase_assertdata', 'app_testcase_stepresult']
addRequiredFields = [0,1, 2, 3, 4, 5, 6,7,8]

modURL = 'apptestcase/modApptestcase/'
modFieldNames = ['app_testcase_name', 'app_testcase_code_order','app_testcase_step',  'app_testcase_objname', 'app_testcase_findmethod', 'app_testcase_evelement', 'app_testcase_optmethod', 'app_testcase_testdata', 'app_testcase_assertdata', 'app_testcase_stepresult']
modRequiredFields = [0, 1, 2, 3, 4, 5,6,7,8,9]
modRowIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8,9]

copyURL = 'apptestcase/copyApptestcase/'
copyFieldNames = ['app_testcase_name', 'app_testcase_step',  'app_testcase_objname', 'app_testcase_findmethod', 'app_testcase_evelement', 'app_testcase_optmethod', 'app_testcase_testdata', 'app_testcase_assertdata', 'app_testcase_stepresult']
copyRequiredFields = [0, 1, 2, 3, 4, 5,6,7,8]
copyRowIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8]

delURL = 'apptestcase/delApptestcase/'
delFieldNames = ['app_testcase_code']

runAppTestcaseBycode = 'apptestcase/run_apptestcase/'
runAppTestcaseByProduct = 'apptestcase/runAllTestcase/'

testcaseDetailRUL = 'getApptestcaseDetail/'
getSearchSelectURL = ''
getSelectURL = 'apptestcase/getAppOptions/'
searchableTableColumns = [1,2,3]

tableURL = 'apptestcase/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"run_apptestcase_bycode(this)\"> <span class=\"badge badge-success \" style=\"width: 40px;font-size: 12px\">执行</span> </a>" +
                       "<a href=\"#\" class=\"#\" onclick=\"openMod(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">修改</span> </a>" +
                       "<a href=\"#\" class=\"#\" onclick=\"openCopy(this)\"> <span class=\"badge badge-blue \" style=\"width: 40px;font-size: 12px\">复制</span> </a>" +
                       "<a href=\"#\" class=\"#\" onclick=\"showDelModal(this)\"> <span class=\"badge badge-danger \" style=\"width: 40px;font-size: 12px\">删除</span> </a>"
tableItemsPerPage = 10
tableColumnsData = [
                    { data: 0 },
                    { data: 1,
                      searchable:true,
                    },
                    { data: 2,
                      searchable:true,
                      render:function (data){
                        if (data==='pass'){
                            data='<a style=\'color:green;font-weight: bold\'>pass</a>'
                            return data
                        }
                        else if (data==='failed'){
                          data='<a style=\'color:red;font-weight: bold\'>failed</a>'
                          return data
                        }
                        else {
                            return data
                        }
                      },
                    },
                    { data: 3,
                      searchable:true,
                    },
                    { data: 4,
                      searchable:true,
                    },
                    { data: 5,
                        searchable:true,
                    },
                    { data: 7,
                        searchable:true,
                    },
                    { data: null,
                      render: function(data){
                        return tableButtonOperation
                      },
                      searchable:false,
                    }
                ]

function infoInit(){
    appCaseTableDataInit()
}

function tableSearchDataFunction(d){
  return
}


function additionalTips(type = ""){
  return null
}

caseStepInputs = 1
caseStepInput_innerHtml = "<div class=\"input-group\" style=\"margin-bottom: 15px; width: 90%;\">\
<input name=\"addInput\" id=\"caseStep\" eleName=\"caseStep\" class=\"form-control\" placeholder=\"--请输入--\" value='第1步' style='width: 5px;font-size: 12px' disabled>\
<input name=\"addInput\" eleName_objname=\"caseStep_objname\" class=\"form-control\" placeholder=\"--请输入--\"  style=\"width:120px;font-size: 12px;text-align: left\">\
<select name=\"addInput\" class=\"selectpicker form-control\" id=\"caseStep_findmethod\" eleName_findmethod=\"caseStep_findmethod\" style=\"width:112px;font-size: 12px;text-align: left\">\
     <option>find_element_by_id</option>\
     <option>find_element_by_name</option>\
     <option>find_element_by_text</option>\
     <option>find_element_by_desc</option>\
     <option>find_element_by_class</option>\
     <option>find_element_by_xpath</option>\
     <option>find_apppackage</option>\
</select>\
<input name=\"addInput\" eleName_evelement=\"caseStep_evelement\" class=\"form-control\" placeholder=\"--请输入--\" style=\"width:120px;font-size: 12px;text-align: left\">\
<select name=\"addInput\" class=\"selectpicker form-control\" id=\"caseStep_optmethod\" eleName_optmethod=\"caseStep_optmethod\" style=\"width:40px;font-size: 12px;text-align: left\">\
     <option>click</option>\
     <option>sendkey</option>\
     <option>app_start</option>\
     <option>slide</option>\
     <option>press</option>\
     <option>tap</option>\
     <option>sleep</option>\
     <option>doub_click</option>\
</select>\
<input name=\"addInput\" eleName_testdata=\"caseStep_testdata\" class=\"form-control\" placeholder=\"--请输入--\"  style='width: 30px;font-size: 12px' >\
<input name=\"addInput\" eleName_assertdata=\"caseStep_assertdata\" class=\"form-control\" placeholder=\"--请输入--\" value='None' style='width: 30px;font-size: 12px' >\
<input name=\"addInput\" eleName_stepresult=\"caseStep_stepresult\" class=\"form-control\" placeholder=\"--请输入--\" value='未执行' style='width: 20px;font-size: 12px' >\
</div>\
<div>\
<button class=\"btn btn-primary\" style=\"width: 40px; margin-left: 10px;\" onclick=\"addCaseStepInput(this)\"> + </button>\
<button class=\"btn btn-danger\" style=\"width: 40px; margin-left: 5px;\" onclick=\"subCaseStepInput(this)\"> - </button>\
</div>"

function openAdd(){
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
  caseStepInputs = 1
  addCaseStepListDiv = document.getElementsByName("addCaseStepList")[0]
  addCaseStepListDiv.innerHTML = ""
  var elm1 = document.createElement('div')
  elm1.setAttribute('class', 'row')
  elm1.innerHTML = caseStepInput_innerHtml
  addCaseStepListDiv.appendChild(elm1)
  addModal.modal('show')
  addObjects()
  window.event.stopPropagation()
}

function openMod(ele){
    selectedRow = ele.parentNode.parentNode
    app_testcase_code = selectedRow.children[0].innerText
    app_testcase_name = selectedRow.children[1].innerText
    app_testcase_code_order = selectedRow.children[6].innerText
    $.ajax({
        url: "/autotest/apptestcase/showModAppTestcase/",
        data: JSON.stringify({
            id1: app_testcase_code,
            name1: app_testcase_name,
            order1: app_testcase_code_order,
        }),
        contentType: 'application/json;charset=utf-8',
        type: "POST",
        traditional: true,
        success: function (result) {
            $('#modModal').find('.modal-title').text('编辑测试用例：' + app_testcase_code);
            document.getElementsByName('modInput')[0].value = app_testcase_name;
            document.getElementsByName('modInput')[1].value = app_testcase_code_order;
            var case_steps = result['case_step_list'].split(',');
            var objname = result['objname'].split(',');
            var findmethod = result['findmethod'].split(',');
            var evelement = result['evelement'].split(',');
            var optmethod = result['optmethod'].split(',');
            var testdata = result['testdata'].split(',');
            var assertdata = result['assertdata'].split(',');
            var stepresult = result['stepresult'].split(',');
            caseStepInputs = 0
            modCaseStepListDiv = document.getElementsByName("modCaseStepList")[0]
            modCaseStepListDiv.innerHTML = ""
            for (var i = 0; i < case_steps.length; i++) {
                var tmp_append = '<div class="input-group" style="margin-bottom: 15px; width: 90%;">'+
                            '<input name="modInput" id="caseStep" eleName="caseStep" class="form-control" placeholder="--请输入--" value='+case_steps[i]+' style="width: 5px;font-size: 12px" disabled>'+
                            '<input name="modInput" eleName_objname="caseStep_objname" class="form-control" placeholder="--请输入--" value='+objname[i]+' style="width:120px;font-size: 12px;text-align: left">'+
                            '<select name=\"modInput\" class="selectpicker form-control" id="caseStep_findmethod" eleName_findmethod="caseStep_findmethod" style="width:112px;font-size: 12px;text-align: left">'+
                                '<option>'+findmethod[i]+'</option>'+
                                '<option>find_element_by_id</option>'+
                                '<option>find_element_by_name</option>'+
                                '<option>find_element_by_text</option>'+
                                '<option>find_element_by_desc</option>'+
                                '<option>find_element_by_class</option>'+
                                '<option>find_element_by_xpath</option>'+
                                '<option>find_apppackage</option>'+
                            '</select>'+
                           '<input name="modInput" eleName_evelement="caseStep_evelement" class="form-control" placeholder="--请输入--" value='+evelement[i]+' style="width:120px;font-size: 12px;text-align: left">'+
                           '<select name=\"modInput\" class="selectpicker form-control" id="caseStep_optmethod" eleName_optmethod="caseStep_optmethod" style="width:40px;font-size: 12px;text-align: left">'+
                               '<option>'+optmethod[i]+'</option>'+
                                '<option>click</option>'+
                                '<option>sendkey</option>'+
                                '<option>app_start</option>'+
                                '<option>slide</option>'+
                                '<option>press</option>'+
                                '<option>tap</option>'+
                                '<option>sleep</option>'+
                                '<option>doub_click</option>'+
                           '</select>'+
                           '<input name="modInput" eleName_testdata="caseStep_testdata" class="form-control" placeholder="--请输入--" value='+testdata[i]+' style="width: 30px;font-size: 12px" >'+
                           '<input name="modInput" eleName_assertdata="caseStep_assertdata" class="form-control" placeholder="--请输入--" value='+assertdata[i]+' style="width: 30px;font-size: 12px" >'+
                           '<input name="modInput" eleName_stepresult="caseStep_stepresult" class="form-control" placeholder="--请输入--" value='+stepresult[i]+' style="width: 20px;font-size: 12px" >'+
                        '</div>'+
                        '<div>'+
                           '<button class="btn btn-primary" style="width: 40px; margin-left: 10px;" onclick="addCaseStepInput(this)"> + </button>'+
                           '<button class="btn btn-danger" style="width: 40px; margin-left: 5px;" onclick="subCaseStepInput(this)"> - </button>'+
                        '</div>';
                var elm1 = document.createElement('div')
                elm1.setAttribute('class', 'row')
                elm1.innerHTML = tmp_append
                modCaseStepListDiv.appendChild(elm1)
            }
            $('#modModal').modal();
            modObjects()
            window.event.stopPropagation()
            },
        fail: function (result) {
            debugger
        }
    });
}


function openCopy(ele){
    selectedRow = ele.parentNode.parentNode
    app_testcase_code = selectedRow.children[0].innerText
    app_testcase_name = selectedRow.children[1].innerText
    $.ajax({
        url: "/autotest/apptestcase/showCopyAppTestcase/",
        data: JSON.stringify({
            id1: app_testcase_code,
            name1: app_testcase_name,
        }),
        contentType: 'application/json;charset=utf-8',
        type: "POST",
        traditional: true,
        success: function (result) {
            $('#copyModal').find('.modal-title').text('复制测试用例：' + app_testcase_code);
            document.getElementsByName('copyInput')[0].value = app_testcase_name;
            var case_steps = result['case_step_list'].split(',');
            var objname = result['objname'].split(',');
            var findmethod = result['findmethod'].split(',');
            var evelement = result['evelement'].split(',');
            var optmethod = result['optmethod'].split(',');
            var testdata = result['testdata'].split(',');
            var assertdata = result['assertdata'].split(',');
            var stepresult = result['stepresult'].split(',');
            caseStepInputs = 0
            copyCaseStepListDiv = document.getElementsByName("copyCaseStepList")[0]
            copyCaseStepListDiv.innerHTML = ""
            for (var i = 0; i < case_steps.length; i++) {
                var tmp_append = '<div class="input-group" style="margin-bottom: 15px; width: 90%;">'+
                            '<input name="copyInput" id="caseStep" eleName="caseStep" class="form-control" placeholder="--请输入--" value='+case_steps[i]+' style="width: 5px;font-size: 12px" disabled>'+
                            '<input name="copyInput" eleName_objname="caseStep_objname" class="form-control" placeholder="--请输入--" value='+objname[i]+' style="width:120px;font-size: 12px;text-align: left">'+
                            '<select name=\"copyInput\" class="selectpicker form-control" id="caseStep_findmethod" eleName_findmethod="caseStep_findmethod" style="width:112px;font-size: 12px;text-align: left">'+
                                '<option>'+findmethod[i]+'</option>'+
                                '<option>find_element_by_id</option>'+
                                '<option>find_element_by_name</option>'+
                                '<option>find_element_by_text</option>'+
                                '<option>find_element_by_desc</option>'+
                                '<option>find_element_by_class</option>'+
                                '<option>find_element_by_xpath</option>'+
                                '<option>find_apppackage</option>'+
                            '</select>'+
                           '<input name="copyInput" eleName_evelement="caseStep_evelement" class="form-control" placeholder="--请输入--" value='+evelement[i]+' style="width:120px;font-size: 12px;text-align: left">'+
                           '<select name=\"copyInput\" class="selectpicker form-control" id="caseStep_optmethod" eleName_optmethod="caseStep_optmethod" style="width:40px;font-size: 12px;text-align: left">'+
                               '<option>'+optmethod[i]+'</option>'+
                                '<option>click</option>'+
                                '<option>sendkey</option>'+
                                '<option>app_start</option>'+
                                '<option>slide</option>'+
                                '<option>press</option>'+
                                '<option>tap</option>'+
                                '<option>sleep</option>'+
                                '<option>doub_click</option>'+
                           '</select>'+
                           '<input name="copyInput" eleName_testdata="caseStep_testdata" class="form-control" placeholder="--请输入--" value='+testdata[i]+' style="width: 30px;font-size: 12px" >'+
                           '<input name="copyInput" eleName_assertdata="caseStep_assertdata" class="form-control" placeholder="--请输入--" value='+assertdata[i]+' style="width: 30px;font-size: 12px" >'+
                           '<input name="copyInput" eleName_stepresult="caseStep_stepresult" class="form-control" placeholder="--请输入--" value='+stepresult[i]+' style="width: 20px;font-size: 12px" >'+
                        '</div>'+
                        '<div>'+
                           '<button class="btn btn-primary" style="width: 40px; margin-left: 10px;" onclick="addCaseStepInput(this)"> + </button>'+
                           '<button class="btn btn-danger" style="width: 40px; margin-left: 5px;" onclick="subCaseStepInput(this)"> - </button>'+
                        '</div>';
                var elm1 = document.createElement('div')
                elm1.setAttribute('class', 'row')
                elm1.innerHTML = tmp_append
                copyCaseStepListDiv.appendChild(elm1)
            }
            $('#copyModal').modal();
            copyObjects()
            window.event.stopPropagation()
            },
        fail: function (result) {
            debugger
        }
    });
}

function addCaseStepInput(e){
  var elm1 = document.createElement('div')

  elm1.setAttribute('class', 'row')
  elm1.innerHTML = caseStepInput_innerHtml

  e.parentNode.parentNode.parentNode.insertBefore(elm1, e.parentNode.parentNode.nextSibling)
  caseStepInputs += 1

  var rowNumberElement = $("[eleName]")
  for (i=0;i<rowNumberElement.length;i++){
      var j=i+1;
      rowNumberElement[i].value = "第"+j+"步";
  }
}

function subCaseStepInput(e){
  if(caseStepInputs == 1){
    alert("至少保留一个输入框")
    return
  }

  e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode)
  caseStepInputs -= 1

  var rowNumberElement = $("[eleName]")
  for (i=0;i<rowNumberElement.length;i++){
      var j=i+1;
      rowNumberElement[i].value = "第"+j+"步";
  }
}

function addSave(tips="新增成功"){
  var inputFields = $("[name=addInput]")
  for(var i = 0; i < addRequiredFields.length; i++){
      if(inputFields[addRequiredFields[i]].value == ''){
          return alert("*号信息为必填项！")
      }
  }
  $.ajax({
      url: appURL + addURL,
      type: "POST",
      aysnc: false,
      data: addObjects(),
      success: (rst) => {
          if(rst === '200'){
              operationSelectValue('add')
              alert(tips)
              $("#addModal").modal('hide')
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

function modSave(tips="修改成功"){
  var inputFields = $("[name=modInput]")
  for(var i = 0; i < modRequiredFields.length; i++){
      if(inputFields[modRequiredFields[i]].value == ''){
          return alert("*号信息为必填项！")
      }
  }
  $.ajax({
      url: appURL + modURL,
      type: "POST",
      aysnc: false,
      data: modObjects(),
      success: (rst) => {
          if(rst === '200'){
              operationSelectValue('modify')
              alert(tips)
              $("#modModal").modal('hide')
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert('保存失败！')
      },
  })
}


function copySave(tips="复制成功"){
  var inputFields = $("[name=copyInput]")
  for(var i = 0; i < copyRequiredFields.length; i++){
      if(inputFields[copyRequiredFields[i]].value == ''){
          return alert("*号信息为必填项！")
      }
  }
  $.ajax({
      url: appURL + copyURL,
      type: "POST",
      aysnc: false,
      data: copyObjects(),
      success: (rst) => {
          if(rst === '200'){
              operationSelectValue('copy')
              alert(tips)
              $("#copyModal").modal('hide')
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert('复制失败！')
      },
  })
}

function run_apptestcase_bycode(e,tips="运行成功"){
  selectedRow = e.parentNode.parentNode
  app_testcase_code = selectedRow.children[0].innerText

  $.ajax({
      url: appURL + runAppTestcaseBycode+app_testcase_code,
      type: "POST",
      aysnc: false,
      data: function(dp){
                dp.app_testcase_code = app_testcase_code
            },
      success: (rst) => {
          if(rst === '200'){
              alert(tips)
              $("#addModal").modal('hide')
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert('运行有误，请检查appium或uiautomator2的安装配置、系统设置中App设置、手机连接设置等信息是否正确 !')
      },
  })
}

function run_apptestcase_byproduct(e,tips="运行成功"){
  $.ajax({
      url: appURL + runAppTestcaseByProduct,
      type: "POST",
      aysnc: false,
      data: function(dp){
            },
      success: (rst) => {
          if(rst === '200'){
              alert(tips)
              $("#addModal").modal('hide')
          }
          else{
              return alert(rst)
          }
      },
      error: (rst) =>{
          return alert('运行有误，请检查appium或uiautomator2的安装配置、系统设置中App设置、手机连接设置等信息是否正确 !')
      },
  })
}


function apptestcase_code(e) {
    window.event.stopPropagation()
    selectedRow = e.parentNode.parentNode
    app_testcase_code = selectedRow.children[0].innerText
    return app_testcase_code
}

function addObjects(){
  caseStepFields = $("[name=addInput]").not("[eleName]")
  caseStepFields_objname = $("[name=addInput]").not("[eleName_objname]")
  caseStepFields_findmethod = $("[name=addInput]").not("[eleName_findmethod]")
  caseStepFields_evelement = $("[name=addInput]").not("[eleName_evelement]")
  caseStepFields_optmethod = $("[name=addInput]").not("[eleName_optmethod]")
  caseStepFields_testdata = $("[name=addInput]").not("[eleName_testdata]")
  caseStepFields_assertdata = $("[name=addInput]").not("[eleName_assertdata]")
  caseStepFields_stepresult = $("[name=addInput]").not("[eleName_stepresult]")
  caseStepFields_evelementtype = $("[name=addInput]").not("[eleName_evelementtype]")

  caseStepListFields = $("[eleName]")
  caseStepListFields_objname = $("[eleName_objname]")
  caseStepListFields_findmethod = $("[eleName_findmethod]")
  caseStepListFields_evelement = $("[eleName_evelement]")
  caseStepListFields_optmethod = $("[eleName_optmethod]")
  caseStepListFields_testdata = $("[eleName_testdata]")
  caseStepListFields_assertdata = $("[eleName_assertdata]")
  caseStepListFields_stepresult = $("[eleName_stepresult]")
  caseStepListFields_evelementtype = $("[eleName_evelementtype]")

  caseStepList = []
  caseStepList_objname = []
  caseStepList_findmethod = []
  caseStepList_evelement = []
  caseStepList_optmethod = []
  caseStepList_testdata = []
  caseStepList_assertdata = []
  caseStepList_stepresult = []
  caseStepList_evelementtype = []


  dataObj = {}
  for(let i = 0; i < caseStepFields.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields[i].value
  }
  for(let i = 0; i < caseStepFields_objname.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_objname[i].value
  }
  for(let i = 0; i < caseStepFields_findmethod.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_findmethod[i].value
  }
  for(let i = 0; i < caseStepFields_evelement.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_evelement[i].value
  }
  for(let i = 0; i < caseStepFields_optmethod.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_optmethod[i].value
  }
  for(let i = 0; i < caseStepFields_testdata.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_testdata[i].value
  }
  for(let i = 0; i < caseStepFields_assertdata.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_assertdata[i].value
  }
  for(let i = 0; i < caseStepFields_stepresult.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_stepresult[i].value
  }
  for(let i = 0; i < caseStepFields_evelementtype.length; i++){
    dataObj[addFieldNames[i]] = caseStepFields_evelementtype[i].value
  }

  for(let i = 0; i < caseStepListFields.length; i++){
    if(caseStepListFields[i].value.length > 0){
        caseStepList.push(caseStepListFields[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_objname.length; i++){
    if(caseStepListFields_objname[i].value.length > 0){
        caseStepList_objname.push(caseStepListFields_objname[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_findmethod.length; i++){
    if(caseStepListFields_findmethod[i].value.length > 0){
        caseStepList_findmethod.push(caseStepListFields_findmethod[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_evelement.length; i++){
    if(caseStepListFields_evelement[i].value.length > 0){
        caseStepList_evelement.push(caseStepListFields_evelement[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_optmethod.length; i++){
    if(caseStepListFields_optmethod[i].value.length > 0){
        caseStepList_optmethod.push(caseStepListFields_optmethod[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_testdata.length; i++){
    if(caseStepListFields_testdata[i].value.length > 0){
        caseStepList_testdata.push(caseStepListFields_testdata[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_assertdata.length; i++){
    if(caseStepListFields_assertdata[i].value.length > 0){
        caseStepList_assertdata.push(caseStepListFields_assertdata[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_stepresult.length; i++){
    if(caseStepListFields_stepresult[i].value.length > 0){
        caseStepList_stepresult.push(caseStepListFields_stepresult[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_evelementtype.length; i++){
    if(caseStepListFields_evelementtype[i].value.length > 0){
        caseStepList_evelementtype.push(caseStepListFields_evelementtype[i].value)
    }
  }

  dataObj["caseStepList"] = caseStepList
  dataObj["caseStepList_objname"] = caseStepList_objname
  dataObj["caseStepList_findmethod"] = caseStepList_findmethod
  dataObj["caseStepList_evelement"] = caseStepList_evelement
  dataObj["caseStepList_optmethod"] = caseStepList_optmethod
  dataObj["caseStepList_testdata"] = caseStepList_testdata
  dataObj["caseStepList_assertdata"] = caseStepList_assertdata
  dataObj["caseStepList_stepresult"] = caseStepList_stepresult
  dataObj["caseStepList_evelementtype"] = caseStepList_evelementtype
  return dataObj
}

function modObjects(){
  caseStepFields = $("[name=modInput]").not("[eleName]")
  caseStepFields_objname = $("[name=modInput]").not("[eleName_objname]")
  caseStepFields_findmethod = $("[name=modInput]").not("[eleName_findmethod]")
  caseStepFields_evelement = $("[name=modInput]").not("[eleName_evelement]")
  caseStepFields_optmethod = $("[name=modInput]").not("[eleName_optmethod]")
  caseStepFields_testdata = $("[name=modInput]").not("[eleName_testdata]")
  caseStepFields_assertdata = $("[name=modInput]").not("[eleName_assertdata]")
  caseStepFields_stepresult = $("[name=modInput]").not("[eleName_stepresult]")
  caseStepFields_evelementtype = $("[name=modInput]").not("[eleName_evelementtype]")

  caseStepListFields = $("[eleName]")
  caseStepListFields_objname = $("[eleName_objname]")
  caseStepListFields_findmethod = $("[eleName_findmethod]")
  caseStepListFields_evelement = $("[eleName_evelement]")
  caseStepListFields_optmethod = $("[eleName_optmethod]")
  caseStepListFields_testdata = $("[eleName_testdata]")
  caseStepListFields_assertdata = $("[eleName_assertdata]")
  caseStepListFields_stepresult = $("[eleName_stepresult]")
  caseStepListFields_evelementtype = $("[eleName_evelementtype]")

  caseStepList = []
  caseStepList_objname = []
  caseStepList_findmethod = []
  caseStepList_evelement = []
  caseStepList_optmethod = []
  caseStepList_testdata = []
  caseStepList_assertdata = []
  caseStepList_stepresult = []
  caseStepList_evelementtype = []


  dataObj = {}
  for(let i = 0; i < caseStepFields.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields[i].value
  }
  for(let i = 0; i < caseStepFields_objname.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_objname[i].value
  }
  for(let i = 0; i < caseStepFields_findmethod.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_findmethod[i].value
  }
  for(let i = 0; i < caseStepFields_evelement.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_evelement[i].value
  }
  for(let i = 0; i < caseStepFields_optmethod.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_optmethod[i].value
  }
  for(let i = 0; i < caseStepFields_testdata.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_testdata[i].value
  }
  for(let i = 0; i < caseStepFields_assertdata.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_assertdata[i].value
  }
  for(let i = 0; i < caseStepFields_stepresult.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_stepresult[i].value
  }
  for(let i = 0; i < caseStepFields_evelementtype.length; i++){
    dataObj[modFieldNames[i]] = caseStepFields_evelementtype[i].value
  }

  for(let i = 0; i < caseStepListFields.length; i++){
    if(caseStepListFields[i].value.length > 0){
        caseStepList.push(caseStepListFields[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_objname.length; i++){
    if(caseStepListFields_objname[i].value.length > 0){
        caseStepList_objname.push(caseStepListFields_objname[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_findmethod.length; i++){
    if(caseStepListFields_findmethod[i].value.length > 0){
        caseStepList_findmethod.push(caseStepListFields_findmethod[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_evelement.length; i++){
    if(caseStepListFields_evelement[i].value.length > 0){
        caseStepList_evelement.push(caseStepListFields_evelement[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_optmethod.length; i++){
    if(caseStepListFields_optmethod[i].value.length > 0){
        caseStepList_optmethod.push(caseStepListFields_optmethod[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_testdata.length; i++){
    if(caseStepListFields_testdata[i].value.length > 0){
        caseStepList_testdata.push(caseStepListFields_testdata[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_assertdata.length; i++){
    if(caseStepListFields_assertdata[i].value.length > 0){
        caseStepList_assertdata.push(caseStepListFields_assertdata[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_stepresult.length; i++){
    if(caseStepListFields_stepresult[i].value.length > 0){
        caseStepList_stepresult.push(caseStepListFields_stepresult[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_evelementtype.length; i++){
    if(caseStepListFields_evelementtype[i].value.length > 0){
        caseStepList_evelementtype.push(caseStepListFields_evelementtype[i].value)
    }
  }

  var id1 = $('#modModal').find('.modal-title')[0].textContent
  id1 = id1.split("：")[1];
  var order1 = document.getElementsByName('modInput')[1].value;
  dataObj["order1"] = order1
  dataObj["id1"] = id1
  dataObj["caseStepList"] = caseStepList
  dataObj["caseStepList_objname"] = caseStepList_objname
  dataObj["caseStepList_findmethod"] = caseStepList_findmethod
  dataObj["caseStepList_evelement"] = caseStepList_evelement
  dataObj["caseStepList_optmethod"] = caseStepList_optmethod
  dataObj["caseStepList_testdata"] = caseStepList_testdata
  dataObj["caseStepList_assertdata"] = caseStepList_assertdata
  dataObj["caseStepList_stepresult"] = caseStepList_stepresult
  dataObj["caseStepList_evelementtype"] = caseStepList_evelementtype
  return JSON.stringify({dataObj})
}



function copyObjects(){
  caseStepFields = $("[name=copyInput]").not("[eleName]")
  caseStepFields_objname = $("[name=copyInput]").not("[eleName_objname]")
  caseStepFields_findmethod = $("[name=copyInput]").not("[eleName_findmethod]")
  caseStepFields_evelement = $("[name=copyInput]").not("[eleName_evelement]")
  caseStepFields_optmethod = $("[name=copyInput]").not("[eleName_optmethod]")
  caseStepFields_testdata = $("[name=copyInput]").not("[eleName_testdata]")
  caseStepFields_assertdata = $("[name=copyInput]").not("[eleName_assertdata]")
  caseStepFields_stepresult = $("[name=copyInput]").not("[eleName_stepresult]")
  caseStepFields_evelementtype = $("[name=copyInput]").not("[eleName_evelementtype]")

  caseStepListFields = $("[eleName]")
  caseStepListFields_objname = $("[eleName_objname]")
  caseStepListFields_findmethod = $("[eleName_findmethod]")
  caseStepListFields_evelement = $("[eleName_evelement]")
  caseStepListFields_optmethod = $("[eleName_optmethod]")
  caseStepListFields_testdata = $("[eleName_testdata]")
  caseStepListFields_assertdata = $("[eleName_assertdata]")
  caseStepListFields_stepresult = $("[eleName_stepresult]")
  caseStepListFields_evelementtype = $("[eleName_evelementtype]")

  caseStepList = []
  caseStepList_objname = []
  caseStepList_findmethod = []
  caseStepList_evelement = []
  caseStepList_optmethod = []
  caseStepList_testdata = []
  caseStepList_assertdata = []
  caseStepList_stepresult = []
  caseStepList_evelementtype = []


  dataObj = {}
  for(let i = 0; i < caseStepFields.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields[i].value
  }
  for(let i = 0; i < caseStepFields_objname.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_objname[i].value
  }
  for(let i = 0; i < caseStepFields_findmethod.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_findmethod[i].value
  }
  for(let i = 0; i < caseStepFields_evelement.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_evelement[i].value
  }
  for(let i = 0; i < caseStepFields_optmethod.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_optmethod[i].value
  }
  for(let i = 0; i < caseStepFields_testdata.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_testdata[i].value
  }
  for(let i = 0; i < caseStepFields_assertdata.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_assertdata[i].value
  }
  for(let i = 0; i < caseStepFields_stepresult.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_stepresult[i].value
  }
  for(let i = 0; i < caseStepFields_evelementtype.length; i++){
    dataObj[copyFieldNames[i]] = caseStepFields_evelementtype[i].value
  }

  for(let i = 0; i < caseStepListFields.length; i++){
    if(caseStepListFields[i].value.length > 0){
        caseStepList.push(caseStepListFields[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_objname.length; i++){
    if(caseStepListFields_objname[i].value.length > 0){
        caseStepList_objname.push(caseStepListFields_objname[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_findmethod.length; i++){
    if(caseStepListFields_findmethod[i].value.length > 0){
        caseStepList_findmethod.push(caseStepListFields_findmethod[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_evelement.length; i++){
    if(caseStepListFields_evelement[i].value.length > 0){
        caseStepList_evelement.push(caseStepListFields_evelement[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_optmethod.length; i++){
    if(caseStepListFields_optmethod[i].value.length > 0){
        caseStepList_optmethod.push(caseStepListFields_optmethod[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_testdata.length; i++){
    if(caseStepListFields_testdata[i].value.length > 0){
        caseStepList_testdata.push(caseStepListFields_testdata[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_assertdata.length; i++){
    if(caseStepListFields_assertdata[i].value.length > 0){
        caseStepList_assertdata.push(caseStepListFields_assertdata[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_stepresult.length; i++){
    if(caseStepListFields_stepresult[i].value.length > 0){
        caseStepList_stepresult.push(caseStepListFields_stepresult[i].value)
    }
  }
  for(let i = 0; i < caseStepListFields_evelementtype.length; i++){
    if(caseStepListFields_evelementtype[i].value.length > 0){
        caseStepList_evelementtype.push(caseStepListFields_evelementtype[i].value)
    }
  }

  var id1 = $('#copyModal').find('.modal-title')[0].textContent
  id1 = id1.split("：")[1];
  dataObj["id1"] = id1
  dataObj["caseStepList"] = caseStepList
  dataObj["caseStepList_objname"] = caseStepList_objname
  dataObj["caseStepList_findmethod"] = caseStepList_findmethod
  dataObj["caseStepList_evelement"] = caseStepList_evelement
  dataObj["caseStepList_optmethod"] = caseStepList_optmethod
  dataObj["caseStepList_testdata"] = caseStepList_testdata
  dataObj["caseStepList_assertdata"] = caseStepList_assertdata
  dataObj["caseStepList_stepresult"] = caseStepList_stepresult
  dataObj["caseStepList_evelementtype"] = caseStepList_evelementtype
  return JSON.stringify({dataObj})
}
