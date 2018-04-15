var TeG=TeG||{};TeG.RepresentativeParent={List:{activate:function(){this.init()},_gridName:null,_printTitle:null,gridBehaivor:null,widgetLockUnlockUrl:null,widgetResetPasswordUrl:null,setPrintTitle:function(n){this._printTitle=n},getPrintTitle:function(){return this._printTitle},setGridName:function(n){this._gridName=n},getGridName:function(){return this._gridName},gridOnBound:function(){resizeGrid();this.gridBehaivor||(this.gridBehaivor=new TeG.Grid($("#"+this.getGridName()).data("kendoGrid")));this.gridBehaivor.addColumnOrderBehaivor.call(this.gridBehaivor);this.gridBehaivor.onBound();this.gridBehaivor.addSearchBehaivor();$("#printRepresentativeList").off();$("#printRepresentativeList").on("click",{that:this},function(n){var t=new(TeG.Print().PrintGrid);t.setGrid($("#"+n.data.that.getGridName()).data("kendoGrid"));t.setTitle(n.data.that.getPrintTitle());t.store().open()});$("#AddRepresentativeLink").off();$("#AddRepresentativeLink").on("click",{that:this},function(n){n.data.that.addRepresentativeTab()});$("#view-representatives-passwords").off();$("#view-representatives-passwords").on("click",{that:this},function(n){n.data.that.Passwords().Show()});$("#back-from-passwords").off();$("#back-from-passwords").on("click",{that:this},function(n){n.data.that.Passwords().BackToList()});$("tr.k-master-row").removeClass("k-state-selected");var n=$('div[data-role="grid"]').data("kendoGrid");$(n.items()[0]).addClass("k-state-selected")},gridOnChange:function(){(TeG.isMobile()||TeG.isIPad())&&this.gridBehaivor.clickRow()},nestedContentLoad:function(){var n,t;$(".empty-table-part").width($("td.fake-column").outerWidth());$(".widgetLockUnlockAccount").focus();n=new TeG.Widget.Button.LockUnlockAccount;n.representativeList=this;$(".member_nested_block .widgetLockUnlockMember").off();$(".member_nested_block .widgetLockUnlockMember").on("click",n.Click);n.On().addListener("click",this.widgetListener.lockUnlock.click);n.On().addListener("successFlowEnd",this.widgetListener.lockUnlock.successFlowEnd);t=new TeG.Widget.Button.DeleteAccount;t.representativeList=this;$(".member_nested_block .widgetButtonDeleteAccount").off();$(".member_nested_block .widgetButtonDeleteAccount").on("click",t.Click);t.On().addListener("click",this.widgetListener.deleteMember.click);t.On().addListener("successFlowEnd",this.widgetListener.deleteMember.successFlowEnd);$(".member_nested_block .edit_link").off();$(".member_nested_block .edit_link").on("click",{that:this},function(n){n.data.that.representativeDetailsLoad.call(n.data.that)});this.nestedContentLoadConcrete();$("body").trigger("NestedContentLoaded")},addRepresentativeTab:function(){tegPopups.showDaisyWheelTotalHover();$.ajax({url:tegUrlHelper.addRepresentativeTab,type:"post",contentType:"application/x-www-form-urlencoded; charset=UTF-8",dataType:"html",that:this,error:function(n){tegErrorHandler.processError(n,TeG.Translations.PopupError)}}).done(function(n){var t=this.that;tegPopups.closeTotalHover();$("#addRepresentative").html(n).show();$("#DivRepresentativesGrid").hide();$("#addRemoveRepresentatives").show();var u=tegGeoApi.getIsoCode(),i="",r="";$(countriesList).each(function(n,t){t.IsoCode==u&&(i=t.PhonePrefix,r=t.Id)});t.ViewModelInit=function(){var n=this;n.firstName=ko.observable();n.lastName=ko.observable();n.email=ko.observable("");n.countryId=ko.observable(r);n.mobilePhoneNumber=ko.observable("");n.mobilePrefix=ko.observable(i);n.password=ko.observable();n.passwordAuto=ko.observable(1);n.emailSend=ko.observable(0);n.smsSend=ko.observable(0);n.allowImpersonateAsLogin=$("#allowLowerLevelLoginCheckBox").length>0?ko.observable(1):ko.observable(0);n.confirmationEmail=ko.computed(function(){return n.email()},n);n.confirmationMobileNumber=ko.computed(function(){var t=n.mobilePhoneNumber()?n.mobilePhoneNumber():"";return n.mobilePrefix().replace(/\s*\+*\s*|\s*/g,"")+t},n);n.addAccount=function(){model=ko.mapping.toJS(n,{ignore:["addAccount","backFromAdding"]});model.confirmationEmail=model.emailSend?model.confirmationEmail:"";model.confirmationMobileNumber=model.smsSend?model.confirmationMobileNumber:"";model.password=model.passwordAuto?"":model.password;model.mobilePrefix=model.mobilePhoneNumber?model.mobilePrefix.replace(/\s*\+*\s*|\s*/g,""):"";model.permissionList=[{Name:"AllowImpersonateAsLogin",Value:Boolean(model.allowImpersonateAsLogin)}];console.log(model);delete model.passwordAuto;delete model.smsSend;delete model.emailSend;delete model.allowImpersonateAsLogin;t.addLogin(model)};n.backFromAdding=function(){t.backFromAddingLogin()};n.changeSelectBox=function(){n.mobilePrefix($("#addCashierCountry").find(":selected").data("phonecode"))};n.ifEmptyConfEmail=function(){this.confirmationEmail||(this.confirmationEmail=n.email(),$("#addCashierSendEmail").val(this.confirmationEmail))};n.ifEmptyConfMobile=function(){this.confirmationMobileNumber||(this.confirmationMobileNumber=n.mobilePrefix().replace(/\s*\+*\s*|\s*/g,"")+n.mobilePhoneNumber(),$("#addCashierSendSMS").val(this.confirmationMobileNumber))}};t.ViewModel=new t.ViewModelInit;$("#back-to-represent-list").click(function(){t.backFromAddingLogin()});ko.cleanNode($("#addRepresentative").get(0));ko.applyBindings(t.ViewModel,$("#addRepresentative").get(0));t.Validate().Common("add");t.sendAccountDetailsInputs();$("#addCashierAutoPassword").on("change",{that:t},function(n){var t=$("#not-auto-password-block");$(this).is(":checked")?($("#addCashierPassword").off().val(""),$("#addCashierConfirmPassword").off().val(""),(new TeG.Validator).CleanAllError(t),t.slideUp("fast",function(){splitterResize()})):(n.data.that.Validate().Password("add"),t.slideDown("fast",function(){splitterResize()}))});splitterResize()})},representativeDetailsLoad:function(){tegPopups.showDaisyWheelTotalHover();console.log(this.gridBehaivor.getSelectedRowData());var n={LoginName:this.gridBehaivor.getSelectedRowData().LoginName};$.ajax({type:"post",url:tegUrlHelper.representativeDetails,contentType:"application/x-www-form-urlencoded; charset=UTF-8",dataType:"html",that:this,data:n,error:function(n){tegErrorHandler.processError(n,TeG.Translations.PopupError)}}).done(function(n){var i=this.that,t,u,r;tegPopups.closeTotalHover();$("#representativesDetails").html(n);$("#DivRepresentativesGrid").hide();$("#cashierDetailsName").html($.trim(i.gridBehaivor.getSelectedRowData().FirstName));t={};$.extend(t,i.gridBehaivor.getSelectedRowData());t.Balance=TeG.Financial().CurrencyFormat(t.Balance);t.allowImpersonateAsLogin=$("#representativesDetails").find("#allowLowerLevelLoginCheckBox").is(":checked")?1:0;t.MobilePhoneNumber&&(u=new RegExp("^"+t.PhonePrefix.replace("+","")),t.MobilePhoneNumber=t.MobilePhoneNumber.replace(u,""));r={saveDetails:function(){i.saveDetails(ko.toJS(this))},backFromDetails:function(){i.backFromDetails()}};$.extend(r,i.modelToObservable(t));ko.applyBindings(r,$("#accountDetailsTab").get(0));$("#change-password-cb").on("change",{that:i},function(n){var t=$("#detailsCashierPasswordEdit");$(this).is(":checked")?(n.data.that.Validate().Password("detail"),t.slideDown("fast",function(){splitterResize()})):($("#detailCashierPassword").off(),$("#detailCashierConfirmPassword").off(),(new TeG.Validator).CleanAllError(t),t.slideUp("fast",function(){splitterResize()}))});i.Validate().Common("detail");$("#backToCashierListFromDetails").on("click",{that:i},function(n){n.data.that.backFromDetails()});splitterResize()})},backFromDetails:function(){$("#representativesDetails").html("");$(".js-member-list").show();splitterResize()},backFromAddingLogin:function(){$("#addRemoveRepresentatives").hide();$(".js-member-list").show();splitterResize()},Validate:function(){return{Common:function(n){$("#"+n+"CashierFirstName").on("blur",function(){new TeG.Validator($("#"+n+"CashierFirstName")).NameUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierFirstNameLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).NameIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierFirstNameLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$("#"+n+"CashierFirstNameLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).ErrorRenderDefault()});$("#"+n+"CashierLastName").on("blur",function(){new TeG.Validator($("#"+n+"CashierLastName")).NameUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierLastNameLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).NameIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierLastNameLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$("#"+n+"CashierLastNameLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).ErrorRenderDefault()});$("#"+n+"CashierEmail").on("blur",function(){new TeG.Validator($("#"+n+"CashierEmail")).EmailIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#"+n+"CashierEmailLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).EmailUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#"+n+"CashierEmailLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).ErrorRenderDefault()});$("#"+n+"CashierMobileNumber").on("blur",function(){new TeG.Validator($("#"+n+"CashierMobileNumber")).MobileNumberIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#"+n+"CashierMobileNumberLabel").html().replace(/^s*|\*|\:|\s*$/g,"")),$("#"+n+"CashierMobilePrefix").text().replace(/\s|\+/g,"")).MobileNumberUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#"+n+"CashierMobileNumberLabel").html().replace(/^s*|\*|\:|\s*$/g,""))).ErrorRenderDefault()})},Password:function(n){$("#"+n+"CashierPassword").on("blur",function(){new TeG.Validator($("#"+n+"CashierPassword")).PasswordUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierPasswordLabel").html().replace(/\*|\:/g,""))).PasswordIncorrectListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierPasswordLabel").html().replace(/\*|\:/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$("#"+n+"CashierPasswordLabel").html().replace(/\*|\:/g,""))).ErrorRenderDefault();$("#"+n+"CashierConfirmPassword").val()!==""&&$("#"+n+"CashierConfirmPassword").focus().blur()});$("#"+n+"CashierConfirmPassword").on("blur",function(){new TeG.Validator($("#"+n+"CashierConfirmPassword")).PasswordUnsupportedListener(TeG.Translations.ValidateInsertFieldInCorrectFormat.replace(/%%field_label%%/,$("#"+n+"CashierConfirmPasswordLabel").html().replace(/\*|\:/g,""))).RepeatPasswordListener(TeG.Translations.ValidatePasswordNotMatch,$("#"+n+"CashierPassword").val()).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$("#"+n+"CashierConfirmPasswordLabel").html().replace(/\*|\:/g,""))).ErrorRenderDefault()})}}},sendAccountDetailsInputs:function(){$("#addCashierSendEmailCheckBox").on("click",function(){if($("#addCashierSendEmailCheckBox").is(":checked")){$("#addCashierSendEmail").on("blur",function(){$("#addCashierSendEmail").get(0).hasAttribute("disabled")||new TeG.Validator($("#addCashierSendEmail"),{cleanError:!0}).EmailIncorrectListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#lblForAddCashierSendEmailCheckBox").html().replace(/^s*|\*|\:|\s*$/g,""))).EmailUnsupportedCharsListener(TeG.Translations.ValidateInvalidFieldCheckAndTryAgain.replace(/%%field_label%%/,$("#lblForAddCashierSendEmailCheckBox").html().replace(/^s*|\*|\:|\s*$/g,""))).RequiredListener(TeG.Translations.ValidatePleaseInsertYourLabel.replace(/%%field_label%%/,$("#lblForAddCashierSendEmailCheckBox").html().replace(/^s*|\*|\:|\s*$/g,""))).ErrorRenderInHtml()});$("#addCashierSendEmail").removeAttr("disabled");$("#addCashierSendEmail").focus()}else $("#addCashierSendEmail").off(),$("#addCashierSendEmail").attr("disabled","disabled"),$('label[for="addCashierSendEmail"]').length&&$('label[for="addCashierSendEmail"]').html(""),$("#addCashierSendEmail").removeClass("error")});$("#addCashierSendSMSCheckBox").on("click",function(){if($("#addCashierSendSMSCheckBox").is(":checked")){$("#addCashierSendSMS").on("blur",function(){$("#addCashierSendSMS").get(0).hasAttribute("disabled")||new TeG.Validator($("#addCashierSendSMS")).MobileNumberIncorrectListener(TeG.Translations.ValidateInvalidMobileNumber).MobileNumberUnsupportedCharsListener(TeG.Translations.ValidateInvalidMobileNumber).RequiredListener(TeG.Translations.ValidateInsertMobileNumber).ErrorRenderSlideDown()});$("#addCashierSendSMS").removeAttr("disabled");$("#addCashierSendSMS").focus()}else $("#addCashierSendSMS").off(),$("#addCashierSendSMS").attr("disabled","disabled"),$('label[for="addCashierSendSMS"]').length&&$('label[for="addCashierSendSMS"]').remove(),$("#addCashierSendSMS").removeClass("error")})},modelToObservable:function(n){var t={};return $.each(n,function(n,i){t[n]=ko.observable(i)}),t},addLogin:function(n){var i,t;if($("#addRepresentative").find("input").blur(),new TeG.ValidateElement.passwordPairOnSubmit({jPass:$("#addCashierPassword"),jConf:$("#addCashierConfirmPassword"),renderType:TeG.ValidateElement.RENDER_DEFAULT}),(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#addRepresentative")))return!1;i=n;tegPopups.showDaisyWheelTotalHover();t=this;$.ajax({type:"POST",url:tegUrlHelper.addCashier,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify(i),error:function(n){tegPopups.closeTotalHover();tegErrorHandler.processError(n,"Error")},success:function(n){n=JSON.parse(n);tegPopups.totalHoverRemoveDaisyWheel();var i=TeG.Popups().addCashier();i.title=$("#memberType").html()=="Agent"?$("#popupAddCashierTitleHid").val():$("#popupAddRepresentativeTitleHid").val();i.phone=$("#addCashierSendSMSCheckBox").is(":checked")?$("#addCashierSendSMS").val():null;i.mail=$("#addCashierSendEmailCheckBox").is(":checked")?$("#addCashierSendEmail").val():null;i.login=n.LoginName;i.password=n.Password;i.OkButtonHandler=function(i){i.data.that.hide();t.backFromAddingLogin();tegPopups.closeTotalHover();$("#GlobalSearchEdit").val(n.LoginName);$("#cancelSearch").show();!$.browser.safari||TeG.isMobile()||TeG.isIPad()||$("#cancelSearch").css("left","170px");t.gridBehaivor.refresh()};i.show()}})},saveDetails:function(n){var t;if($("#accountDetailsTab").find("input").blur(),new TeG.ValidateElement.passwordPairOnSubmit({jPass:$("#detailCashierPassword"),jConf:$("#detailCashierConfirmPassword"),renderType:TeG.ValidateElement.RENDER_DEFAULT}),(new TeG.Validator).IsContainerHasDisplayedErrorMessage($("#accountDetailsTab")))return!1;tegPopups.showDaisyWheelTotalHover();t=this;n.permissionList=[{Name:"AllowImpersonateAsLogin",Value:Boolean(n.allowImpersonateAsLogin)}];var u={loginName:n.LoginName,firstName:n.FirstName,lastName:n.LastName,email:n.Email,mobilePhoneNumber:$.trim(n.MobilePhoneNumber)!=""?n.PhonePrefix.replace(/\+|\s/g,"")+$.trim(n.MobilePhoneNumber):"",password:$("#change-password-cb").is(":checked")?$("#detailCashierPassword").val():null,confirmationEmail:null,confirmationMobileNumber:null,permissionList:n.permissionList},r=$('div[data-role="grid"]').data("kendoGrid"),f=r.dataItem(r.select()).LoginName;$.ajax({type:"POST",url:tegUrlHelper.cashierDetailsUpdate,contentType:"application/json; charset=utf-8",dataType:"html",data:JSON.stringify(u),error:function(n){tegPopups.closeTotalHover();tegErrorHandler.processError(n,"Error")},success:function(){tegPopups.closeTotalHover();t.backFromDetails();r.bind("dataBound",function(){var t=$('div[data-role="grid"]').data("kendoGrid"),n=t.dataSource.data();for(i in n)n[i].LoginName==f&&t.select('tr[data-uid="{uid}"]'.replace("{uid}",n[i].uid))});t.gridBehaivor.refresh()}})},Passwords:function(){return{Show:function(){$.ajax({type:"POST",url:tegUrlHelper.representativesPasswordsList,contentType:"application/json; charset=utf-8",dataType:"html",error:function(n){tegErrorHandler.processError(n)},success:function(n){$("#representativesPasswords").html(n.replace(/(.*?\r?\n?)*?(\<.*)/,"$2"));$("#DivRepresentativesGrid").hide();$("#representativesPasswords").show();splitterResize()}})},BackToList:function(){$("#DivRepresentativesGrid").show();$("#representativesPasswords").hide()}}},widgetListener:{lockUnlock:{click:function(){this.source.url=tegUrlHelper.updateMemberStatus;this.source.data.loginName=this.source.representativeList.gridBehaivor.getSelectedRowData().LoginName;this.source.data.loginStatus=$(this.source.elem.find("span").get(1)).hasClass("lock")?"Lock":"Open"},successFlowEnd:function(){this.source.representativeList.gridBehaivor.clickRow();this.source.representativeList.gridBehaivor.clickRow();var n=$("tr.k-state-selected").prevAll().length;this.source.representativeList.gridBehaivor.grid.dataSource._data[n].StatusHtml=$("#status_"+this.source.accountNumber).html()}},deleteMember:{click:function(){this.source.url=tegUrlHelper.updateMemberStatus;this.source.memberName=$("#firstName_"+this.source.login).html()+" "+$("#lastName_"+this.source.login).html();this.source.data.loginName=this.source.representativeList.gridBehaivor.getSelectedRowData().LoginName;this.source.data.loginStatus="Removed";delete this.source.data.LoginName},successFlowEnd:function(){this.source.representativeList.gridBehaivor.refresh()}}}}};TeG.RepresentativeHO={List:function(){this.memberType="Representative";this.init=function(){this.widgetLockUnlockUrl=tegUrlHelper.updateMemberAccountStatus;this.widgetChangePasswordUrl=tegUrlHelper.membersChangeAgentPassword};this.nestedContentLoadConcrete=function(){$(".widgetButtonAgents").on("click",{that:this},function(n){var t=n.data.that;t.memberDetailsLoad(function(){t.agentsDetailsLoad.call(t);$("#memberDetailContent").html("");$(".js-detail .tabsBar>button").removeClass("selected");$("#memberDetailsAgentsDetailsTab").addClass("selected")})})}}};TeG.RepresentativeHO.List.prototype=TeG.RepresentativeParent.List;TeG.RepresentativeHO.List.prototype.constructor=TeG.RepresentativeHO.List;TeG.RepresentativeMA={List:function(){this.memberType="Representative";this.init=function(){this.widgetLockUnlockUrl=tegUrlHelper.updateMemberAccountStatus;this.widgetChangePasswordUrl=tegUrlHelper.membersChangeAgentPassword};this.nestedContentLoadConcrete=function(){$(".widgetButtonAgents").on("click",{that:this},function(n){var t=n.data.that;t.memberDetailsLoad(function(){t.agentsDetailsLoad.call(t);$("#memberDetailContent").html("");$(".js-detail .tabsBar>button").removeClass("selected");$("#memberDetailsAgentsDetailsTab").addClass("selected")})});$("body").trigger("NestedContentLoaded")}}};TeG.RepresentativeMA.List.prototype=TeG.RepresentativeParent.List;TeG.RepresentativeMA.List.prototype.constructor=TeG.RepresentativeMA.List;TeG.RepresentativeCA={List:function(){this.memberType="Representative";this.init=function(){this.widgetLockUnlockUrl=tegUrlHelper.updateMemberAccountStatus;this.widgetChangePasswordUrl=tegUrlHelper.membersChangeAgentPassword};this.nestedContentLoadConcrete=function(){$(".widgetButtonAgents").on("click",{that:this},function(n){var t=n.data.that;t.memberDetailsLoad(function(){t.agentsDetailsLoad.call(t);$("#memberDetailContent").html("");$(".js-detail .tabsBar>button").removeClass("selected");$("#memberDetailsAgentsDetailsTab").addClass("selected")})});$("body").trigger("NestedContentLoaded")}}};TeG.RepresentativeCA.List.prototype=TeG.RepresentativeParent.List;TeG.RepresentativeCA.List.prototype.constructor=TeG.RepresentativeCA.List;TeG.RepresentativePasswords={List:function(){this.memberType="Representative";this.init=function(){this.widgetLockUnlockUrl=tegUrlHelper.updateMemberAccountStatus;this.widgetChangePasswordUrl=tegUrlHelper.membersChangeAgentPassword};this.nestedContentLoadConcrete=function(){$(".widgetButtonAgents").on("click",{that:this},function(n){var t=n.data.that;t.memberDetailsLoad(function(){t.agentsDetailsLoad.call(t);$("#memberDetailContent").html("");$(".js-detail .tabsBar>button").removeClass("selected");$("#memberDetailsAgentsDetailsTab").addClass("selected")})});$("body").trigger("NestedContentLoaded")}}};TeG.RepresentativePasswords.List.prototype=TeG.RepresentativeParent.List;TeG.RepresentativePasswords.List.prototype.constructor=TeG.RepresentativePasswords.List