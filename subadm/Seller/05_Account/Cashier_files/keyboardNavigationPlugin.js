(function(n){function u(u,s){if(u.which&&!n(".popupHover").is(":visible"))switch(u.which){case kendo.keys.PAGEUP:s.pager.page()!=1&&s.pager.page(s.pager.page()-1);break;case kendo.keys.PAGEDOWN:s.pager.page()<s.pager.totalPages()&&s.pager.page(s.pager.page()+1);break;case kendo.keys.UP:(n(".k-dropdown").is(":focus")&&n(".k-dropdown").attr("aria-expanded")=="false"||!n(".k-dropdown").is(":focus"))&&s.select().prev().length!=0&&(s.collapseRow(s.select()),s.select(e(s)),s.dataItem(s.select()).ChangeReceipt&&s.dataItem(s.select()).ChangeReceipt%2!=0&&n("button#change").click(),r(s,50));break;case kendo.keys.DOWN:(n(".k-dropdown").is(":focus")&&n(".k-dropdown").attr("aria-expanded")=="false"||!n(".k-dropdown").is(":focus"))&&s.select().next().length!=0&&(s.collapseRow(s.select()),s.select(o(s)),r(s,50));break;case 1:t(s.select())?n(u.srcElement).is(n("button#change"))||s.collapseRow(s.select()):(s.collapseRow(s.items()),n("tr.k-detail-row").remove(),n(s.select()).css({cursor:"wait"}),s.expandRow(s.select()),n(s.select()).css({cursor:"pointer"}),i(s),f(s));break;case kendo.keys.ENTER:case kendo.keys.RIGHT:t(s.select())&&n(":focus").length!=0?n(":focus").attr("id")&&n(":focus").attr("id").indexOf("DepositInput")!=-1&&n(":focus").val()!=""?n("button#depositBtn_"+s.dataItem(s.select()).AccountNo).click():n(":focus").attr("id")&&n(":focus").attr("id").indexOf("WithDrawalInput")!=-1&&n(":focus").val()!=""?n("button#withdrawalBtn_"+s.dataItem(s.select()).AccountNo).click():n(":focus").attr("id")&&n(":focus").attr("id").indexOf("updateBalanceInput")!=-1&&n(":focus").val()!=""&&n("button#updateBalanceBtn_"+s.dataItem(s.select()).LoginName).click():(n("#GlobalSearchEdit").is(":focus")?n("#GlobalSearchEdit").blur():t(s.select())?n(u.srcElement).is(n("btn#change")):(n("tr.k-detail-row").remove(),n(s.select()).css({cursor:"wait"}),s.expandRow(s.select()),n(s.select()).css({cursor:"pointer"}),i(s)),f(s));u.target.type=="checkbox"&&n(u.target).prop("checked",!0);break;case kendo.keys.ESC:case kendo.keys.LEFT:if(u.target.type=="checkbox"&&n(u.target).prop("checked")==!0){n(u.target).prop("checked",!1);return}n(".nestedBlockChange").hasClass("collapse")?n("button#change").click():s.collapseRow(s.select());break;case kendo.keys.TAB:if(n(":focus").hasClass("tab-last")&&n(":focus").hasClass("tab-first"))u.preventDefault();else if(u.shiftKey){if(n(":focus").hasClass("tab-first"))n(":focus").one("blur",function(){n(".tab-last").focus()})}else if(n(":focus").hasClass("tab-last"))n(":focus").one("blur",function(){n(".tab-first").focus()})}}function e(t){for(var r=t.select().prevAll(),i=0;i<r.length;i++)if(n(r[i]).attr("role")=="row")return n(r[i])}function o(t){for(var r=t.select().nextAll(),i=0;i<r.length;i++)if(n(r[i]).attr("role")=="row")return n(r[i])}function t(n){return n?n.next()&&n.next().hasClass("k-detail-row")&&n.next().is(":visible")?!0:!1:!1}function i(t){t.select().next().removeClass("tab-last");t.select().next().removeClass("tab-first");t.select().next().find("button:not(.disabled):visible, input:not(.disabled):visible").last().addClass("tab-last");t.select().next().find("button:not(.disabled):visible, input:not(.disabled):visible").each(function(){if(n(this).parents(".disabled").length==0)return n(this).focus(),!1});n(":focus").addClass("tab-first")}function r(t,i){var r=n(document).find(".k-grid-content").find("tbody").offset().top,u=t.select().offset().top,f=u-r;n(document).find(".k-grid-content").animate({scrollTop:f},i)}function f(n){TeG.isIPad()||setTimeout(function(){r(n,1e3)},1e3)}return n.fn.keyboardNavigationInit=function(t){n(document).unbind("keydown").bind("keydown",function(n){u(n,t)});t.items().unbind("click").bind("click",function(n){u(n,t)});n(document).on("NestedContentLoaded DepositSendDone WithdrawalSendDone UpdateBalanceDone","body",function(){i(t)});n(".k-dropdown").is(":focus")&&n(".k-dropdown").blur();n("button#change").bind("click",function(){nestedBlockScripts.ChangeReceipt(this)})},n.fn.keyboardNavigation=function(t){var t=n.extend(n.fn.keyboardNavigation.defaults,t),i=n(t.divSelector).data().kendoGrid;n(t.divSelector).is(":visible")&&i.select(i.items().first());i.items().length==1&&(i.dataItem(i.select())&&n(i.dataItem(i.select()).BalanceHtml).html()=='<img src="/Images/balance-ajax-loader.gif">'?n(i.select()).bind("DOMSubtreeModified",function(t){n(t.target).attr("id")=="balanceDiv_"+i.dataItem(i.select()).AccountNo&&(i.expandRow(i.select()),n(i.select()).unbind("DOMSubtreeModified"))}):i.expandRow(i.select()));n.fn.keyboardNavigationInit(i)},n.fn.keyboardNavigation.defaults={divSelector:'div[data-role="grid"]',pagerSelector:'div[data-role="pager"]',pagerLeftArrowSelector:"span.k-i-arrow-w",pagerRightArrowSelector:"span.k-i-arrow-e",gridSelectedRowSelector:"tr.k-state-selected"},this})(jQuery)