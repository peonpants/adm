var TeG=TeG||{};TeG.NestedBlock=function(n,t){n==null&&(n="PlayersGrid");t==null&&(t="PlayerDetails");var i=this;return{LockUnlock:function(t,i){var r=t.attr("id").substring(14),u=$(t.find("span").get(1)).hasClass("lock")?"Locked":"Open";t.addClass("loading");$.ajax({type:"POST",url:tegUrlHelper.UpdateAccountStatus,contentType:"application/json; charset=utf-8",dataType:"json",data:JSON.stringify({accountNumber:r,accountStatus:u}),error:function(n){tegErrorHandler.processError(n,TeG.Translations.NestedBlockErrorLockUnlockMessage)}}).done(function(f){var o,h,c;if(i&&(o=i(f)),t.removeClass("loading"),u=="Open")$("#status_"+r).html("<div style='text-align:center'><img alt='Open' src='/Images/statusOpen.png' /><\/div>").attr("title","");else{$("#status_"+r).html("<div style='text-align:center'><img alt='Open' src='/Images/statusLocked.png' /><\/div>");var l=infoBlockData.timeDiff?infoBlockData.timeDiff:0,s=getUserDateTime(l),e=s.getDate();e=e.length==1?"0"+e:e;h=("0"+(s.getMonth()+1)).replace(/(\d{2})$/,"$1");c=s.getFullYear();$("#status_"+r).attr("title","Lock Date: "+e+"-"+h+"-"+c+". Locked by: "+$("#firstName").html()+" "+$("#lastName").html()+"("+$("#memberType").html()+")")}TeG.NestedBlock(n).NestedBlockClose();(!o||o&&o.nestedBlockOpen)&&TeG.NestedBlock(n).NestedBlockOpen()})},SetInitalFocus:function(n){$("#DepositInput_"+n).focus();-1!=$("#status_"+n).html().indexOf("statusLocked")&&$("#lockUnLockRef_"+n).focus();$(":focus").addClass("tab-first")},ResetPassword:function(t,i,r){function h(){var o,h;e||(e=!0,u.setOKButtonTitle(s),i&&i.type&&i.type!="actionDetails"?(o=null,h=null):(o=$("#email").is(":checked")?$('input[name="emailValue"]').val():"",h=$("#sms").is(":checked")?$('input[name="smsValue"]').val():""),$.ajax({type:"POST",url:tegUrlHelper.resetCustomerAccountPassword,contentType:"application/json; charset=utf-8",dataType:"json",data:JSON.stringify({accountNumber:f,confirmationEmail:o,confirmationMobileNumber:h}),error:function(i){u.hide();$(t).removeClass("loading");n=="PlayersGrid"?tegErrorHandler.processError(i,TeG.Translations.NestedBlockResetPasswordPopupTitle):n=="StationsGrid"&&tegErrorHandler.processError(i,TeG.Translations.NestedBlockResetPasswordPopupTitle);e=!1}}).done(function(i){var s,o,h;if(i.IsSucceed="false"&&i.failureReason){s=new tegPopups.error;s.CloseButtonHandler=function(){$("#DivPlayersGrid").show();$("#PlayerDetails").hide();$("#receipt").is(":visible")||$("#change").click();$('input[name="emailValue"]').focus();tegPopups.closeTotalHover()};t.removeClass("loading");u.hide();s.show(TeG.Translations.NestedBlockResetPasswordConfirmationPopupTitle,i.failureReason);return}r&&r(i);t.removeClass("loading");u.hide();o="";h=TeG.Translations.NestedBlockResetPasswordPopupTitle;n=="PlayersGrid"?o=TeG.Translations.NestedBlockResetPasswordForPlayer+" <b> "+$("#firstName_"+f).html()+" "+$("#lastName_"+f).html()+" <\/b> "+TeG.Translations.NestedBlockResetPasswordHasBeenChangedForPlayer:n=="StationsGrid"&&(o=TeG.Translations.NestedBlockResetPasswordForStation+" <b> "+$("#nickName_"+f).html()+" <\/b> "+TeG.Translations.NestedBlockResetPasswordHasBeenChangedForStation+' <span class="greenText boldText">'+i.newPassword+"<\/span>");tegPopups.success(function(){tegPopups.closeTotalHover();tegPopups.success().hide()}).show(h,o);new TeG.NestedBlock(n).NestedBlockClose();e=!1}))}function c(){u.setOKButtonTitle(s);t.removeClass("loading");u.hide();tegPopups.closeTotalHover()}var s,e;if($("#receipt").show(),!(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#receipt"))){$("#receipt").hide();var l=TeG.Translations.NestedBlockResetPasswordConfirmationTitle,f=t.attr("id").substring(14),u=new tegPopups.preConfirmation(h,c),a=TeG.Translations.NestedBlockResetPasswordConfirmationPopupTitle,o="";n=="PlayersGrid"?o=TeG.Translations.NestedBlockResetPasswordAreYouSure+" <b> "+$("#firstName_"+f).html()+" "+$("#lastName_"+f).html()+"<\/b>?":n=="StationsGrid"&&(o=TeG.Translations.NestedBlockResetPasswordAreYouSure+" <b> "+$("#nickName_"+f).html()+"<\/b>?");tegPopups.showTotalHover();t.addClass("loading");s=u.getOKButtonTitle();u.setOKButtonTitle(l);u.show(a,o);e=!1}},ResetLoginAttempts:function(n){var t=n.attr("id").substring(18);n.addClass("loading");$.ajax({type:"POST",url:tegUrlHelper.ResetLoginAttempts,contentType:"application/json; charset=utf-8",dataType:"json",data:JSON.stringify({accountNumber:t}),error:function(t){tegErrorHandler.processError(t,TeG.Translations.NestedBlockResetLoginAttemptsMessage);n.removeClass("loading")}}).done(function(){$("#PlayerDetails").css("display","none");$("#StationDetails").css("display","none");$("#DivPlayersGrid").css("display","block");$("#DivStationsGrid").css("display","block");n.removeClass("loading");n.find("span").last().text("0")})},EditAccount:function(i,r){var u=i.attr("id").substring(10),r=r,f;$("#Div"+n).addClass("divLoading");f=tegUrlHelper.PlayerDetails;n=="StationsGrid"&&(f=tegUrlHelper.StationDetails);$.ajax({type:"POST",url:f,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify({accountNumber:u}),error:function(n){tegErrorHandler.processError(n,TeG.Translations.NestedBlockResetLoginAttemptsMessage);i.removeClass("divLoading")}}).done(function(i){i=i.replace(/(.*?\r?\n?.*?)(\<div.*)/,"$2");$("#Div"+n).removeClass("divLoading").css("display","none");$("#"+t).html(i);accountDetailsScripts.Validate().Details();accountDetailsScripts.Validate().Actions();$("#accountDetailsName").html($("#firstName_"+u).html());accountDetailsScripts.GetDetailsTab(u);r&&r()})},Deposit:function(){return{InputBlur:function(n){new TeG.Validator(n).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,n.val(),$("#balance").html().replace(/\s|\,/g,"")).MinNumberListener(TeG.Translations.ValidateDepositLessThan1Credit,tegFinancial.ConvertToCredits(n.val()),1).CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml();(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#depositDivBlock"))&&($(".creditBlockDeposit").hide(),$(".errorMessageBlockextendedDeposit").show())},InputFocus:function(){$(".errorMessageBlockextendedDeposit").hide();$(".creditBlockDeposit").show()},InputKeyPress:function(n,t){return!TeG.Utils().isNotAllowedNumericKey(t,n.val())},InputKeyUp:function(n,t){var i,r;if(t.which!=kendo.keys.ENTER&&t.which!=kendo.keys.RIGHT)if((new TeG.Validator).CleanAllError($("div#depositDivBlock")),$(".errorMessageBlockextended").hide(),/\.\d{3,}/.test(n.val())&&n.val(n.val().replace(/^(\d*\.\d{2}\s*)(.*)/,"$1")),$.trim(n.val())!=""&&Number(n.val())>0)if(i=n.attr("id").substring(13),new TeG.Validator(n).CurrencyListener(null).isValid&&$("#depositCredits").html(tegFinancial.CurrencyFormat(tegFinancial.ConvertToCredits(n.val()))),r=new TeG.Validator($("#DepositInput_"+i)),r.DisplayErrorMessageOffsetTop(-45).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,$("#DepositInput_"+i).val(),Number($("#balance").html().replace(/\s|\,/g,""))).CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue).Not0NumberListener(TeG.Translations.ValidateInsertValidNumericValue).RequiredListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml(),r.isValid)$(".errorMessageBlockextendedDeposit").hide(),$("#depositCreditsInfoEmpty").hide(),$(".creditBlockDeposit").show(),$("#depositCreditsInfo").show();else{$(".creditBlockDeposit").hide();$("#depositCreditsInfo").hide();$("#depositCreditsInfoEmpty").show();$(".errorMessageBlockextendedDeposit").show();return}else $(".creditBlockDeposit").hide(),$("#depositCreditsInfo").hide(),$("#depositCreditsInfoEmpty").show()},Send:function(n){var t=n.attr("id").substring(11),i=new TeG.Validator($("#DepositInput_"+t));if(i.CleanAllError($("div.messenger")),i.DisplayErrorMessageOffsetTop(-45).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,$("#DepositInput_"+t).val(),Number($("#balance").html().replace(/\s|\,/g,""))).MinNumberListener(TeG.Translations.ValidateDepositLessThan1Credit,tegFinancial.ConvertToCredits($("#DepositInput_"+t).val()),1).CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue).Not0NumberListener(TeG.Translations.ValidateInsertValidNumericValue).RequiredListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml(),!i.isValid){$(".creditBlockDeposit").hide();$(".errorMessageBlockextendedDeposit").show();return}var r=$("#email").is(":checked")?$('input[name="emailValue"]').val():"",u=$("#sms").is(":checked")?$('input[name="smsValue"]').val():"",f=$("#DepositInput_ResetPassword").is(":checked");tegPopups.showTotalHover();n.addClass("loading");$.ajax({type:"POST",url:tegUrlHelper.deposit,contentType:"application/json; charset=utf-8",dataType:"json",data:JSON.stringify({accountNumber:t,amount:$("#DepositInput_"+t).val(),confirmationEmail:r,confirmationMobileNumber:u,resetPassword:f}),error:function(i){function r(){$("#DepositInput_"+t).focus();tegPopups.closeTotalHover();n.removeClass("loading")}tegErrorHandler.processError(i,TeG.Translations.DepositError,r)}}).done(function(n){customerAccountListManager.UpdateCustomerAccountBalances([{AccountNo:t}]);$("#nestedBlockMainPart").slideUp("slow",function(){tegPopups.closeTotalHover();$("#nestedBlockDepositPart").slideDown("slow",function(){$("#depositSuccessfulClose").focus()});$("#depositConfirmationNumber").html(n.ConfirmationNumber);n.NewPassword?($("#depositNewPasswordText").show(),$("#depositStationNewPassword").html(n.NewPassword)):$("#depositNewPasswordText").hide();$("#depositSuccessfulPrint").off();n.browserTime=TeG.Utils().getDateTimeFromInfoBlock();$("#depositSuccessfulPrint").on("click",{info:n},function(n){TeG.Popups().receipt().get(n.data.info.ConfirmationNumber).show()});$(document).trigger("DepositSendDone")});TeG.InfoBlock().updateBalance()})}}},Withdrawal:function(){return{ShowFundsOnTablePopUp:function(n){tegPopups.showTotalHover();var n=n,t=new tegPopups.confirmationError(function(){var n=$('div[data-role="grid"]').data("kendoGrid").dataItem($('div[data-role="grid"]').data("kendoGrid").select()).AccountNo;nestedBlockScripts.EditAccount($("#editAccNo_"+n),function(){tegAccountDetails.FundsOnTableTabShow(n)});tegPopups.closeTotalHover();t.hide()},function(){tegPopups.closeTotalHover();t.hide();n.focus()});t.setOKButtonTitle(TeG.Translations.PopupOk);t.setCancelButtonTitle(TeG.Translations.PopupClose);t.show(TeG.Translations.BtnWithdrawal,TeG.Translations.PopupFundsOnTableMessage)},InputBlur:function(n){var t=n.attr("id").substring(16),i=$("#WithDrawHiddenValue_"+t).val().replace(/\s|\,/g,"");new TeG.Validator(n).CleanAllError($("div#withdrawalDivBlock"));i>=1?new TeG.Validator(n).DisplayErrorMessageOffsetTop(-45).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,replaceAll(n.val(),",",""),tegFinancial.ConvertToCurrency($("#WithDrawHiddenValue_"+t).val().replace(/\s|\,/g,""))).MinNumberListener(TeG.Translations.ValidateWithdrawalLessThan1Credit,tegFinancial.ConvertToCredits(n.val()),1).CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml():new TeG.Validator(n).DisplayErrorMessageOffsetTop(-45).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,replaceAll(n.val(),",",""),tegFinancial.ConvertToCurrency($("#WithDrawHiddenValue_"+t).val().replace(/\s|\,/g,""))).CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml();(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#withdrawalDivBlock"))&&($(".creditBlockWithdrawal").hide(),$(".errorMessageBlockextendedWithdrawal").show())},InputFocus:function(){$(".errorMessageBlockextendedWithdrawal").hide();$(".creditBlockWithdrawal").show()},InputKeyPress:function(n,t){return!TeG.Utils().isNotAllowedNumericKey(t,n.val())},InputKeyUp:function(n,t){var i=n.attr("id").substring(16),r=new TeG.Validator(n),f=tegFinancial.CurrencyFormat(tegFinancial.ConvertToCredits(replaceAll($(String.format("input#WithDrawalInput_{0}",i)).val(),",",""))),u=$.trim($(String.format("input#WithDrawalInput_{0}",i)).val());if(t.which!=kendo.keys.ENTER&&t.which!=kendo.keys.RIGHT){if(new TeG.Validator(n).CleanAllError($("div#withdrawalDivBlock")),$(".errorMessageBlockextendedWithdrawal").hide(),u!=""&&u!="0"?($(String.format("input#WithDrawalInput_{0}",i)).nextAll("div.messenger").find("span#withdrawalCredits").html(f),$(".creditBlockWithdrawal").show()):$("p.creditBlockWithdrawal").hide(),r.DisplayErrorMessageOffsetTop(-45),r.MaxNumberListener(TeG.Translations.ValidateSufficientBalance,replaceAll(n.val(),",",""),tegFinancial.ConvertToCurrency($("#WithDrawHiddenValue_"+i).val().replace(/\s|\,/g,""))),r.CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue),r.ErrorRenderInHtml(),(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#withdrawalDivBlock"))){$(".creditBlockWithdrawal").hide();$(".errorMessageBlockextendedWithdrawal").show();return}/\.\d{3,}/.test(n.val())&&n.val(n.val().replace(/^(\d*\.\d{2})(.*)/,"$1"))}},Send:function(t,i){var r=t.attr("id").substring(14),f=new TeG.Validator($("#WithDrawalInput_"+r)),s=$("#WithDrawHiddenValue_"+r).val().replace(/\s|\,/g,""),e,o,u;if(f.CleanAllError($("#withdrawalDivBlock")),s>=1?f.DisplayErrorMessageOffsetTop(-45).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,replaceAll($("#WithDrawalInput_"+r).val(),",",""),tegFinancial.ConvertToCurrency($("#WithDrawHiddenValue_"+r).val().replace(/\s|\,/g,""))).MinNumberListener(TeG.Translations.ValidateWithdrawalLessThan1Credit,tegFinancial.ConvertToCredits($("#WithDrawalInput_"+r).val()),1).Not0NumberListener(TeG.Translations.ValidateInsertValidNumericValue).RequiredListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml():f.DisplayErrorMessageOffsetTop(-45).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,replaceAll($("#WithDrawalInput_"+r).val(),",",""),tegFinancial.ConvertToCurrency($("#WithDrawHiddenValue_"+r).val().replace(/\s|\,/g,""))).Not0NumberListener(TeG.Translations.ValidateInsertValidNumericValue).RequiredListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml(),!f.isValid){$("p.creditBlockWithdrawal").hide();$(".errorMessageBlockextendedWithdrawal").show();return}if(!(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#withdrawalDivBlock"))){for(e=$("#email").is(":checked")?$('input[name="emailValue"]').val():"",o=$("#sms").is(":checked")?$('input[name="smsValue"]').val():"",t.addClass("loading"),tegPopups.showTotalHover(),$("#RelatedProducts_"+r).val()=="Progressive"&&$.ajax({type:"POST",url:tegUrlHelper.getProgressiveWins,contentType:"application/json; charset=utf-8",dataType:"json",data:JSON.stringify({accountNumber:r}),error:function(n){function i(){$("#WithDrawalInput_"+r).focus();tegPopups.closeTotalHover();t.removeClass("loading")}tegErrorHandler.processError(n,"Withrawal error",i)}}).done(function(n){if(n.Amount&&n.Amount>0){function i(){tegPopups.closeTotalHover();tegPopups.success().hide();customerAccountListManager.RefreshGrid()}tegPopups.showTotalHover(i);var r=new tegPopups.error;r.show("Progressive","Can't remove progressive");tegPopups.closeTotalHover();t.removeClass("loading");tegPopups.closeTotalHover();return}}),u=$("#WithDrawalInput_"+r).val();u.indexOf(",")!=-1;)u=u.replace(",","");$.ajax({type:"POST",url:tegUrlHelper.withdrawal,contentType:"application/json; charset=utf-8",dataType:"json",data:JSON.stringify({accountNumber:r,amount:u,confirmationEmail:e,confirmationMobileNumber:o}),error:function(n){function i(){$("#WithDrawalInput_"+r).focus();tegPopups.closeTotalHover();t.removeClass("loading")}tegErrorHandler.processError(n,"Withrawal error",i)}}).done(function(t){n=="PlayersGrid"?$("#withdawalPlayerName").html(t.AccountNumber):$("#withdawalPlayerName").html($("#nickName_"+t.AccountNumber).html());$("#balanceAfterWithdawal").html(TeG.Financial().CurrencyFormat(t.AccountBalance));$("#balanceAfterWithdawalCurrencyISO").html(t.CurrencyIsoCode);$("#payAfterWithdawalCurrencyISO").html(t.CurrencyIsoCode);$("#payAfterWithDrawal").html(t.TransactionAmount);$("#payAfterWithdawalCredits").html(t.TransactionCreditAmount);$("#withdrawalConfirmationNumber").html(t.ConfirmationNumber);customerAccountListManager.UpdateCustomerAccountBalances([{AccountNo:t.AccountNumber}]);t.CustomerType=="Station"?($("#withdrawalPlayerSuccess").hide(),$("#withdrawalPlayerNeedToPay").hide(),$("#withdrawalStationSuccess").show(),$("#withdrawalStationNeedToPay").show()):t.CustomerType=="Player"&&($("#withdrawalPlayerSuccess").show(),$("#withdrawalPlayerNeedToPay").show(),$("#withdrawalStationSuccess").hide(),$("#withdrawalStationNeedToPay").hide());$("#nestedBlockMainPart").slideUp("slow",function(){tegPopups.closeTotalHover();$("#nestedBlockWithdrawalPart").slideDown("slow",function(){$("#withdrawalSuccessfulFinish").focus()});t.browserTime=TeG.Utils().getDateTimeFromInfoBlock();$("#withdrawalSuccessfulPrint").off();$("#withdrawalSuccessfulPrint").on("click",{info:t},function(n){TeG.Popups().receipt().get(n.data.info.ConfirmationNumber).show()});$(document).trigger("WithdrawalSendDone")});TeG.InfoBlock().updateBalance();typeof i=="function"&&i()})}}}},UpdateBalance:function(){return{InputBlur:function(n){new TeG.Validator(n).MaxNumberListener(TeG.Translations.ValidateSufficientBalance,n.val(),$("#balance").html().replace(/\s|\,/g,"")).MinNumberListener(TeG.Translations.ValidateDepositLessThan1Credit,tegFinancial.ConvertToCredits(n.val()),1).CurrencyListener(TeG.Translations.ValidateInsertValidNumericValue).ErrorRenderInHtml();(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#updateBalanceBlock"))&&($("#updateBalanceTip").hide(),$(".errorMessageBlockextended").show())},InputFocus:function(){$(".errorMessageBlockextended").hide();$("#updateBalanceTip").show()},InputKeyPress:function(n,t){return!TeG.Utils().isNotAllowedNegativeNumKey(t,n.val())},InputKeyUp:function(n){/\.\d{3,}/.test(n.val())&&n.val(n.val().replace(/^(\d*\.\d{2}\s*)(.*)/,"$1"));$.trim(n.val())!=""&&Number(n.val())>0&&new TeG.Validator(n).CurrencyListener(null).isValid},Send:function(){}}},NestedBlockClose:function(){n=$("#PlayersGrid").index()==-1?"StationsGrid":"PlayersGrid";var t=$("#"+n).data("kendoGrid"),i=t.select()[0].rowIndex,u=t.dataItem(t.select()),r=t.tbody.find(">tr:not(.k-grouping-row)").eq(i);t.collapseRow(r)},NestedBlockOpen:function(){n=$("#PlayersGrid").index()==-1?"StationsGrid":"PlayersGrid";var t=$("#"+n).data("kendoGrid"),i=t.select()[0].rowIndex,r=t.tbody.find(">tr:not(.k-grouping-row)").eq(i);t.select(r)},ChangeReceipt:function(n,t){var i=n;n.parent().parent().find(".form_cntr").toggle("easing",function(){t&&t();var i=$(this).parent().find(".nestedBlockChange");i.hasClass("expand")?(i.removeClass("expand").addClass("collapse"),$('input[name="emailValue"]').focus()):(i.removeClass("collapse").addClass("expand"),n.focus())})},ValidateEmail:function(n){var t=new TeG.Validator($('input[name="emailValue"]'));t.DisplayErrorMessageOffsetTop(-2);t.DisplayErrorMessageOffsetLeft(0);n.is(":checked")?(t.EmailIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$('#receipt label[for="emailValue"]').html().replace(/\*|\:/g,""))).EmailUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$('#receipt label[for="emailValue"]').html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$('#receipt label[for="emailValue"]').html().replace(/\*|\:/g,""))),t.isValid||($("#receipt").css("display")=="none"?this.ChangeReceipt($("#change"),function(){t.ErrorRenderDefault()}):t.ErrorRenderDefault())):t.CleanError()},ValidateSms:function(n){var t=new TeG.Validator($('input[name="smsValue"]'));t.DisplayErrorMessageOffsetTop(-2);t.DisplayErrorMessageOffsetLeft(-13);n.is(":checked")?(t.MobileNumberIncorrectListener(TeG.Translations.ValidateInvalidMobileNumber).MobileNumberUnsupportedCharsListener(TeG.Translations.ValidateInvalidMobileNumber).RequiredListener(TeG.Translations.ValidateInsertMobileNumber),t.isValid||($("#receipt").css("display")=="none"?this.ChangeReceipt($("#change"),function(){t.SetMessage(t.message).ErrorRenderDefault()}):t.SetMessage(t.message).ErrorRenderDefault())):t.CleanError()}}}