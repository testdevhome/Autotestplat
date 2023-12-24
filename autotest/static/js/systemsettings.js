addURL = 'systemsettings/add/'
addFieldNames = ["product_id","type", "name", "keywords", "value","login_account","login_password","left","right"]
addRequiredFields = [0, 1, 2, 3, 4]

modURL = 'systemsettings/mod/'
modFieldNames = ["id", "product_id","type", "name", "keywords", "value","login_account","login_password","left","right"]
modRequiredFields = [0, 1, 2, 3, 4, 5]
modRowIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

delURL = 'systemsettings/del/'
delFieldNames = ["id","keywords"]

getSearchSelectURL = 'systemsettings/getSearchSelect/'
getAddSelectURL = 'systemsettings/getAddSelect/'
getSearchSelectURL = 'systemsettings/getSearchSelect/'
getSelectURL = 'systemsettings/getSelect/'
searchableTableColumns = [4, 2, 3]

tableURL = 'systemsettings/getTableData/'
table = 0
tableButtonOperation = "<a href=\"#\" class=\"#\" onclick=\"showModParaModal(this)\"> <span class=\"badge badge-primary \" style=\"width: 40px;font-size: 12px\">修改</span> </a>\
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
      else if (data == 'auth')
          data = "认证";
      else if (data == 'app')
          data = "App设置";
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
  { data: 10,
    searchable:true,
    visible: false,
  },
  { data: 11,
    searchable:true,
    visible: false,
  },
  { data: 4,
    searchable:true,
    visible: false,
  },
  { data: 5,
    searchable:true,
    visible: false,
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
    getAndShowSecondSelectValue()
    tableDataInit()

}

/**
 * @param {Object} d
 */
function tableSearchDataFunction(d){
    return null
}


function additionalTips(type = ""){
  return null
}

