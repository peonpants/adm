var TeG=TeG||{};TeG.AccountDetails=function(n,t){function i(t){var u=$.extend({},TeG.AccountDetails.detailsTabObserve.GroupCategory()),i=u.Groups,e=[],r,f,o,s;for(r in i)i[r].Name==TeG.AccountDetails.detailsTabObserve.SelectedValue()&&(i[r].IsAdded=0,e.push(i[r]));u.Groups=e;f=JSON.stringify(u);n=="PlayersGrid"?(o=tegUrlHelper.updateCusomerAccountDetails,$.ajax({type:"POST",url:o,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify({accountNumber:TeG.AccountDetails.account,firstName:$.trim($('#accountDetailsTabDetails input[name="firstName"]').val()),lastName:$.trim($('#accountDetailsTabDetails input[name="lastName"]').val()),email:$.trim($('#accountDetailsTabDetails input[name="email"]').val()),mobilePhoneNumber:$.trim($('#accountDetailsTabDetails input[name="mobileNumber"]').val()),isMobilePlayer:$('#accountDetailsTabDetails input[name="isMobilePlayer"]').is(":checked"),profileId:$('#accountDetailsTabDetails input[name="profile"]:checked').val(),GroupCategory:f}),error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabDetails").removeClass("divLoading")},success:function(){var i=$("#"+n).data("kendoGrid"),r,u;$("#accountDetailsTabDetails").removeClass("divLoading");$("#PlayerDetails").css("display","none");$("#DivPlayersGrid").css("display","block");t&&typeof t=="function"&&t();r=i.select()[0].rowIndex;u=i.tbody.find(">tr:not(.k-grouping-row)").eq(r);i.collapseRow(u);$("#PlayersGrid").find("tr.k-detail-row").remove();splitterResize();tegPopups.closeTotalHover();tegAccountDetails.BackToList();i.dataSource.fetch().then(function(){i.select($($("div#"+n+" div.k-grid-content table tbody tr:eq("+r+")")))})}})):(s=tegUrlHelper.updateStationDetails,$.ajax({type:"POST",url:s,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify({accountNumber:TeG.AccountDetails.account,stationName:$.trim($('#accountDetailsTabDetails input[name="stationName"]').val()),profileId:$('#accountDetailsTabDetails input[name="profile"]:checked').val(),GroupCategory:f}),error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabDetails").removeClass("divLoading")},success:function(i){var f,e;i=JSON.parse(i);var r=$("#"+n).data("kendoGrid"),u=r.select(),o=u.attr("data-uid");if(!i.IsSucceed){i.failureReason=="NICKNAMEALREADYEXISTS"&&new TeG.Validator($('#accountDetailsTabDetails input[name="stationName"]')).SetMessage(i.errorText).ErrorRenderDefault();tegPopups.closeTotalHover();return}r.dataItem(u).NickName=$('#accountDetailsTabDetails input[name="stationName"]').val();r.dataItem(u).CustomerGroupName=TeG.AccountDetails.detailsTabObserve.SelectedValue();u.find("td.RNGMaxPayout").attr("name","1");t&&typeof t=="function"&&t();tegPopups.closeTotalHover();$("#StationDetails").css("display","none");$("#DivStationsGrid").css("display","block");$("#nickName_"+TeG.AccountDetails.account).html($.trim($('#accountDetailsTabDetails input[name="stationName"]').val()));f=r.select()[0].rowIndex;e=r.tbody.find(">tr:not(.k-grouping-row)").eq(f);r.collapseRow(e);$("#StationsGrid").find("tr.k-detail-row").remove();tegAccountDetails.BackToList();r.dataSource.fetch().then(function(){r.select($("div#"+n+" div.k-grid-content table tbody tr:eq("+f+")"))})}}))}return n==null&&(n="PlayersGrid"),t==null&&(t="PlayerDetails"),{GetDetailsTab:function(n){$("#"+t).css("display","block");TeG.AccountDetails.account=n;this.DetailsTabShow(TeG.AccountDetails.account);$("#accountDetailsDetailsTab").on("click",{detailsTabShow:this.DetailsTabShow},function(n){$("#accountDetailsDetailsTab").hasClass("selected")||n.data.detailsTabShow(TeG.AccountDetails.account)});$("#accountDetailsActionTab").on("click",{accountTabShow:this.AccountTabShow},function(n){$("#accountDetailsActionTab").hasClass("selected")||n.data.accountTabShow(TeG.AccountDetails.account)});$("#accountDetailsProgressiveGamePlayTab").on("click",{progressiveGamePlayTabShow:this.ProgressiveGamePlayTabShow},function(n){$("#accountDetailsProgressiveGamePlayTab").hasClass("selected")||n.data.progressiveGamePlayTabShow(TeG.AccountDetails.account)});$("#accountDetailsProfitByGameTypeTab").on("click",{profitByGameTypeTabShow:this.ProfitByGameTypeTabShow},function(n){$("#accountDetailsProfitByGameTypeTab").hasClass("selected")||n.data.profitByGameTypeTabShow(TeG.AccountDetails.account)});$("#accountDetailsPlayerEarningTab").on("click",{playerEarningTabShow:this.PlayerEarningTabShow},function(n){$("#accountDetailsPlayerEarningTab").hasClass("selected")||n.data.playerEarningTabShow(TeG.AccountDetails.account)});$("#accountDetailsGamePlayLocationTab").on("click",{gamePlayLocationTabShow:this.GamePlayLocationTabShow},function(n){$("#accountDetailsGamePlayLocationTab").hasClass("selected")||n.data.gamePlayLocationTabShow(TeG.AccountDetails.account)});$("#accountDetailsFundsOnTableTab").on("click",{fundsOnTableTabShow:this.FundsOnTableTabShow},function(n){$("#accountDetailsFundsOnTableTab").hasClass("selected")||n.data.fundsOnTableTabShow(TeG.AccountDetails.account)});$("#accountDetailsPlayCheckTab").on("click",function(){$("#accountDetailsPlayCheckTab").hasClass("selected")||$("#playCheck_"+n+" a").length>0&&window.open($("#playCheck_"+n+" a").attr("href"),"_blank")})},DetailsTabShow:function(){function t(){this.AccountNumber=ko.observable("");this.BalanceString=ko.observable("");this.CreditCurrencyIsoCode=ko.observable("");this.BettingProfileName=ko.observable("");this.FirstName=ko.observable("");this.LastName=ko.observable("");this.MobilePhoneNumber=ko.observable("");this.NickName=ko.observable("");this.Email=ko.observable("");this.IsMobilePlayer=ko.observable(!0);this.CustomerGroupName=ko.observable("");this.CustomerGroupAdded=ko.observable(0);this.IsBetGroupsVisible=ko.observable(!1);this.IsBetGroupsEnabled=ko.observable(!1);this.IsLGBetGroupsVisible=ko.observable(!1);this.GroupCategory=ko.observable(null);this.BetGroups=ko.observableArray([]);this.SelectedValue=ko.observable("");this.GroupChange=function(n){TeG.AccountDetails.detailsTabObserve.SelectedValue(n.Name)}}$(".tabBarBotton").removeClass("selected");$("#accountDetailsDetailsTab").addClass("selected");$(".detailsBody").css("display","none");$("#accountDetailsTabDetails").css("display","block");$("#accountDetailsTabDetails").find(".errorMessage").remove();$("#accountDetailsTabDetails").find("input.error").removeClass("error");$("#accountDetailsTabDetails").addClass("divLoading");$("#accountDetailsName").text("");var r=tegUrlHelper.accountDetailsTabDetails;TeG.AccountDetails.detailsTabObserve=new t;$(".errorMessageSlideDown").remove();$("#AccTabDetailsSave").off();$("#AccTabDetailsCancel").off();$.ajax({type:"POST",url:r,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify({accountNumber:TeG.AccountDetails.account}),error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabDetails").removeClass("divLoading")},success:function(t,r,u){var f,e,o,s;if(tegErrorHandler.checkAjaxResponse(u)){t=JSON.parse(t);f=tegFinancial.getLoginGroups({currency:t.CreditCurrencyIsoCode,groupName:"RNGMaxPayout"});f.Categories[0]=f.Categories[0]||{Groups:[]};t.BalanceString=TeG.Financial().CurrencyFormat(t.Balance);t.IsBetGroupsEnabled=t.CustomerGroupAdded==1;t.IsLGBetGroupsVisible=$("#memberType").html()!=TeG.Translations.MemberLoginTypeAgentCashier;t.IsBetGroupsVisible=$("#memberType").html()!=TeG.Translations.MemberLoginTypeAgentCashier&&f.Categories[0].Groups.length>0;t.GroupCategory=f.Categories[0];t.SelectedValue=t.CustomerGroupName;t.BetGroups=f.Categories[0].Groups;t.IsAllElementsEnabled||$("#accountDetailsTabDetails").find("input, button").not("#AccTabDetailsCancel").attr("disabled",!0);TeG.AccountDetails.TabDetails={};TeG.AccountDetails.TabDetails.Data=t;TeG.AccountDetails.detailsTabObserve.AccountNumber(t.AccountNumber);TeG.AccountDetails.detailsTabObserve.BalanceString(t.BalanceString);TeG.AccountDetails.detailsTabObserve.Email(t.Email);TeG.AccountDetails.detailsTabObserve.FirstName(t.FirstName);TeG.AccountDetails.detailsTabObserve.CreditCurrencyIsoCode(t.CreditCurrencyIsoCode);TeG.AccountDetails.detailsTabObserve.LastName(t.LastName);TeG.AccountDetails.detailsTabObserve.MobilePhoneNumber(t.MobilePhoneNumber);TeG.AccountDetails.detailsTabObserve.NickName(t.NickName);TeG.AccountDetails.detailsTabObserve.IsMobilePlayer(t.IsMobilePlayer);TeG.AccountDetails.detailsTabObserve.CustomerGroupName(t.CustomerGroupName);TeG.AccountDetails.detailsTabObserve.CustomerGroupAdded(t.CustomerGroupAdded);TeG.AccountDetails.detailsTabObserve.IsBetGroupsVisible(t.IsBetGroupsVisible);TeG.AccountDetails.detailsTabObserve.IsBetGroupsEnabled(t.IsBetGroupsEnabled);TeG.AccountDetails.detailsTabObserve.IsLGBetGroupsVisible(t.IsLGBetGroupsVisible);TeG.AccountDetails.detailsTabObserve.GroupCategory(t.GroupCategory);TeG.AccountDetails.detailsTabObserve.BetGroups(t.BetGroups);TeG.AccountDetails.detailsTabObserve.SelectedValue(t.CustomerGroupName);e='<div class="input-block"><input type="radio" name="bet-groups" data-bind="attr: {id: MGSProfileId, value: Name}, checked: $root.SelectedValue, enable: $root.IsBetGroupsEnabled, event: { change: $root.GroupChange }" /><label data-bind="text: DisplayName, value: Name, attr: {for: Name}"><\/label><\/div>';$("#StationDetails tr#betGroupAreaTr div.bet-groups-foreach, #PlayerDetails tr#betGroupAreaTr div.bet-groups-foreach").html("");$("#StationDetails tr#betGroupAreaTr div.bet-groups-foreach, #PlayerDetails tr#betGroupAreaTr div.bet-groups-foreach").append(e);ko.cleanNode($("#accountDetailsTabDetails").get(0));ko.applyBindings(TeG.AccountDetails.detailsTabObserve,$("#accountDetailsTabDetails").get(0));$("#StationDetails #ldBetGroupAreaTr, #PlayerDetails #ldBetGroupAreaTr").removeClass("hidden");$("#StationDetails #betGroupAreaTr, #PlayerDetails #betGroupAreaTr").removeClass("hidden");$('input[name="stationName"]').length>0&&$('input[name="stationName"]').focus();$('#accountDetailsTabDetails input[id="'+t.BettingProfileName+'"]').prop("checked",!0);$('#accountDetailsTabDetails input[id="originalBettingProfile"]').val(t.BettingProfileName);n=="PlayersGrid"?$("#accountDetailsName").text(t.FirstName):$("#accountDetailsName").text(t.AccountNumber);$("#accountDetailsTabDetails").removeClass("divLoading");$('input[name="firstName"]').focus();splitterResize();$("#AccTabDetailsSave").on("click",function(){var r;if($('#accountDetailsTabDetails input[name="firstName"]').blur(),$('#accountDetailsTabDetails input[name="lastName"]').blur(),$('#accountDetailsTabDetails input[name="mobileNumber"]').blur(),$('#accountDetailsTabDetails input[name="email"]').blur(),$('#accountDetailsTabDetails input[name="stationName"]').blur(),!(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#accountDetailsTabDetails"))){var u=$('#accountDetailsTabDetails input[name="profile"]:checked').parent().find("label").html(),t=$("tr.k-state-selected").find(".AccountNo").html(),f=$("#profileName_"+t).html();if($.trim(u)!=$.trim(f)){function e(){i(function(){for(var f=$("#"+n).data("kendoGrid").dataSource,r,i=0;i<f._data.length;i++)if(r=f.at(i),$.trim(r.AccountNo)==$.trim(t)){r.set("ProfileName",u);$('div[data-role="grid"]').data("kendoGrid").select($("#firstName_"+t).parent());$('div[data-role="grid"]').data("kendoGrid").select($("#nickName_"+t).parent());break}});r.hide()}function o(){r.hide();tegPopups.closeTotalHover()}tegPopups.showDaisyWheelTotalHover();r=new tegPopups.preConfirmation(e,o);r.show(TeG.Translations.PopupChangeBettingProfileTitle,TeG.Translations.PopupChangeBettingProfile)}else tegPopups.showDaisyWheelTotalHover(),i()}});$("#AccTabDetailsCancel").on("click",function(){$("#StationDetails").css("display","none");$("#PlayerDetails").css("display","none");$("#DivStationsGrid").css("display","block");$("#DivPlayersGrid").css("display","block");tegAccountDetails.BackToList()});o=$("tr.k-state-selected").find(".AccountNo").html();s=$("#profileName_"+o).html();$.each($("#profileContainerDetails").find("input"),function(){$.trim($(this).parent().find("label").html())==$.trim(s)&&($(this).attr("checked","checked"),$("#StationDetails").length>0&&($(this).hide(),$(this).parent("p").show()))});$("#backToList").off();$("#backToList").on("click",tegAccountDetails.BackToList);TeG.AccountDetails().Validate().Details()}}})},AccountTabShow:function(){var t,n,u,i,r,f,e,o;this.SendMobileCasinoCheck=function(){$('#accountDetailsTabActions input[name="emailCheck"]').is(":checked")||$('#accountDetailsTabActions input[name="smsCheck"]').is(":checked")?$("#accountDetailsTabActions .sendButton").removeAttr("disabled"):$("#accountDetailsTabActions .sendButton").attr("disabled","disabled")};this.LockShow=function(){$("#lockUnLockR2f_"+TeG.AccountDetails.account).focus();$("#lockUnLockR2f_"+TeG.AccountDetails.account).find("span").eq(0).html(TeG.Translations.NestedBlockUnLockAccountMessage);$("#lockUnLockR2f_"+TeG.AccountDetails.account).find("span").eq(1).removeClass("lock").addClass("unlock");$("#lockUnLockR2f_"+TeG.AccountDetails.account).find("span").eq(2).html(TeG.Translations.NestedBlockUnLockAccount);$("#accountTitleInfo").find("span").eq(2).removeAttr("style");$("#accountTitleInfo").find("span").eq(3).removeAttr("style");$("#res2tPassword_"+TeG.AccountDetails.account).attr("disabled","disabled").addClass("disabled")};this.UnlockShow=function(){$("#accountTitleInfo").find("span").eq(2).css("display","none");$("#accountTitleInfo").find("span").eq(3).css("display","none");$('#accountDetailsTabDetails input[name="isMobilePlayer"]').is(":checked")&&$(".mobileCasinoAcc").css("display","block").prev().css("display","block")};$(".tabBarBotton").removeClass("selected");$("#accountDetailsActionTab").addClass("selected");$(".detailsBody").css("display","none");$("#accountTitleInfo").find("span").eq(1).html(TeG.AccountDetails.account);$(".js-lockUnlock").html($(".nested_block .widgetLockUnlockAccount").parent().html());$(".js-resetPassword").html($(".nested_block .widgetButtonResetPassword").parent().html());$(".js-resetLoginAttempt").html($(".nested_block .widgetButtonResetLoginAttempts").parent().html());$(".js-resetLoginAttempt").html($(".nested_block .widgetButtonResetLoginAttempts").parent().html());$(".js-updateCustomerProgressiveStatus").html($(".nested_block .widgetUpdateCustomerProgressiveStatus").parent().html());$(".js-deleteAccount").html($(".nested_block .widgetButtonDeleteAccount ").parent().html());loginAttempsCountSpan=$(".js-resetLoginAttempt").find("span.count.red-blink").find("span");loginAttempsCountSpan.length>0&&loginAttempsCountSpan.css("opacity")&&Number(loginAttempsCountSpan.css("opacity"))<.75&&loginAttempsCountSpan.css("opacity",.75);$("#accountDetailsTabActions").find(".errorMessage").remove();$("#accountDetailsTabActions").find("input.error").removeClass("error");$('#accountDetailsTabActions input[name="phone"]').attr("disabled","disabled");$('#accountDetailsTabActions input[name="smsCheck"]').removeAttr("checked");$('#accountDetailsTabActions input[name="emailAction"]').removeAttr("disabled");$('#accountDetailsTabActions input[name="emailAction"]').val(TeG.AccountDetails.TabDetails.Data.Email);$('#accountDetailsTabActions input[name="phone"]').val(TeG.AccountDetails.TabDetails.Data.MobilePhoneNumber);$('#accountDetailsTabActions input[name="emailCheck"]').attr("checked","checked");$("#resetLoginAtt2mpt_"+TeG.AccountDetails.account+" span.count").text($("#resetLoginAttempt_"+TeG.AccountDetails.account+" span.count").text());$("#accountDetailsTabActions .sendButton").removeClass("loading");$('#accountDetailsTabAction input[name="emailAction"]').val($.trim($('#accountDetailsTabDetails input[name="emailAction"]').val()));$("#accountDetailsTabActions").css("display","block");t=new TeG.Widget.Button.LockUnlockAccount;$(".detailsBody .widgetLockUnlockAccount").off();$(".detailsBody .widgetLockUnlockAccount").on(kendo.support.click,t.Click);t.On().addListenerIfNotExist("successFlowEnd",tegAccountDetails.WidgetListener.LockUnlockAccount.SuccessFlowEnd);t.On().addListenerIfNotExist("successFlowEnd",tegCustomerAccountList.WidgetListener.LockUnlockAccount.SuccessFlowEnd);n=new TeG.Widget.Button.ResetPassword;$(".detailsBody .widgetButtonResetPassword").off();$(".detailsBody .widgetButtonResetPassword").on(kendo.support.click,n.Click);n.On().addListenerIfNotExist("successFlowStart",tegAccountDetails.WidgetListener.ResetPassword.SuccessFlowStart);n.On().addListenerIfNotExist("successFlowStart",tegCustomerAccountList.WidgetListener.ResetPassword.SuccessFlowStart);n.On().addListenerIfNotExist("successFalse",tegAccountDetails.BackToList);n.On().addListenerIfNotExist("successFalse",tegCustomerAccountList.WidgetListener.ResetPassword.SuccessFalse);u=new TeG.Widget.Button.ResetLoginAttempts;$(".detailsBody .widgetButtonResetLoginAttempts").off();$(".detailsBody .widgetButtonResetLoginAttempts").on(kendo.support.click,u.Click);u.On().addListenerIfNotExist("successFlowStart",tegAccountDetails.WidgetListener.ResetLoginAttempt.SuccessFlowStart);i=new TeG.Widget.Button.DeleteAccount;$(".detailsBody .widgetButtonDeleteAccount").off();$(".detailsBody .widgetButtonDeleteAccount").on(kendo.support.click,i.Click);i.On().addListener("click",tegCustomerAccountList.WidgetListener.DeleteAccount.Click);i.On().addListenerIfNotExist("successFlowEnd",tegAccountDetails.WidgetListener.DeleteAccount.SuccessFlowEnd);r=new TeG.Widget.Button.UpdateCustomerProgressiveStatus;$(".detailsBody .widgetUpdateCustomerProgressiveStatus").off();$(".detailsBody .widgetUpdateCustomerProgressiveStatus").on(kendo.support.click,r.Click);r.On().addListenerIfNotExist("successFlowEnd",tegAccountDetails.WidgetListener.UpdateCustomerProgressiveStatus.SuccessFlowEnd);r.On().addListenerIfNotExist("successFlowEnd",tegCustomerAccountList.WidgetListener.UpdateCustomerProgressiveStatus.SuccessFlowEnd);this.SendMobileCasinoCheck();f=$("#lockUnLockRef_"+TeG.AccountDetails.account).find("span").eq(1).hasClass("unlock");f?this.LockShow(TeG.AccountDetails.account):this.UnlockShow(TeG.AccountDetails.account);e=0;o=0;$('#accountDetailsTabActions input[name="emailCheck"]').off();$('#accountDetailsTabActions input[name="emailCheck"]').on(kendo.support.click,{sendMobileCasinoCheck:this.SendMobileCasinoCheck},function(n){n.data.sendMobileCasinoCheck();$('#accountDetailsTabActions input[name="emailCheck"]').is(":checked")?($('#accountDetailsTabActions input[name="emailAction"]').removeAttr("disabled"),$('#accountDetailsTabActions input[name="emailAction"]').focus()):($('#accountDetailsTabActions input[name="emailAction"]').attr("disabled","disabled"),$('#accountDetailsTabActions [for="emailAction"]').remove(),$('#accountDetailsTabActions input[name="emailAction"]').removeClass("error"))});$('#accountDetailsTabActions input[name="smsCheck"]').off();$('#accountDetailsTabActions input[name="smsCheck"]').on(kendo.support.click,{sendMobileCasinoCheck:this.SendMobileCasinoCheck},function(n){n.data.sendMobileCasinoCheck();$('#accountDetailsTabActions input[name="smsCheck"]').is(":checked")?($('#accountDetailsTabActions input[name="phone"]').removeAttr("disabled"),$('#accountDetailsTabActions input[name="phone"]').focus()):($('#accountDetailsTabActions input[name="phone"]').attr("disabled","disabled"),$('#accountDetailsTabActions [for="phone"]').remove(),$('#accountDetailsTabActions [name="phone"]').removeClass("error"))});$("#accountDetailsTabActions .sendButton").off();$("#accountDetailsTabActions .sendButton").on(kendo.support.click,{accountNumber:TeG.AccountDetails.account},function(n){($('#accountDetailsTabActions input[name="emailCheck"]').is(":checked")&&$('#accountDetailsTabActions input[name="emailAction"]').blur(),$('#accountDetailsTabActions input[name="smsCheck"]').is(":checked")&&$('#accountDetailsTabActions input[name="phone"]').blur(),(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#accountDetailsTabActions")))||(tegPopups.showDaisyWheelTotalHover(),$.ajax({type:"POST",url:tegUrlHelper.sendMobileGame,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify({accountNumber:n.data.accountNumber,email:$('#accountDetailsTabActions input[name="emailCheck"]').is(":checked")?$('#accountDetailsTabActions input[name="emailAction"]').val():"",mobileNumber:$('#accountDetailsTabActions input[name="smsCheck"]').is(":checked")?$('#accountDetailsTabActions input[name="phone"]').val():"",gameLanguageId:$("#playerLanguageChoice").val()}),error:function(){var t,n;tegPopups.totalHoverRemoveDaisyWheel();t=new tegPopups.error;t.CloseButtonHandler=function(n){n.data.that.hide();tegPopups.closeTotalHover()};n=TeG.Translations.AccountDetailsTabActionMobileGameLinkWasSentFailed+" ";$('input[name="emailCheck"]').is(":checked")&&$('input[name="smsCheck"]').is(":checked")?n+=$('input[name="emailAction"]').val()+"/"+$('input[name="phone"]').val():$('input[name="emailCheck"]').is(":checked")?n+=$('input[name="emailAction"]').val():$('input[name="smsCheck"]').is(":checked")&&(n+=$('input[name="phone"]').val());t.show(TeG.Translations.AccountDetailsTabActionMobileGameLinkWasSentTitle,n)},success:function(n){var i,r,t,u,f;n=JSON.parse(n);tegPopups.totalHoverRemoveDaisyWheel();i=null;r=null;$('#accountDetailsTabActions input[name="emailCheck"]').is(":checked")&&(i=$('#accountDetailsTabActions input[name="emailAction"]').val());$('#accountDetailsTabActions input[name="smsCheck"]').is(":checked")&&(r=$('#accountDetailsTabActions input[name="phone"]').val());i&&r?t='<span class="greenText">'+i+"<\/span> "+TeG.Translations.CommonAnd+' <span class="greenText">'+r+"<\/span>":i?t='<span class="greenText">'+i+"<\/span>":r&&(t='<span class="greenText">'+r+"<\/span>");n.IsSucceed?(u=new tegPopups.success,u.OkButtonHandler=function(){$("#PlayerDetails").css("display","none");$("#DivPlayersGrid").css("display","block");nestedBlockScripts.NestedBlockClose();u.hide();tegPopups.closeTotalHover()},u.show(TeG.Translations.AccountDetailsTabActionMobileGameLinkWasSentTitle,TeG.Translations.AccountDetailsTabActionMobileGameLinkWasSent+" "+t)):(f=new tegPopups.error,f.CloseButtonHandler=function(){$("#PlayerDetails").css("display","none");$("#DivPlayersGrid").css("display","block");nestedBlockScripts.NestedBlockClose();f.hide();tegPopups.closeTotalHover()},f.show(TeG.Translations.PopupError,TeG.Translations.AccountDetailsTabActionMobileGameLinkWasSentFailed+" "+t))}}))});splitterResize()},PlayerEarningTabShow:function(){$(".tabBarBotton").removeClass("selected");$("#accountDetailsPlayerEarningTab").addClass("selected");$(".detailsBody").css("display","none");$(".detailsReport").html("");$("#accountDetailsTabPlayerEarnings").html("").addClass("divLoading").show();$.ajax({type:"POST",url:tegUrlHelper.playerEarningTab,contentType:"application/json; charset=utf-8",dataType:"html",error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabPlayerEarnings").removeClass("divLoading")},success:function(n){ko.cleanNode($("#accountDetailsTabPlayerEarnings").get(0));$("#accountDetailsTabPlayerEarnings").children().remove();$("#accountDetailsTabPlayerEarnings").html(n);ko.applyBindings({AccountNumber:TeG.AccountDetails.account},$("#accountDetailsTabPlayerEarnings").get(0));$("#accountDetailsTabPlayerEarnings").removeClass("divLoading");splitterResize()}})},ProgressiveGamePlayTabShow:function(){$(".tabBarBotton").removeClass("selected");$("#accountDetailsProgressiveGamePlayTab").addClass("selected");$(".detailsBody").css("display","none");$(".detailsReport").html("");$("#accountDetailsTabProgressiveGamePlay").html("").addClass("divLoading").show();$.ajax({type:"POST",url:tegUrlHelper.playerProgressiveGamePlayTab,contentType:"application/json; charset=utf-8",error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabProgressiveGamePlay").removeClass("divLoading")},success:function(n){ko.cleanNode($("#accountDetailsTabProgressiveGamePlay").get(0));$("#accountDetailsTabProgressiveGamePlay").children().remove();$("#accountDetailsTabProgressiveGamePlay").html(n);ko.applyBindings({AccountNumber:TeG.AccountDetails.account},$("#accountDetailsTabProgressiveGamePlay").get(0));$("#accountDetailsTabProgressiveGamePlay").removeClass("divLoading");splitterResize()}})},ProfitByGameTypeTabShow:function(){$(".tabBarBotton").removeClass("selected");$("#accountDetailsProfitByGameTypeTab").addClass("selected");$(".detailsBody").css("display","none");$(".detailsReport").html("");$("#accountDetailsTabProfitByGameType").html("").addClass("divLoading").show();$.ajax({type:"POST",url:tegUrlHelper.playerProfitByGameTypeTab,contentType:"application/json; charset=utf-8",dataType:"html",error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabProfitByGameType").removeClass("divLoading")},success:function(n){ko.cleanNode($("#accountDetailsTabProfitByGameType").get(0));$("#accountDetailsTabProfitByGameType").children().remove();$("#accountDetailsTabProfitByGameType").html(n);ko.applyBindings({AccountNumber:TeG.AccountDetails.account},$("#accountDetailsTabProfitByGameType").get(0));$("#accountDetailsTabProfitByGameType").removeClass("divLoading");splitterResize()}})},GamePlayLocationTabShow:function(){$(".tabBarBotton").removeClass("selected");$("#accountDetailsGamePlayLocationTab").addClass("selected");$(".detailsBody").css("display","none");$(".detailsReport").html("");$("#accountDetailsTabGamePlayLocation").html("").addClass("divLoading").show();$.ajax({type:"POST",url:tegUrlHelper.playerGamePlayLocationTab,contentType:"application/json; charset=utf-8",dataType:"html",error:function(n){tegErrorHandler.processError(n);$("#accountDetailsGamePlayLocationTab").removeClass("divLoading")},success:function(n){$("#accountDetailsTabGamePlayLocation").html(n);$("#accountDetailsTabGamePlayLocation").removeClass("divLoading");splitterResize()}})},FundsOnTableTabShow:function(n){$(".tabBarBotton").removeClass("selected");$("#accountDetailsFundsOnTableTab").addClass("selected");$(".detailsBody").css("display","none");$(".detailsReport").html("");$("#accountDetailsTabFundsOnTable").html("").addClass("divLoading").show();var t=tegUrlHelper.fundsOnTableTabDetails,n=n;$.ajax({type:"POST",url:t,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify({accountNumber:n||TeG.AccountDetails.account}),error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabDetails").removeClass("divLoading")},success:function(t,i,r){var u=[];tegErrorHandler.checkAjaxResponse(r)&&(t=JSON.parse(t),TeG.GlobalVariables.AllowStationDeposit=t.AllowStationDeposit,$.isArray(t.ListFunds)||(u.push(t.ListFunds),t=u),$("div#accountDetailsTabFundsOnTable").html('<div id="grid" data-role="grid"><\/div>'),t.ListFunds.length>0?($("div#grid").kendoGrid({columns:[{field:"GameName",title:TeG.Translations.ColumnNameGame},{field:"BetsAmount",title:TeG.Translations.ColumnNameBetsAmount,attributes:{"class":"gridDataNumber"}},{field:"PayoutAmount",title:TeG.Translations.ColumnNamePayoutAmount,attributes:{"class":"gridDataNumber"}}],dataSource:{data:t.ListFunds,pageSize:10},selectable:"row",height:"100%",filterable:!0,sortable:!0,pageable:!0}),$.ajax({url:tegUrlHelper.GetCustomerAccountBalance,type:"POST",data:JSON.stringify({accountNumber:n,force:!1}),contentType:"application/json; charset=utf-8",dataType:"json",error:function(n){tegErrorHandler.processError(n);$("#accountDetailsTabFundsOnTable").removeClass("divLoading");splitterResize()},success:function(t){t=$.extend({balance:"0.0"},t);Number(t.balance)>0&&TeG.GlobalVariables.AllowStationDeposit&&($("div#accountDetailsTabFundsOnTable").prepend('<div id="btnWithdrawal" class="btn_holder_nested_block"><\/div>'),$("div#btnWithdrawal").css("text-align","right"),$("div#btnWithdrawal").append('<button id="withdrawalBtn_{AccountNo}" class="basic_btn" onclick="nestedBlockScripts.Withdrawal().Send($(this), function(){tegAccountDetails.BackToList();})">{Withdrawal}<\/button>'.replace("{AccountNo}",n).replace("{Withdrawal}",TeG.Translations.BtnWithdrawal)));$("#accountDetailsTabFundsOnTable").removeClass("divLoading");splitterResize()}})):($("div#accountDetailsTabFundsOnTable").html('<div id="reportDataTitle" class="reportDataTitle"><h2 id="reportDataTitleNoData"><\/h2><\/div>'),$("h2#reportDataTitleNoData").html(TeG.Translations.RemortNoDataTitleNoFundsFound),$("#accountDetailsTabFundsOnTable").removeClass("divLoading"),splitterResize()))}})},Validate:function(){return{Details:function(){if(n=="StationsGrid"){$('#accountDetailsTabDetails input[name="firstName"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="firstName"]')).NameUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="firstName"]').html().replace(/\*|\:/g,""))).NameIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="firstName"]').html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="firstName"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()});$('#accountDetailsTabDetails input[name="lastName"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="lastName"]')).NameUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="lastName"]').html().replace(/\*|\:/g,""))).NameIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="lastName"]').html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="lastName"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()});$('#accountDetailsTabDetails input[name="stationName"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="stationName"]')).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="stationName"]').html().replace(/\*|\:/g,""))).StationIncorrectEditListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="stationName"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()})}else if(n=="PlayersGrid"){$('#accountDetailsTabDetails input[name="firstName"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="firstName"]')).PlayerUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="firstName"]').html().replace(/\*|\:/g,""))).PlayerIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="firstName"]').html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="firstName"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()});$('#accountDetailsTabDetails input[name="lastName"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="lastName"]')).PlayerUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="lastName"]').html().replace(/\*|\:/g,""))).PlayerIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="lastName"]').html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="lastName"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()})}$('#accountDetailsTabDetails input[name="mobileNumber"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="mobileNumber"]')).MobileNumberIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="mobileNumber"]').html().replace(/\*|\:/g,""))).MobileNumberUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="mobileNumber"]').html().replace(/\*|\:/g,""))).ErrorRenderSlideDown({style:"margin-top:-4px;"})});$('#accountDetailsTabDetails input[name="email"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="email"]')).EmailIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="email"]').html().replace(/\*|\:/g,""))).EmailUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="email"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()});$('#accountDetailsTabDetails input[name="stationName"]').on("blur",function(){new TeG.Validator($('#accountDetailsTabDetails input[name="stationName"]')).StationIncorrectEditListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="stationName"]').html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#accountDetailsTabDetails label[for="stationName"]').html().replace(/\*|\:/g,""))).ErrorRenderDefault()})},Actions:function(){var n=0;$('#accountDetailsTabActions input[name="emailAction"]').on("blur",function(){var t=new TeG.Validator($('#accountDetailsTabActions input[name="emailAction"]'));t.DisplayErrorMessageOffsetLeft(n).EmailIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#emailLabel").find("span").eq(0).html().replace(/\*|\:/g,""))).EmailUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#emailLabel").find("span").eq(0).html().replace(/\*|\:/g,"")));$('#accountDetailsTabActions input[name="emailCheck"]').is(":checked")&&t.RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$("#emailLabel").find("span").eq(0).html().replace(/\*|\:/g,"")));t.ErrorRenderDefault()});$('#accountDetailsTabActions input[name="phone"]').on("blur",function(){var t=new TeG.Validator($('#accountDetailsTabActions input[name="phone"]'));t.DisplayErrorMessageOffsetLeft(n).MobileNumberIncorrectListener(TeG.Translations.ValidateInvalidMobileNumber).MobileNumberUnsupportedCharsListener(TeG.Translations.ValidateInvalidMobileNumber);$('#accountDetailsTabActions input[name="smsCheck"]').is(":checked")&&t.RequiredListener(TeG.Translations.ValidateInsertMobileNumber);t.ErrorRenderDefault()})}}},BackToList:function(){$("#PlayerDetails").html("");$("#DivPlayersGrid").show();$("#StationDetails").html("");$("#DivStationsGrid").show();TeG.Reports().EnableToolBar();splitterResize()},WidgetListener:{ResetPassword:{SuccessFlowStart:function(){tegAccountDetails.BackToList()}},LockUnlockAccount:{SuccessFlowEnd:function(){tegAccountDetails.BackToList()}},UpdateCustomerProgressiveStatus:{SuccessFlowEnd:function(){tegAccountDetails.BackToList()}},ResetLoginAttempt:{SuccessFlowStart:function(){tegAccountDetails.BackToList()}},DeleteAccount:{SuccessFlowEnd:function(){tegAccountDetails.BackToList();customerAccountListManager.RefreshGrid()}}}}};tegAccountDetails=TeG.AccountDetails()