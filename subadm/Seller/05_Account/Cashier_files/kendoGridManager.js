var TeG=TeG||{},flag=!1;TeG.kendoGridManager=function(){var n={},t,i,r;if(TeG.isMobile()){if(n.StationsGrid=["AccountNo","NickName","BalanceHtml"],n.PlayersGrid=["AccountNo","FirstName","BalanceHtml"],n.RepresentativesGrid=["LoginName","FirstName","LastName"],n.MembersGrid=["FirstName","LastName","Balance"],n.ReferredMembersGrid=["FirstName","LastName","Balance",""],t=$('div[data-role="grid"]'),$(t).each(function(){var i=n[$(this).attr("id")],t=$(this).data("kendoGrid");t.pager.options.buttonCount=2;t.pager.refresh();i!=undefined&&$(t.columns).each(function(){$.inArray(this.field,i)==-1?t.hideColumn(this.field):t.showColumn(this.field)});n[$(this).attr("id")]!==undefined&&($(this).find("div.k-grid-header").addClass("t-grid-header"),$(this).find("div.k-grid-content").addClass("t-grid-content"))}),culture=="ru"){i='<li id="title" class="k-item k-state-default" role="menuitem"><span class="k-link">{0}<\/span><\/li><li id="separator" class="k-separator k-item k-state-default" role="menuitem"><\/li>';$(document).on(kendo.support.mouseup,'th[data-role="columnsorter"]:visible:first>a.k-header-column-menu',function(){setTimeout(function(){var n=String.format(i,$('th[data-role="columnsorter"]:visible:first').attr("data-title")),t=$(n);$(".k-animation-container:visible").css({width:90,left:0});$("li#title").remove();$("li#separator").remove();$('.k-animation-container:visible ul[data-role="menu"]').prepend(t)},350)});$(document).on(kendo.support.mouseup,'th[data-role="columnsorter"]:visible:eq(1)>a.k-header-column-menu',function(){setTimeout(function(){var n=String.format(i,$('th[data-role="columnsorter"]:visible:eq(1)').attr("data-title")),t=$(n);$(".k-animation-container:visible").css({width:90,left:0});$("li#title").remove();$("li#separator").remove();$('.k-animation-container:visible ul[data-role="menu"]').prepend(t)},350)});$(document).on(kendo.support.mouseup,'th[data-role="columnsorter"]:visible:eq(2)>a.k-header-column-menu',function(){setTimeout(function(){var n=String.format(i,$('th[data-role="columnsorter"]:visible:eq(2)').attr("data-title")),t=$(n);$(".k-animation-container:visible").css({width:90,left:0});$("li#title").remove();$("li#separator").remove();$('.k-animation-container:visible ul[data-role="menu"]').prepend(t)},350)})}else{$(document).on(kendo.support.mousedown,'th[data-role="columnsorter"]:visible:first>a.k-header-column-menu>span.k-icon.k-i-arrowhead-s',function(){setTimeout(function(){$(".k-animation-container").css({left:"0"})},200)});if($('th[scope="col"]:visible').length>3)$(document).on(kendo.support.mousedown,'th[data-role="columnsorter"]:visible:eq(1)>a.k-header-column-menu>span.k-icon.k-i-arrowhead-s',function(){setTimeout(function(){$(".k-animation-container").css({left:"0"})},200)})}$("#progressive-info-block").is(":visible")&&$("#progressive-info-block").css({display:"block"});$(document).bind("splitterResizeDone",function(){$("#mainSplitterDiv").width($(window).width());$("#mainSplitterDiv").height($(window).height());$("#MainSplitter").height($(window).height());$("#body-pane").css({height:"100%",overflow:"scroll",position:"relative"});$(".k-grid-content").css({height:"100%"})});$(document).trigger("splitterResizeDone")}TeG.isIPad()&&(t=$('div[data-role="grid"]'),$(t).each(function(){var n=$(this).data("kendoGrid");n.pager.options.buttonCount=4;n.pager.refresh()}));r=$('div[data-role="grid"]').data("kendoGrid");TeG.isMobile()||(t=$('div[data-role="grid"]'),$(t).each(function(){var n=$(this).data("kendoGrid");$(n.element).find("[data-role=tooltip]").length>0&&$(n.element).find("[data-role=tooltip]").data("kendoTooltip")&&$(n.element).find("[data-role=tooltip]").data("kendoTooltip").destroy();n.thead.kendoTooltip({filter:"th[data-field][data-title!=''][data-role!='droptarget']",content:function(n){var t=n.target;return $(t).text()}});n.headerTooltipsInitiated=!0}));$('[data-title=""][data-field=""]').children().remove();collapseMenuOnScroll()}