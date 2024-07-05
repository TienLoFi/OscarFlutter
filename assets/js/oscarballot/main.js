var resizefunc = [];
var vkey=0;
var vemail;
var form_validate1 = $("#form_signin").validate({ ignore:[], rules:{
        in_email:{required:true, email:true, minlength:0, maxlength:255},
        in_pwd  :{required:true, minlength:0, maxlength:50}
    }
});
var form_validate0 = $("#form_verify").validate({ ignore:[], rules:{
    Private_Key:{required:true, minlength:3, maxlength:255},
    }
});
var form_validatef = $("#form_forget").validate({ ignore:[], rules:{
    in_email:{required:true, email:true, minlength:0, maxlength:255},
    }
});

$('#form_forget').submit(function(event){
    event.preventDefault();
    if (form_validatef['successList'].length<1) {
        return;
    }
    $("#forget-modal").modal('hide');
    $("#pending-modal").modal('show');
    $.post( "/admin/forgetpassword", {email:$("#forget_email").val()}, function(data) {
        var result = jQuery.parseJSON(data);
        $("#pending-modal").modal('hide');
        
        if (result.state == false) {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            if(result.isemail == false)		{toastr["error"](result.msg, "Email isn't correct!");}
            else	{toastr["error"](result.msg, "Sending message failed!");}
            $("#signin-modal").modal('show');

            return ;
        } else {
            $("#regForm").unbind('submit').submit();
            toastr["success"](result.msg, "Password Key Sent to your email!");
            $("#signin-modal").modal('show');
            return ;
        }
    });
});

$('#form_verify').submit(function(event){
    event.preventDefault();
    if (form_validate0['successList'].length<1) return;
    $.post( "/admin/auth/userVerify", {inputkey:$("#Private_Key").val(),key:vkey,email:vemail}, function(data) {
        var result = jQuery.parseJSON(data);
        
        if (result.state == false) {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["error"](result.msg, "Verify Error");
            
        } else {
            $("#regForm").unbind('submit').submit();
            $("#verify-modal").modal('hide');
            $("#signin-modal").modal('show');
            toastr["success"](result.msg, "Verify Sucess!");
        }
    });
});

$("#form_signin").submit(function(event){
    event.preventDefault();
    if (form_validate1['successList'].length<2) return;
    $.post( "/admin/auth/signIn", {email:$("#in_email").val(),pwd:$("#in_pwd").val()}, function(data) {

        var result = jQuery.parseJSON(data);
        if(result.verify == false && result.state == true){
            $("#signin-modal").modal('hide');
            var subjec = "Verification Key";
            vemail=$("#in_email").val();
            $("#pending-modal").modal('show');
            $.post( "/admin/auth/sendEmail", {to:$("#in_email").val(),subject:subjec}, function(datae) {
                var rlt = jQuery.parseJSON(datae);
                $("#pending-modal").modal('hide');
                if(rlt.state == false){
                    $("#signin-modal").modal('show');
                    toastr["error"](result.msg, "Sending verify Message has Error!");
                    return ;
                }
                vkey = rlt.message;
                toastr["success"](result.msg, "Private Key Sent to your email!");
                $("#verify-modal").modal('show');
            });
            return ;
        }
        if (result.state == false) {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["error"](result.msg, "LogIn Error");
            
        } else {
            $("#regForm").unbind('submit').submit();
            $(location).attr('href', result.url);
        }
    });
});

var form_validate2 = $("#form_signup").validate({ ignore:[], rules:{
        up_name :{required:true, minlength:0, maxlength:255},
        up_email:{required:true, email:true, minlength:0, maxlength:255},
        up_pwd  :{required:true, minlength:0, maxlength:50},
        confirm_pwd  :{equalTo:"#up_pwd", minlength:0, maxlength:50}
    }
});

