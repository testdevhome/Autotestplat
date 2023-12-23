setProgressURL = 'apiperformance/progress/'


function search_performance_interface() {
  var key_words_name = document.getElementById("key_words_name").value;
  var key_words_url = document.getElementById("key_words_url").value;
  if (key_words_name == '' && key_words_url == '') {
    window.location.reload(true);
  }
  else {
    $.ajax({
                url: "/autotest/apiperformance/search/",
                data: JSON.stringify({
                    key_words_name: key_words_name,
                    key_words_url: key_words_url,
                }),
                contentType: 'application/json;charset=utf-8',
                type: "POST",
                traditional: true,
                success: function (result) {
                    $('#tbody').empty();
                    len = result['id_list'].length;
                    console.log(len);
                    for (i = 1; i < len+1; i++) {
                        tmp_append = '<tr>' +
                                //'<td style="white-space: nowrap;text-align: center;"><input type="checkbox" name="chk"></td>' +
                                '<td style="width: 70px;white-space: normal;text-align: center;display: none">' + i + '</td>' +
                                '<td style="width: 50px;text-align: center;" id="ids">' + result['id_list'][i-1] + '</td>' +
                                '<td style="max-width: 140px;font-size: 12px;white-space: nowrap;overflow: hidden;">' + result['name_list'][i-1] + '</td>' +
                                '<td style="max-width: 200px;white-space: nowrap;overflow: hidden;font-size: 12px">' + result['url_list'][i-1] + '</td>' +
                                '<td style="width:80px;text-align: center;font-size: 12px">' + result['charger_list'][i-1] + '</td>' +
                                '<td id="operations" style="width: 120px;text-align: center;">' +
                                    '<div class="btn-group btn-group-xs" >' +
                                        '<button type="button" class="btn btn-primary" style="margin-left: 5px" onclick="select_not_login(\'' + result['id_list'][i-1] + '\',\'' + result['name_list'][i-1] + '\')">选择</button>' +
                                    '</div>' +
                                '</td>' +
                                '</tr>';
                        $('#tbody').append(tmp_append);
                    }
                    console.log(result);
                },
                fail: function (result) {
                    debugger
                }
            });
        }
    }

    function generate_performance_file(ele){
        var login_list = $(".logins");
        var id_list_login = [];
        for(var i=0;i<login_list.length;i++){
            var id1 = login_list[i].id;
            id_list_login.push(id1);
        }
        console.log(id_list_login);

        var not_login_list = $(".not_logins");
        var id_list_not_login = [];
        for(var j=0;j<not_login_list.length;j++){
            var id2 = not_login_list[j].id;
            id_list_not_login.push(id2);
        }
        console.log(id_list_not_login);

        var num_bf = $('#num_bf').val();
        var num_xh = $('#num_xh').val();
        var num_sj = $('#num_sj').val();
        var modeEle = document.getElementsByName("mode");
        var mode = modeEle[0].value;
        var cookieEle = document.getElementsByName("deal_cookie");
        var deal_cookie = cookieEle[0].value;
        console.log(num_bf,num_xh,num_sj,mode,deal_cookie);

        if(id_list_login.length == 0 && id_list_not_login.length == 0){
            alert('您未选择任何接口');
            return;
        }
        else if(num_bf == ''){
            alert('请输入“并发数”');
            return;
        }
        else if(num_xh == ''){
            alert('请输入“循环次数”');
            return;
        }
        else if(num_sj == ''){
            alert('请输入“持续运行时间”');
            return;
        }
        else if(mode == ''){
            alert('请选择“登陆用户数”');
            return;
        }
        else if(deal_cookie == ''){
            alert('请选择“cookie处理方式”');
            return;
        }
        else if(num_bf != ''&& num_xh != ''){
            $('.jmeter_status').empty().append('状态：正在生成脚本');
            $.ajax({
                url: "/autotest/apiperformance/generate/",
                data: JSON.stringify({
                    id_list_login: id_list_login,
                    id_list_not_login: id_list_not_login,
                    num_bf:num_bf,
                    num_xh:num_xh,
                    num_sj:num_sj,
                    mode:mode,
                    deal_cookie:deal_cookie,
                    csrfmiddlewaretoken: '{{ csrf_token }}'
                }),
                headers:{'X-CSRFToken': '{{ csrf_token }}'},
                contentType: 'application/json;charset=utf-8',
                type: "POST",
                traditional: true,
                success: function(result) {
                    console.log(result);
                    if(result == 'success'){
                        $('.jmeter_status').empty().append('状态：已生成');
                        }
                    else {
                        $('.jmeter_status').empty().append('状态：生成失败');
                        return;
                    }
                },
                fail: function(result) {
                    debugger
                }
            });
        }
    }

    function start_test_jmeter(ele){
        var not_login_list = $(".not_logins");
        var id_list_not_login = [];
        for(var j=0;j<not_login_list.length;j++){
            var id2 = not_login_list[j].id;
            id_list_not_login.push(id2);
        }
        var num_bf = $('#num_bf').val();
        var num_sj = $('#num_sj').val();
        if(id_list_not_login.length == 0){
            alert('您未选择任何接口')
            return;
        }
        else if(num_bf == ''){
            alert('请输入“并发数”')
            return;
        }
        else if(num_sj == ''){
            alert('请输入“持续运行时间”')
            return;
        }

        $('.jmeter_status').empty().append('状态：准备执行');
        $.ajax({
            url: "/autotest/apiperformance/prepare/",
            headers:{'X-CSRFToken': '{{ csrf_token }}'},
            contentType: 'application/json;charset=utf-8',
            type: "POST",
            traditional: true,
            success: function(result) {
                console.log(result);
                if(result == 'success'){

                    $('.jmeter_status').empty().append('<progress id="progressBar" value="0" max=""></progress>')
                     var progressBar = document.getElementById('progressBar');
                     var duration = document.getElementById('num_sj').value;
                     var increment = parseInt(duration) * 60;
                     progressBar.max = increment;
                     let startTime = new Date();

                    var intervalId = setInterval(function() {
                         let now = new Date();
                         let elapsed = now - startTime;
                         let seconds = Math.floor(elapsed / 1000);
                         progressBar.value =  seconds % 60;
                         $.ajax({
                            url: appURL+setProgressURL,
                            type: 'POST',
                            data: JSON.stringify({
                                progress:  progressBar.value,
                                progress_total: increment,
                            }),
                            success: (rst) => {
                                console.log("success")
                            }
                         });
                         if (progressBar.value === progressBar.max-1) {
                            clearInterval(intervalId);
                         }
                    }, 100);
                }
                else {
                    $('.jmeter_status').empty().append('状态：出现异常');
                    return;
                }
            },
            fail: function(result) {
                debugger
            }
        });

        $.ajax({
            url: "/autotest/apiperformance/start/",
            headers:{'X-CSRFToken': '{{ csrf_token }}'},
            contentType: 'application/json;charset=utf-8',
            type: "POST",
            traditional: true,
            success: function(result) {
                console.log(result);
                if(result == 'success'){
                    $('.jmeter_status').empty().append('状态：测试完成');
                    $.ajax({
                            url: appURL+setProgressURL,
                            type: 'POST',
                            data: JSON.stringify({
                                progress:  0,
                                progress_total: 1,
                            }),
                            success: (rst) => {
                                console.log("success")
                            }
                         });
                }
                else {
                    $('.jmeter_status').empty().append('状态：测试失败');
                }
            },
            fail: function(result) {
                debugger
            }
        });
    }

function select_login(id1,name1,module1) {
    $('#login_panel').append('<a href="javascript:void(0)" id="'+id1+'" name="'+module1+'" class="list-group-item logins" onclick="remove_login_selected(\''+id1+'\')">'+name1+'</a>');
}
function select_not_login(id1,name1,module1) {
    $('#not_login_panel').append('<a href="javascript:void(0)" id="'+id1+'" name="'+module1+'" class="list-group-item not_logins" onclick="remove_not_login_selected(\''+id1+'\')">'+name1+'</a>');
}
function remove_login_selected(ele) {
    var id1 = '#'+ele;
    $('#login_panel').find(id1).remove();
}
function remove_not_login_selected(ele) {
    var id1 = '#'+ele;
    $('#not_login_panel').find(id1).remove();
}