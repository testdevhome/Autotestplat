addURL='apitestcase/add/'
addFieldNames=['add_product_id','add_name','add_url_host','add_menu_module_id','mode','add_url','formated_dict','params_key','params_value','head_key','head_value','assert_keywords_old',
'resp_add_name','resp_add_keywords','resp_add_left','resp_add_right','resp_add_index',]
addRequiredFields = [0]

addModulURL ='apitestcase/addModule/'
addModuleFieldNames = ['module_name']
addModuleRequiredFields = [0]

addChildModuleFieldNames = ['parent_module_id','module_name']
addChildModuleRequiredFields = [0,1]

modModulURL ='apitestcase/modModule/'
modModuleFieldNames = ['id','module_name']
modModuleRequiredFields = [0,1]

delModuleURL = 'apitestcase/delModule/'
delModuleFieldNames = ['id','module_name']

delURL='apitestcase/del/'
delFieldNames = ['id','name']

getSearchSelectURL = ''
getSelectURL = ''
searchableTableColumns = [1,3]

tableURL='apitestcase/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"show_edit_interface(this,'{{ rec.id }}','edit')\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">编辑</span> </a>" +
                       "<a href=\"#\" class=\"#\" onclick=\"show_copy_interface(this,'{{ rec.id }}','copy')\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">复制</span> </a>" +
                       "<a href=\"#\" class=\"#\" onclick=\"showDelModal(this)\"> <span class=\"badge badge-danger \" style=\"width: 40px;font-size: 12px\">删除</span> </a>"