$("#form_signup").submit(function(event){
    event.preventDefault();
    if (form_validate2['successList'].length<4) return;
    $.post( "/admin/auth/signUp", {name:$("#up_name").val(),email:$("#up_email").val(),pwd:$("#up_pwd").val()}, function(data) {
        var result = jQuery.parseJSON(data);
        
        if (result.state == false) {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["error"](result.msg, "SignUp Error");
        } else {
            $("#regForm").unbind('submit').submit();

            var subjec = "Verification Key";
            vemail=$("#up_email").val();
            $("#pending-modal").modal('show');
            $("#signup-modal").modal('hide');
            
            $.post( "/admin/auth/sendEmail", {to:$("#up_email").val(),subject:subjec}, function(datae) {
                var rlt = jQuery.parseJSON(datae);
                $("#pending-modal").modal('hide');
                if(rlt.state == false){
                    toastr["error"](result.msg, "Sending verify Message has Error! After now , try more.");
                }else 	toastr["success"](result.msg, "Private Key Sent to your email!");
                vkey = rlt.message;
                $("#verify-modal").modal('show');
                return;
            });
            return ;
            $(location).attr('href', '/');
        }
    });
});

var form_validate3 = $("#form_changePwd").validate({ ignore:[], rules:{
        new_pwd :{required:true, minlength:0, maxlength:50},
        old_pwd:{required:true, minlength:0, maxlength:50},
        confirm_new_pwd  :{required:true, equalTo:"#new_pwd", minlength:0, maxlength:50}
    }
});

var form_validate4 = $("#form_changeMyProfile").validate({ ignore:[], rules:{
    name :{required:true, minlength:0, maxlength:50},
    email:{required:true, minlength:0, maxlength:50},
}
});

$("#form_changeMyProfile").submit(function(event){
    event.preventDefault();
    if (form_validate4['successList'].length<2) return;
    $.post( "/admin/auth/changeMyProfile", {name:$("#user_name").val(),new_pwd:$("#user_email").val()}, function(data) {
        var result = jQuery.parseJSON(data);
        
        if (result.state == false) {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["error"](result.msg, "Change Profile Error");
            
        } else {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["success"](result.msg, "Success");
            $("#change-modal").modal('hide');
        }
    });
});