function addParam(){
     var addParamType = document.querySelectorAll('select[name="addInput1"]')[1];
     var addParamValue = document.querySelectorAll('div[id="addParamValue"]')[0];
     var addParamUsername = document.querySelectorAll('div[id="addParamUsername"]')[0];
     var addParamPassword = document.querySelectorAll('div[id="addParamPassword"]')[0];
     var addParamLeftMatch = document.querySelectorAll('div[id="addParamLeftMatch"]')[0];
     var addParamRightMatch = document.querySelectorAll('div[id="addParamRightMatch"]')[0];
     var addParamDesc = document.querySelectorAll('div[id="addParamDesc"]')[0];
     addParamType.addEventListener('change', function() {
         if (this.value == '认证') {
             addParamValue.style.display=''
             addParamDesc.style.display=''
             document.getElementById('addParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + '登录接口URL';
             addParamUsername.style.display=''
             addParamPassword.style.display=''
             addParamLeftMatch.style.display=''
             addParamRightMatch.style.display=''
         } else if(this.value == 'App设置'){
             addParamValue.style.display=''
             addParamDesc.style.display=''
             document.getElementById('addParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + 'App自动化框架';
             addParamUsername.style.display=''
             document.getElementById('addParamUsername').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'Android版本号';
             addParamPassword.style.display=''
             document.getElementById('addParamPassword').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'deviceName';
             addParamLeftMatch.style.display=''
             document.getElementById('addParamLeftMatch').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'appPackage';
             addParamRightMatch.style.display=''
             document.getElementById('addParamRightMatch').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'appActivity';
         } else {
             addParamValue.style.display=''
             document.getElementById('addParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + '值';
             addParamUsername.style.display='None'
             addParamPassword.style.display='None'
             addParamLeftMatch.style.display='None'
             addParamRightMatch.style.display='None'
         }
     });
}

function modParam(){
     var modParamType = document.querySelectorAll('select[name="modInput"]')[1];
     var modParamDesc = document.querySelectorAll('div[id="modParamDesc"]')[0];
     var modParamValue = document.querySelectorAll('div[id="modParamValue"]')[0];
     var modParamUsername = document.querySelectorAll('div[id="modParamUsername"]')[0];
     var modParamPassword = document.querySelectorAll('div[id="modParamPassword"]')[0];
     var modParamLeftMatch = document.querySelectorAll('div[id="modParamLeftMatch"]')[0];
     var modParamRightMatch = document.querySelectorAll('div[id="modParamRightMatch"]')[0];
     modParamType.addEventListener('change', function() {
         if (this.value == '认证') {
             modParamValue.style.display=''
             modParamDesc.style.display=''
             document.getElementById('modParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + '登录接口URL';
             modParamUsername.style.display=''
             modParamPassword.style.display=''
             modParamLeftMatch.style.display=''
             modParamRightMatch.style.display=''
         } else if(this.value == 'App设置'){
             modParamValue.style.display=''
             modParamDesc.style.display=''
             document.getElementById('amodParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + 'App自动化框架';
             modParamUsername.style.display=''
             document.getElementById('modParamUsername').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'Android版本号';
             modParamPassword.style.display=''
             document.getElementById('modParamPassword').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'deviceName';
             modParamLeftMatch.style.display=''
             document.getElementById('modParamLeftMatch').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'appPackage';
             modParamRightMatch.style.display=''
             document.getElementById('modParamRightMatch').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'appActivity';
         } else {
             modParamValue.style.display=''
             document.getElementById('modParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + '值';
             modParamUsername.style.display='None'
             modParamPassword.style.display='None'
             modParamLeftMatch.style.display='None'
             modParamRightMatch.style.display='None'
         }
     });
}


function showModParaModal(e){
    selectedRow = e.parentNode.parentNode
    id = selectedRow.children[0].innerText
    $.ajax({
        url: "/autotest/systemsettings/showMod/",
        data: JSON.stringify({
            id1: id,
        }),
        contentType: 'application/json;charset=utf-8',
        type: "POST",
        traditional: true,
        success: function (result) {
            var loginUserName = result['loginUserName'];
            var loginPassword = result['loginPassword'];
            var left = result['left'];
            var right = result['right'];
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
                    if(selectedRow.children[modRowIndex[i]].innerText=="认证"){
                        modParamValue.style.display=''
                        modParamDesc.style.display=''
                        document.getElementById('modParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + '登录接口URL';
                        modParamUsername.style.display=''
                        modParamPassword.style.display=''
                        modParamLeftMatch.style.display=''
                        modParamRightMatch.style.display=''
                    }
                    else if(selectedRow.children[modRowIndex[i]].innerText=="App设置"){
                        modParamValue.style.display=''
                        modParamDesc.style.display=''
                        document.getElementById('modParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + 'App自动化框架';
                        modParamUsername.style.display=''
                        document.getElementById('modParamUsername').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'Android版本号';
                        modParamPassword.style.display=''
                        document.getElementById('modParamPassword').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'deviceName';
                        modParamLeftMatch.style.display=''
                        document.getElementById('modParamLeftMatch').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'appPackage';
                        modParamRightMatch.style.display=''
                        document.getElementById('modParamRightMatch').querySelector('.input-group-text').innerHTML = '<span style="color: red;">&nbsp; </span>' + 'appActivity';
                    }
                   else {
                       modParamValue.style.display=''
                       document.getElementById('modParamValue').querySelector('.input-group-text').innerHTML = '<span style="color: red;">* </span>' + '值';
                       modParamUsername.style.display='None'
                       modParamPassword.style.display='None'
                       modParamLeftMatch.style.display='None'
                       modParamRightMatch.style.display='None'
                   }
                }
                else if(temp.tagName == "TEXTAREA"){
                    if(i==6){
                        temp.value=loginUserName
                    }
                    else if(i==7){
                        temp.value=loginPassword
                    }
                    else if(i==8){
                        temp.value=left
                    }
                    else if(i==9){
                        temp.value=right
                    }
                    else {
                        temp.value = selectedRow.children[modRowIndex[i]].innerText
                    }
                }
            }
            $('#modifyModal').modal();
            window.event.stopPropagation()
            },
        fail: function (result) {
            debugger
        }
    });
}