tableItemsPerPage = 10
tableColumnsData = [
                    { data: 0 },
                    { data: 1,
                      searchable:true,
                        render: function(data) {
                            if (data.length > 13) {
                                return data.substring(0, 13) + '...';
                            } else {
                                return data;
                            }
                        }
                    },
                    { data: 2,
                      searchable:true,
                      render:function (data){
                        if (data==='POST'){
                            data='<a style=\'color:chocolate;\'>POST</a>'
                            return data
                        }
                        else if (data==='GET'){
                          data='<a style=\'color:green;\'>GET</a>'
                          return data
                        }
                        else if (data==='PUT'){
                          data='<a style=\'color:blue;\'>PUT</a>'
                          return data
                        }
                        else if (data==='DELETE'){
                          data='<a style=\'color:maroon;\'>DELETE</a>'
                          return data
                        }
                        else if (data==='PATCH'){
                          data='<a style=\'color:mediumslateblue;\'>PATCH</a>'
                          return data
                        }
                        else if (data==='HEAD'){
                          data='<a style=\'color:green;\'>HEAD</a>'
                          return data
                        }
                        else if (data==='OPTIONS'){
                          data='<a style=\'color:rosybrown;\'>OPTIONS</a>'
                          return data
                        }
                        else {
                            return data
                        }
                      },
                    },
                    { data: "3",
                        searchable:true,
                        render: function(data) {
                            if (data.length > 30) {
                                return data.substring(0, 30) + '...';
                            } else {
                                return data;
                            }
                        }
                    },
                    { data: 4,
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
    apiCaseTableDataInit(0)
}

function tableSearchDataFunction(d){
  return
}


function additionalTips(type = ""){
  return null
}

function searchAPI(){
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

function addInterface(tips="添加成功"){
    var inputFields = $("[name=addInput]")
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
                $("#add_window").modal('hide')
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

function showRequestTab(){
     const tabs = document.querySelectorAll('.tab-content');
     const tabsArray = Array.from(tabs);
     const tabsToDisplay = tabsArray.slice(0, 6);
     document.getElementById('requesttab').addEventListener('click', (event) => {
         const targetTab = event.target.getAttribute('href');
         tabsToDisplay.forEach((tab) => {
             if (tab.id === targetTab.substring(1)) {
                 tab.style.display = 'block';
             } else {
                 tab.style.display = 'none';
             }
         });
     });

     const tabsToDisplay2 = tabsArray.slice(7, 11);
     document.getElementById('responsetab').addEventListener('click', (event) => {
         const targetTab = event.target.getAttribute('href');
         tabsToDisplay2.forEach((tab) => {
             if (tab.id === targetTab.substring(1)) {
                 tab.style.display = 'block';
             } else {
                 tab.style.display = 'none';
             }
         });
     });

}

function setSelect(){
    var select = document.getElementById("mode");
    var selectedValue = select.options[select.selectedIndex].value;
    if (selectedValue === "POST"||selectedValue === "post") {
        select.style.color = "chocolate";
        select.style.fontWeight = "bold";
    } else if (selectedValue === "GET"||selectedValue === "get") {
        select.style.color = "green";
        select.style.fontWeight = "bold";
    } else if (selectedValue === "PUT"||selectedValue === "put") {
        select.style.color = "blue";
        select.style.fontWeight = "bold";
    } else if (selectedValue === "DELETE"||selectedValue === "delete") {
        select.style.color = "Maroon";
        select.style.fontWeight = "bold";
    }

    select.addEventListener("change", function() {
        var selectedOption = select.options[select.selectedIndex];
        var textBox = document.getElementById("mode");
        textBox.value = selectedOption.text;
        textBox.style.color = selectedOption.style.color;
        textBox.style.fontWeight = selectedOption.style.fontWeight;
    });
}


function showParams(){
     var p = document.getElementById('paramsvalues').value;
     if(p!=''&&p!='{}'){
         const paramsData = JSON.parse(p);
         const paramKeys = Object.keys(paramsData);
         for (let i = 0; i < paramKeys.length; i++) {
             const key = paramKeys[i];
             const value = paramsData[key];
             var paraminputHtml = '<div class="input-group"><input id="params_key" name="params_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value=""></input> <input id="params_value" name="params_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_params_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" onclick="del_params_edit_row(this)">-</button> </div> </td> </div>'
             $('#params').find('div').last().after(paraminputHtml);
             const inputKey = document.getElementsByName('params_key')[i];
             const inputValue = document.getElementsByName('params_value')[i];
             inputKey.value = key;
             inputValue.value = value;
             paramsEditInputs += 1
         }
     }
     else {
         var paraminputHtml = '<div class="input-group"><input id="params_key" name="params_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value=""></input> <input id="params_value" name="params_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_params_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" disabled>-</button> </div> </td> </div>' +
             '<div class="input-group"><input id="params_key" name="params_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value=""></input> <input id="params_value" name="params_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_params_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" disabled>-</button> </div> </td> </div>' +
             '<div class="input-group"><input id="params_key" name="params_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value=""></input> <input id="params_value" name="params_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_params_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" disabled>-</button> </div> </td> </div>'
         $('#params').find('div').last().after(paraminputHtml);
     }
}

function showHead(){
    var h = document.getElementById('headvalues').value;
    console.log(h)
    const headData = JSON.parse(h);
    const fieldKeys = Object.keys(headData);
    if(h!='' && fieldKeys.length>1){
        for (let i = 0; i < fieldKeys.length-1; i++) {
            const key = fieldKeys[i];
            const value = headData[key];
            var headinputHtml = '<div class="input-group"><input id="head_key" name="head_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value=""></input> <input id="head_value" name="head_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_head_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" onclick="del_head_edit_row(this)">-</button> </div> </td> </div>'
            $('#head').find('div').last().after(headinputHtml);
            const inputKey = document.getElementsByName('head_key')[i];
            const inputValue = document.getElementsByName('head_value')[i];
            inputKey.value = key;
            inputValue.value = value;
            headEditInputs += 1
        }
    }
    else {
         var headinputHtml = '<div class="input-group"><input id="head_key" name="head_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value="Accept"></input> <input id="head_value" name="head_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_head_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" disabled>-</button> </div> </td> </div>' +
             '<div class="input-group"><input id="head_key" name="head_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value="Content-Type"></input> <input id="head_value" name="head_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_head_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" disabled>-</button> </div> </td> </div>' +
             '<div class="input-group"><input id="head_key" name="head_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value="Cookie"></input> <input id="head_value" name="head_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_head_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" disabled>-</button> </div> </td> </div>'
         $('#head').find('div').last().after(headinputHtml);
    }

}

function showAuth(){
    var a = document.getElementById('authvalues').value;
    const authData = JSON.parse(a);
    const authKeys = Object.keys(authData);
    var i = authKeys.length - 1
    const key = authKeys[i];
    const value = authData[key];
    var authinputHtml = '<div class="input-group"><input id="auth_key" name="auth_key" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Key" value=""></input> <input id="auth_value" name="auth_value" type="text" class="form-control" style="width:260px;font-size: 12px;text-align: center" placeholder="Value" value=""></input> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default"onclick="add_auth_edit_row(this)">+ </button> </div> </td> <td style="width: 80px;text-align: center;"> <div class="btn-group"> <button type="button" class="btn btn-default" onclick="del_auth_edit_row(this)">-</button> </div> </td> </div>'
    $('#auth').find('div').last().after(authinputHtml);
    const inputKey = document.getElementsByName('auth_key')[0];
    const inputValue = document.getElementsByName('auth_value')[0];
    inputKey.value = key;
    inputValue.value = value;
}


paramsInputs = 1
paramsInput_innerHtml = "<div class=\"input-group\">\
                            <input id=\"params_key\" name=\"params_key\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Key\"></input>\
                            <input id=\"params_value\" name=\"params_value\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Value\"></input>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\"\
                                            onclick=\"add_params_add_row(this)\">+\
                                    </button>\
                                    </div>\
                            </td>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\" onclick=\"del_params_add_row(this)\">-</button>\
                                    </div>\
                            </td>\
                         </div>"

paramsEditInputs = 0
paramsEditInput_innerHtml = "<div class=\"input-group\">\
                            <input id=\"params_key\" name=\"params_key\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Key\"></input>\
                            <input id=\"params_value\" name=\"params_value\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Value\"></input>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\"\
                                            onclick=\"add_params_edit_row(this)\">+\
                                    </button>\
                                    </div>\
                            </td>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\" onclick=\"del_params_edit_row(this)\">-</button>\
                                    </div>\
                            </td>\
                         </div>"


headInputs = 1
headInput_innerHtml = "<div class=\"input-group\">\
                            <input id=\"head_key\" name=\"head_key\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Key\"></input>\
                            <input id=\"head_value\" name=\"head_value\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Value\"></input>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\"\
                                            onclick=\"add_head_add_row(this)\">+\
                                    </button>\
                                    </div>\
                            </td>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\" onclick=\"del_head_add_row(this)\">-</button>\
                                    </div>\
                            </td>\
                         </div>"


headEditInputs = 0
headEditInput_innerHtml = "<div class=\"input-group\">\
                            <input id=\"head_key\" name=\"head_key\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Key\"></input>\
                            <input id=\"head_value\" name=\"head_value\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Value\"></input>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\"\
                                            onclick=\"add_head_edit_row(this)\">+\
                                    </button>\
                                    </div>\
                            </td>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\" onclick=\"del_head_edit_row(this)\">-</button>\
                                    </div>\
                            </td>\
                         </div>"

authEditInputs = 0
authEditInput_innerHtml = "<div class=\"input-group\">\
                            <input id=\"auth_key\" name=\"auth_key\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Key\"></input>\
                            <input id=\"auth_value\" name=\"auth_value\" type=\"text\" class=\"form-control\" style=\"width:260px;font-size: 12px;text-align: center\" placeholder=\"Value\"></input>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\"\
                                            onclick=\"add_auth_edit_row(this)\">+\
                                    </button>\
                                    </div>\
                            </td>\
                            <td style=\"width: 80px;text-align: center;\">\
                                    <div class=\"btn-group\">\
                                    <button type=\"button\" class=\"btn btn-default\" onclick=\"del_auth_edit_row(this)\">-</button>\
                                    </div>\
                            </td>\
                         </div>"

resInputs = 1
resInput_innerHtml = "<div class=\"input-group\">\
                                        <input type=\"text\" name=\"resp_add_name\" class=\"form-control\" style=\"width:105px;font-size: 12px;text-align: center\" placeholder=\"描述\">\
                                        <input type=\"text\" name=\"resp_add_keywords\" class=\"form-control\" style=\"width:105px;font-size: 12px;text-align: center\" placeholder=\"关键字\">\
                                        <input type=\"text\" name=\"resp_add_left\" class=\"form-control\" style=\"width:105px;font-size: 12px;text-align: center\" placeholder=\"左边界\">\
                                        <input type=\"text\" name=\"resp_add_right\" class=\"form-control\" style=\"width:105px;font-size: 12px;text-align: center\" placeholder=\"右边界\">\
                                        <input type=\"text\" name=\"resp_add_index\" class=\"form-control\" style=\"width:60px;font-size: 12px;text-align: center\" value='0' placeholder=\"索引\">\
                                        <td style=\"width: 80px;text-align: center;\">\
                                            <div class=\"btn-group\">\
                                                <button type=\"button\" class=\"btn btn-default\" onclick=\"add_res_add_row(this)\">+</button>\
                                            </div>\
                                        </td>\
                                        <td style=\"width: 80px;text-align: center;\">\
                                            <div class=\"btn-group\">\
                                                <button type=\"button\" class=\"btn btn-default\" onclick=\"del_res_add_row(this)\">-</button>\
                                            </div>\
                                        </td>\
                                    </div>"



resEditInputs = 0
resEditInput_innerHtml = "<div class=\"input-group\">\
                                        <input type=\"text\" name=\"resp_edit_name\" class=\"form-control\" style=\"width:105px;font-size: 12px;\" placeholder=\"\">\
                                        <input type=\"text\" name=\"resp_edit_keywords\" class=\"form-control\" style=\"width:105px;font-size: 12px;\" placeholder=\"\">\
                                        <input type=\"text\" name=\"resp_edit_left\" class=\"form-control\" style=\"width:105px;font-size: 12px;\" placeholder=\"\">\
                                        <input type=\"text\" name=\"resp_edit_right\" class=\"form-control\" style=\"width:105px;font-size: 12px;\" placeholder=\"\">\
                                        <input type=\"text\" name=\"resp_edit_index\" class=\"form-control\" style=\"width:50px;font-size: 12px;\" value='0' placeholder=\"\">\
                                        <td style=\"width: 80px;text-align: center;\">\
                                            <div class=\"btn-group\">\
                                                <button type=\"button\" class=\"btn btn-default\" onclick=\"add_res_edit_row(this)\">+</button>\
                                            </div>\
                                        </td>\
                                        <td style=\"width: 80px;text-align: center;\">\
                                            <div class=\"btn-group\">\
                                                <button type=\"button\" class=\"btn btn-default\" onclick=\"del_res_edit_row(this)\">-</button>\
                                            </div>\
                                        </td>\
                                    </div>"