$("#form_changePwd").submit(function(event){
    event.preventDefault();
    if (form_validate3['successList'].length<3) return;
    $.post( "/admin/auth/changeUserPassword", {old_pwd:$("#old_pwd").val(),new_pwd:$("#new_pwd").val()}, function(data) {
        var result = jQuery.parseJSON(data);
        
        if (result.state == false) {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["error"](result.msg, "SignUp Error");
            
        } else {
            toastr.clear();
            toastr.options = {
                        "closeButton": false,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
            toastr["success"](result.msg, "Success");
            $("#change-modal").modal('hide');
        }
    });
});

$("#form_user_problem").submit(function(event){
    event.preventDefault();

    var isLogin = '<?php echo $isLogin;?>';		

    if (isLogin == '1') {

        var formData = JSON.stringify($("#form_user_problem").serializeArray());
        
        $.post( "/home/setProblem", {problems:formData,info1:$('#info1').val(), info2:$('#info2').val()}, function(data) {
            $(location).attr('href', '/');
        });	    	
        
    } else {
        toastr.clear();
        toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": false,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": false,
                    "onclick": null,
                    "showDuration": "300",
                    "hideDuration": "1000",
                    "timeOut": "5000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
            toastr["error"]("You have to sign in first.", "Warning");			
    }
});


$("#signOut").on("click", function() {
    $.post( "/admin/auth/signOut", {}, function(data) {
        $(location).attr('href', '/');
    });
});

$("#reset_user").on("click", function() {
    var isLogin = '<?php echo $isLogin;?>';

    if (isLogin == '1') {
        $.post( "/home/setReset", {}, function(data) {
            $(location).attr('href', '/');
        });				
    } else {
        toastr.clear();
        toastr.options = {
                "closeButton": false,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            };
        toastr["error"]("You have to sign in first.", "Warning");	
    }
});

$("#reset_admin").on("click", function() {
    $.post( "/admin/problem/setReset", {}, function(data) {
        $(location).attr('href', data);
    });		
});

$(document).ready(function() {
    var $container = $('#ballots');
    $container.imagesLoaded(function () {
        $container.masonry({
            itemSelector: '.ballot-box',
            isFitWidth: true,
            isAnimated: true
        });
    });      
    
    
    var windowWidth = $(window).width();
    $("#triangle1").css({
        "border-top": $("#title").height()*0.9 + 'px solid rgba(0, 0, 0, 1)'
    });
    $("#triangle1").css({
        "border-right": windowWidth / 5 + 'px solid transparent'
    });
    $("#triangle").css({
        "border-top": $("#title").height() + 'px solid rgba(213, 167, 51, 1)'
    });
    $("#triangle").css({
        "border-right": windowWidth / 8 + 'px solid transparent'
    });
});

$(window).resize(function () {
    var windowWidthR = $(window).width();
    $("#triangle1").css({
        "border-top": $("#title").height()*0.9 + 'px solid rgba(0, 0, 0, 1)'
    });
    $("#triangle1").css({
        "border-right": windowWidthR / 5 + 'px solid transparent'
    });
    $("#triangle").css({
        "border-top": $("#title").height() + 'px solid rgba(213, 167, 51, 1)'
    });
    $("#triangle").css({
        "border-right": windowWidthR / 8 + 'px solid transparent'
    });
});

function onDeleteUser(user_id) {
    var confirm_dlg = confirm("Are you sure delete?");

    if (confirm_dlg == true) {
        $.post( "/admin/auth/deleteUser", {id:user_id}, function(data) {
            $(location).attr('href', data);
        });	
    }
}

function onEditUser(user_id) {
    $.get("/admin/user/edit/" + user_id, function(data){
        $('#add-edit-user-content').html(data);
    });
}




function onDeleteNomination(nomination_id) {
    var confirm_dlg = confirm("Are you sure delete?");

    if (confirm_dlg == true) {
        $.post( "/admin/nomination/delete", {id:nomination_id}, function(data) {
            $(location).attr('href', data);
        });	
    }
}

function onEditNomination(nomination_id) {
    $.get("/admin/nomination/edit/" + nomination_id, function(data){
        $('#add-edit-nomination-content').html(data);
        $('#category_id').chosen({width: '100%'});
        $('#movie_id').chosen({width: '100%'});
        $('#nomination_year').on('change', function(){
            $.get("/admin/nomination/getMovies", function(){
                $('#movie_id').html(data);
                $('#movie_id').chosen({width: '100%'});
            });
        });
    });
}

function onDeleteCategory(category_id) {
    var confirm_dlg = confirm("Are you sure delete?");

    if (confirm_dlg == true) {
        $.post( "/admin/category/delete", {id:category_id}, function(data) {
            $(location).prop('href', '/admin/category/index')
        });	
    }
}


function onEditCategory(categoryId) {
    $.get("/admin/category/edit/" + categoryId, function(data){
        $('#add-edit-category-content').html(data);
    });
}

function onDeleteGroup(group_id) {
    var confirm_dlg = confirm("Are you sure delete?");

    if (confirm_dlg == true) {
        $.post( "/admin/group/delete", {id:group_id}, function(data) {
            $(location).prop('href', '/admin/group/index')
        });	
    }
}

function onEditMovie(movieId) {
    $.get("/admin/movie/edit/" + movieId, function(data){
        $('#add-edit-movie-content').html(data);
    });
}

function onDeleteMovie(movie_id) {
    var confirm_dlg = confirm("Are you sure delete?");

    if (confirm_dlg == true) {
        $.post( "/admin/movie/delete", {id:movie_id}, function(data) {
            $(location).prop('href', '/admin/movie/index')
        });	
    }
}

function onEditAwardResult(awardResultId) {
    $.get("/admin/awardresult/edit/" + awardResultId, function(data){
        $('#add-edit-awardresult-content').html(data);
    });
}

function onDeleteAwardResult(awardResultId) {
    var confirm_dlg = confirm("Are you sure delete?");

    if (confirm_dlg == true) {
        $.post( "/admin/awardresult/delete", {id:awardResultId}, function(data) {
            $(location).prop('href', '/admin/awardresult/index')
        });	
    }
}


function onEditGroup(groupId) {
    $.get("/admin/group/edit/" + groupId, function(data){
        $('#add-edit-group-content').html(data);
        reloadMemberList(groupId);
        $('#add-member-btn').on('click', function(){
            $('#add-member-box').show();
        });
        $('#close-send-invite-btn').on('click', function(event){
            $('#add-member-box').hide();
        });
        $('#send-invite-btn').on('click', function(){
            var memberId = $('#member_id').val();
            $.post( "/admin/group/storeMember", {group_id:groupId, member_id: memberId}, function(data) {
                $('#add-member-box').hide();
                reloadMemberList(groupId);
            });	
            
        });

        $('#delete-member-btn').on('click', function(){
            var selectedCheckboxes = $('.member_checkbox:checked');
            var selectedValues = []; 
            selectedCheckboxes.each(function(){
                selectedValues.push($(this).val());
            });
    
            if (selectedValues.length == 0) {
                alert('Please select some members');
                return false;
            }
    
            var confirm_dlg = confirm("Are you sure delete?");
            if (confirm_dlg == true) {
                $.post( "/admin/group/bulkDeleteMembers", {member_ids: selectedValues.join(',')}, function(data) {
                    reloadMemberList(groupId);
                });	
            }
        });

        $('#search-btn').on('click', function(){
            var search = $('#search_member').val(); 
            var status = $('#status_member').val();
            reloadMemberList(groupId, search, status);
        });
    });
}

function reloadMemberList(group_id, search = '', status = null)
{
    var url = "/admin/group/members?group_id=" + group_id;
    if (search != '') {
        url += '&search='+search;
    }

    if (status != null) {
        url += '&status='+status;
    }
    $.get(url, function(data){
        $('#member_list_box').html(data);
        $('.remove-member').on('click', function(){
            var confirm_dlg = confirm("Are you sure delete?");

            if (confirm_dlg == true) {
                var memberId = $(this).data('id');
                $.post( "/admin/group/deleteMember", {member_id:memberId}, function(data) {
                    reloadMemberList(group_id);
                });	
            }
        });
    });
}

function reloadFrontMemberList(group_id, search = '', status = null)
{
    var url = "/group/members?group_id=" + group_id;
    if (search != '') {
        url += '&search='+search;
    }

    if (status != null) {
        url += '&status='+status;
    }
    $.get(url, function(data){
        $('#front-member-list-box').html(data);
        $('.remove-member').on('click', function(){
            var confirm_dlg = confirm("Are you sure delete?");

            if (confirm_dlg == true) {
                var memberId = $(this).data('id');
                $.post( "/group/deleteMember", {member_id:memberId}, function(data) {
                    reloadFrontMemberList(group_id);
                });	
            }
        });
    });
}


function onEditFrontGroup(groupId) {
    $.get("/group/edit/" + groupId, function(data){
        $('#front-add-edit-group-content').html(data);
        reloadFrontMemberList(groupId);
        $('#front-add-member-btn').on('click', function(){
            $('#front-add-member-box').show();
        });
        $('#front-close-send-invite-btn').on('click', function(event){
            $('#front-add-member-box').hide();
        });
        $('#front-send-invite-btn').on('click', function(){
            var memberId = $('#member_id').val();
            $.post( "/group/storeMember", {group_id:groupId, member_id: memberId}, function(data) {
                $('#front-add-member-box').hide();
                reloadFrontMemberList(groupId);
            });	
            
        });

        $('#front-delete-member-btn').on('click', function(){
            var selectedCheckboxes = $('.member_checkbox:checked');
            var selectedValues = []; 
            selectedCheckboxes.each(function(){
                selectedValues.push($(this).val());
            });
    
            if (selectedValues.length == 0) {
                alert('Please select some members');
                return false;
            }
    
            var confirm_dlg = confirm("Are you sure delete?");
            if (confirm_dlg == true) {
                $.post( "/group/bulkDeleteMembers", {member_ids: selectedValues.join(',')}, function(data) {
                    reloadFrontMemberList(groupId);
                });	
            }
        });

        $('#front-search-btn').on('click', function(){
            var search = $('#front-search-member').val(); 
            var status = $('#front-status-member').val();
            reloadFrontMemberList(groupId, search, status);
        });
    });
}


function reloadFrontViewMemberList(group_id, search = '', status = null)
{
    var url = "/group/viewMembers?group_id=" + group_id;
    if (search != '') {
        url += '&search='+search;
    }

    if (status != null) {
        url += '&status='+status;
    }
    $.get(url, function(data){
        $('#front-view-member-list-box').html(data);
        $('.remove-member').on('click', function(){
            var confirm_dlg = confirm("Are you sure delete?");

            if (confirm_dlg == true) {
                var memberId = $(this).data('id');
                $.post( "/group/deleteMember", {member_id:memberId}, function(data) {
                    reloadFrontViewMemberList(group_id);
                });	
            }
        });
    });
}

function onViewFrontGroup(groupId) {
    $.get("/group/view/" + groupId, function(data){
        $('#front-view-group-content').html(data);
        reloadFrontViewMemberList(groupId);

        $('#front-view-search-btn').on('click', function(){
            var search = $('#front-view-search-member').val(); 
            var status = $('#front-view-status-member').val();
            reloadFrontViewMemberList(groupId, search, status);
        });

        $('#front-view-search-btn').on('click', function(){
            var search = $('#front-view-search-member').val(); 
            var status = $('#front-view-status-member').val();
            reloadFrontMemberList(groupId, search, status);
        });
    });
}

var now=null;
function clean_radio(result){
    if(result==false)now.find('input:radio').attr('checked', false);
    else {
        now.find('input').attr('checked', 'checked');
    }
}
var ft=1;
$(".ballot-sell").click(function(){
    now=$(this);
    $.post( "/admin/auth/inSigned", {}, function(data) {
        rlt=jQuery.parseJSON(data);
        clean_radio(rlt.state);
        if(rlt.state==false){
            toastr.options = {
                "closeButton": false,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
                };
                if(ft%2){
                    toastr.clear();
                    toastr["error"]("Please sign in to make your choices.", "Warning");
                }
                ft++;
        }
    });

    $.post( "/admin/auth/ballotLocked", {}, function(data) {
        rlt=jQuery.parseJSON(data);
        now.find('input:radio').attr('checked', false);
        if(rlt.state==true){
            toastr.options = {
                "closeButton": false,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
                };
                if(ft%2){
                    toastr.clear();
                    toastr["error"]("Ballot page was locked.", "Warning");
                }
                ft++;
        }
    });
});

if ($('#nomination-page-admin').length > 0) {
    $('#add-nomination-btn').on('click', function(){
        $.get("/admin/nomination/add", function(data){
            $('#add-edit-nomination-content').html(data);
            $('#category_id').chosen({width: '100%'});
        });
    });

    $('#delete-nominations-btn').on('click', function(){
        var selectedCheckboxes = $('.checkbox:checked');
        var selectedValues = []; 
        selectedCheckboxes.each(function(){
            selectedValues.push($(this).val());
        });

        if (selectedValues.length == 0) {
            alert('Please select some movies');
            return false;
        }

        var confirm_dlg = confirm("Are you sure delete?");
        if (confirm_dlg == true) {
            $.post( "/admin/nomination/bulkDelete", {ids:selectedValues.join(',')}, function(data) {
                $(location).attr('href', data);
            });	
        }
    });

}

if ($('#user-page-admin').length > 0) {
    $('#add-user-btn').on('click', function(){
        $.get("/admin/user/add", function(data){
            $('#add-edit-user-content').html(data);
        });
    });

    $('#delete-users-btn').on('click', function(){
        var selectedCheckboxes = $('.checkbox:checked');
        var selectedValues = []; 
        selectedCheckboxes.each(function(){
            selectedValues.push($(this).val());
        });

        if (selectedValues.length == 0) {
            alert('Please select some movies');
            return false;
        }

        var confirm_dlg = confirm("Are you sure delete?");
        if (confirm_dlg == true) {
            $.post( "/admin/user/bulkDelete", {ids:selectedValues.join(',')}, function(data) {
                $(location).attr('href', data);
            });	
        }
    });
}

if ($('#group-page-admin'.length > 0)) {
    $('#add-group-btn').on('click', function(){
        $.get("/admin/group/add", function(data){
            $('#add-edit-group-content').html(data);
        });
    });

    $('#delete-groups-btn').on('click', function(){
        var selectedCheckboxes = $('.checkbox:checked');
        var selectedValues = []; 
        selectedCheckboxes.each(function(){
            selectedValues.push($(this).val());
        });

        if (selectedValues.length == 0) {
            alert('Please select some movies');
            return false;
        }

        var confirm_dlg = confirm("Are you sure delete?");
        if (confirm_dlg == true) {
            $.post( "/admin/group/bulkDelete", {ids:selectedValues.join(',')}, function(data) {
                $(location).attr('href', data);
            });	
        }
    });
}

if ($('#movie-page-admin'.length > 0)) {
    $('#add-movie-btn').on('click', function(){
        $.get("/admin/movie/add", function(data){
            $('#add-edit-movie-content').html(data);
        });
    });

    $('#delete-movies-btn').on('click', function(){
        var selectedCheckboxes = $('.checkbox:checked');
        var selectedValues = []; 
        selectedCheckboxes.each(function(){
            selectedValues.push($(this).val());
        });

        if (selectedValues.length == 0) {
            alert('Please select some movies');
            return false;
        }

        var confirm_dlg = confirm("Are you sure delete?");
        if (confirm_dlg == true) {
            $.post( "/admin/movie/bulkDelete", {ids:selectedValues.join(',')}, function(data) {
                $(location).attr('href', data);
            });	
        }
    });
}

if ($('#awardresult-page-admin').length > 0) {

    $('#add-awardresult-btn').on('click', function(){
        $.get("/admin/awardresult/add", function(data){
            $('#add-edit-awardresult-content').html(data);
        });
    });

    $('#delete-awardresults-btn').on('click', function(){
        var selectedCheckboxes = $('.checkbox:checked');
        var selectedValues = []; 
        selectedCheckboxes.each(function(){
            selectedValues.push($(this).val());
        });

        if (selectedValues.length == 0) {
            alert('Please select some categories');
            return false;
        }

        var confirm_dlg = confirm("Are you sure delete?");
        if (confirm_dlg == true) {
            $.post( "/admin/awardresult/bulkDelete", {ids:selectedValues.join(',')}, function(data) {
                $(location).attr('href', data);
            });	
        }
    });
}


if ($('#front-group-page'.length > 0)) {
    $('#front-add-edit-group-btn').on('click', function(){
        $.get("/group/add", function(data){
            $('#front-add-edit-group-content').html(data);
        });
    });
    $('#front-join-group-btn').on('click', function(){
        $.get("/group/join", function(data){
            $('#front-join-group-content').html(data);
        });
    })
}