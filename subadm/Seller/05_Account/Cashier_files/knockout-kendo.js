!function(n){"function"==typeof require&&"object"==typeof exports&&"object"==typeof module?n(require("knockout"),require("jquery"),require("kendo")):"function"==typeof define&&define.amd?define(["knockout","jquery","kendo"],n):n(window.ko,window.jQuery,window.kendo)}(function(n,t,i,r){var h,b,tt;i=i||window.kendo;n.kendo=n.kendo||{};h=n.utils.unwrapObservable;n.kendo.BindingFactory=function(){var u=this,f;this.createBinding=function(r){if(t()[r.parent||r.name]){var f={};f.init=function(n,t,i,e,o){var s=u.buildOptions(r,t);return s.async===!0||r.async===!0&&s.async!==!1?(setTimeout(function(){f.setup(n,s,o)},0),void 0):(f.setup(n,s,o),s&&s.useKOTemplates?{controlsDescendantBindings:!0}:void 0)};f.setup=function(f,e,o){var s,h=t(f);u.setupTemplates(r.templates,e,f,o);s=u.getWidget(r,e,h);u.handleEvents(e,r,f,s,o);u.watchValues(s,e,r,f);s.destroy&&n.utils.domNodeDisposal.addDisposeCallback(f,function(){s.element&&("function"==typeof i.destroy?i.destroy(s.element):s.destroy())})};f.options={};f.widgetConfig=r;n.bindingHandlers[r.bindingName||r.name]=f}};this.buildOptions=function(t,r){var f=t.defaultOption,e=n.utils.extend({},n.bindingHandlers[t.name].options),u=h(r());return u instanceof i.data.DataSource||"object"!=typeof u||null===u||f&&!(f in u)?e[f]=r():n.utils.extend(e,u),e};f=function(t,i){return function(r){return n.renderTemplate(t,i.createChildContext(r._raw&&r._raw()||r))}};this.setupTemplates=function(t,i,r,u){var e,h,o,s;if(t&&i&&i.useKOTemplates){for(e=0,h=t.length;h>e;e++)o=t[e],i[o]&&(i[o]=f(i[o],u));s=i.dataBound;i.dataBound=function(){n.memoization.unmemoizeDomNodeAndDescendants(r);s&&s.apply(this,arguments)}}};this.unwrapOneLevel=function(n){var t,r={};if(n)if(n instanceof i.data.DataSource)r=n;else if("object"==typeof n)for(t in n)r[t]=h(n[t]);return r};this.getWidget=function(t,i,r){var u,f;return t.parent?(f=r.closest("[data-bind*='"+t.parent+":']"),u=f.length?f.data(t.parent):null):u=r[t.name](this.unwrapOneLevel(i)).data(t.name),n.isObservable(i.widget)&&i.widget(u),u};this.watchValues=function(n,t,i,r){var f,e=i.watch;if(e)for(f in e)e.hasOwnProperty(f)&&u.watchOneValue(f,n,t,i,r)};this.watchOneValue=function(i,u,f,e,o){var s=n.computed({read:function(){var a,l,n=e.watch[i],s=h(f[i]),c=e.parent?[o]:[];t.isArray(n)?n=u[s?n[0]:n[1]]:"string"==typeof n?n=u[n]:l=!0;n&&f[i]!==r&&(l?c.push(s,f):(a=n.apply(u,c),c.push(s)),(l||a!==s)&&n.apply(u,c))},disposeWhenNodeIsRemoved:o}).extend({throttle:f.throttle||0===f.throttle?f.throttle:1});n.isObservable(f[i])||s.dispose()};this.handleEvents=function(n,t,i,r,f){var o,e,s=t.events;if(s)for(o in s)s.hasOwnProperty(o)&&(e=s[o],"string"==typeof e&&(e={value:e,writeTo:e}),u.handleOneEvent(o,e,n,i,r,t.childProp,f))};this.handleOneEvent=function(t,i,r,u,f,e,o){var s="function"==typeof i?i:r[i.call];"function"==typeof i?s=s.bind(o.$data,r):i.call&&"function"==typeof r[i.call]?s=r[i.call].bind(o.$data,o.$data):i.writeTo&&n.isWriteableObservable(r[i.writeTo])&&(s=function(n){var t,f;e&&n[e]&&n[e]!==u||(t=i.value,f="string"==typeof t&&this[t]?this[t](e&&u):t,r[i.writeTo](f))});s&&f.bind(t,s)}};n.kendo.bindingFactory=new n.kendo.BindingFactory;n.kendo.setDataSource=function(t,r,u){var f,e;return r instanceof i.data.DataSource?(t.setDataSource(r),void 0):(u&&u.useKOTemplates||(f=n.mapping&&r&&r.__ko_mapping__,e=r&&f?n.mapping.toJS(r):n.toJS(r)),t.dataSource.data(e||r),void 0)},function(){var n=i.data.ObservableArray.fn.wrap;i.data.ObservableArray.fn.wrap=function(t){var i=n.apply(this,arguments);return i._raw=function(){return t},i}}();var l=function(t){return function(i){i&&(n.utils.extend(this.options[t],i),this.redraw(),this.value(.001+this.value()))}},k=function(n,i){n?this.open("string"==typeof i.target?t(h(i.target)):i.target):this.element.parent().is(":visible")&&this.close()},u=n.kendo.bindingFactory.createBinding.bind(n.kendo.bindingFactory),y="clicked",s="close",d="collapse",a="data",e="enable",g="expand",v="expanded",ot="error",st="info",o="isOpen",p="max",w="min",c="open",it="search",rt="select",ut="selected",ft="size",ht="success",et="title",f="value",nt="values",ct="warning";u({name:"kendoAutoComplete",events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,search:[it,s],data:function(t){n.kendo.setDataSource(this,t)},value:f}});u({name:"kendoButton",defaultOption:y,events:{click:{call:y}},watch:{enabled:e}});u({name:"kendoCalendar",defaultOption:f,events:{change:f},watch:{max:p,min:w,value:f}});u({name:"kendoColorPicker",events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,value:f,color:f,palette:"palette"}});u({name:"kendoComboBox",events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,isOpen:[c,s],data:function(t){n.kendo.setDataSource(this,t)},value:f}});u({name:"kendoDatePicker",defaultOption:f,events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,max:p,min:w,value:f,isOpen:[c,s]}});u({name:"kendoDateTimePicker",defaultOption:f,events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,max:p,min:w,value:f,isOpen:[c,s]}});u({name:"kendoDropDownList",events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,isOpen:[c,s],data:function(t){n.kendo.setDataSource(this,t);t.length&&this.options.optionLabel&&this.select()<0&&this.select(0)},value:f}});u({name:"kendoEditor",defaultOption:f,events:{change:f},watch:{enabled:e,value:f}});u({name:"kendoGantt",defaultOption:a,watch:{data:function(t){n.kendo.setDataSource(this,t)}}});u({name:"kendoGrid",defaultOption:a,watch:{data:function(t,i){n.kendo.setDataSource(this,t,i)}},templates:["rowTemplate","altRowTemplate"]});u({name:"kendoListView",defaultOption:a,watch:{data:function(t,i){n.kendo.setDataSource(this,t,i)}},templates:["template"]});u({name:"kendoPager",defaultOption:a,watch:{data:function(t,i){n.kendo.setDataSource(this,t,i)},page:"page"},templates:["selectTemplate","linkTemplate"]});u({name:"kendoMaskedTextBox",defaultOption:f,events:{change:f},watch:{enabled:e,isReadOnly:"readonly",value:f}});u({name:"kendoMap",events:{zoomEnd:function(t,i){n.isWriteableObservable(t.zoom)&&t.zoom(i.sender.zoom())},panEnd:function(t,i){var r;n.isWriteableObservable(t.center)&&(r=i.sender.center(),t.center([r.lat,r.lng]))}},watch:{center:"center",zoom:"zoom"}});u({name:"kendoMenu",async:!0});u({name:"kendoMenuItem",parent:"kendoMenu",watch:{enabled:e,isOpen:[c,s]},async:!0});u({name:"kendoMobileActionSheet",events:{open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{isOpen:k},async:!0});u({name:"kendoMobileButton",defaultOption:y,events:{click:{call:y}},watch:{enabled:e}});u({name:"kendoMobileButtonGroup",events:{select:function(t,i){n.isWriteableObservable(t.selectedIndex)&&t.selectedIndex(i.sender.current().index())}},watch:{enabled:e,selectedIndex:rt}});u({name:"kendoMobileDrawer",events:{show:{writeTo:o,value:!0},hide:{writeTo:o,value:!1}},watch:{isOpen:function(n){this[n?"show":"hide"]()}},async:!0});u({name:"kendoMobileListView",defaultOption:a,events:{click:{call:y}},watch:{data:function(t,i){n.kendo.setDataSource(this,t,i)}},templates:["template"]});u({name:"kendoMobileModalView",events:{open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{isOpen:k},async:!0});u({name:"kendoMobileNavBar",watch:{title:et}});u({name:"kendoMobilePopOver",events:{open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{isOpen:k},async:!0});u({name:"kendoMobileScroller",events:{pull:function(n,t){var i=t.sender.pullHandled.bind(t.sender);"function"==typeof n.pulled&&n.pulled.call(this,this,t,i)}},watch:{enabled:[e,"disable"]}});u({name:"kendoMobileScrollView",events:{change:function(t,i){(i.page||0===i.page)&&n.isWriteableObservable(t.currentIndex)&&t.currentIndex(i.page)}},watch:{currentIndex:"scrollTo",data:function(t){n.kendo.setDataSource(this,t)}}});u({name:"kendoMobileSwitch",events:{change:function(t,i){n.isWriteableObservable(t.checked)&&t.checked(i.checked)}},watch:{enabled:e,checked:"check"}});u({name:"kendoMobileTabStrip",events:{select:function(t,i){n.isWriteableObservable(t.selectedIndex)&&t.selectedIndex(i.item.index())}},watch:{selectedIndex:function(n){(n||0===n)&&this.switchTo(n)}}});u({name:"kendoMultiSelect",events:{change:f,open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{enabled:e,search:[it,s],data:function(t){n.kendo.setDataSource(this,t)},value:function(n){this.dataSource.filter({});this.value(n)}}});b=function(n,t){t||0===t?this.show(t,n):this.hide()};u({name:"kendoNotification",watch:{error:function(n){b.call(this,ot,n)},info:function(n){b.call(this,st,n)},success:function(n){b.call(this,ht,n)},warning:function(n){b.call(this,ct,n)}}});u({name:"kendoNumericTextBox",defaultOption:f,events:{change:f,spin:f},watch:{enabled:e,value:f,max:function(n){this.options.max=n;var t=this.value();(t||0===t)&&t>n&&this.value(n)},min:function(n){this.options.min=n;var t=this.value();(t||0===t)&&n>t&&this.value(n)}}});u({name:"kendoPanelBar",async:!0});u({name:"kendoPanelItem",parent:"kendoPanelBar",watch:{enabled:e,expanded:[g,d],selected:[rt]},childProp:"item",events:{expand:{writeTo:v,value:!0},collapse:{writeTo:v,value:!1},select:{writeTo:ut,value:f}},async:!0});u({name:"kendoPivotGrid",watch:{data:function(t){n.kendo.setDataSource(this,t)}}});u({name:"kendoProgressBar",defaultOption:f,events:{change:f},watch:{enabled:e,value:f}});u({name:"kendoRangeSlider",defaultOption:nt,events:{change:nt},watch:{values:nt,enabled:e}});tt=function(t){return function(i,r){var e=h(i.data||i.dataSource),f=h(i.idField)||"id",u=n.utils.arrayFirst(e,function(n){return h(n[f])===r.event[f]}),o=function(t){var i,f,r;for(i in u)t.hasOwnProperty(i)&&u.hasOwnProperty(i)&&(f=t[i],r=u[i],n.isWriteableObservable(r)&&r(f))};u&&t(i,r,u,o)}};u({name:"kendoScheduler",events:{moveEnd:tt(function(n,t,i,r){r(t);r(t.resources)}),save:tt(function(n,t,i,r){r(t.event)}),remove:function(t,i){var u,r=t.data||t.dataSource,f=n.unwrap(r);f&&f.length&&(u=n.utils.arrayFirst(n.unwrap(r),function(n){return n.uuid===i.event.uuid}),u&&(n.utils.arrayRemoveItem(f,u),n.isWriteableObservable(r)&&r.valueHasMutated()))}},watch:{data:function(t,i){n.kendo.setDataSource(this,t,i)},date:"date"},async:!0});u({name:"kendoSlider",defaultOption:f,events:{change:f},watch:{value:f,enabled:e}});u({name:"kendoSortable",defaultOption:a,events:{end:function(t,i){var r="__ko_kendo_sortable_data__",u="receive"!==i.action?n.dataFor(i.item[0]):i.draggableEvent[r],e=t.data,f=t.data;("sort"===i.action||"remove"===i.action)&&(f.splice(i.oldIndex,1),"remove"===i.action&&(i.draggableEvent[r]=u));("sort"===i.action||"receive"===i.action)&&(f.splice(i.newIndex,0,u),delete i.draggableEvent[r],i.sender.placeholder.remove());e.valueHasMutated()}}});u({name:"kendoSplitter",async:!0});u({name:"kendoSplitterPane",parent:"kendoSplitter",watch:{max:p,min:w,size:ft,expanded:[g,d]},childProp:"pane",events:{collapse:{writeTo:v,value:!1},expand:{writeTo:v,value:!0},resize:ft},async:!0});u({name:"kendoTabStrip",async:!0});u({name:"kendoTab",parent:"kendoTabStrip",watch:{enabled:e},childProp:"item",async:!0});u({name:"kendoToolBar"});u({name:"kendoTooltip",events:{},watch:{content:function(n){this.options.content=n;this.refresh()},filter:"filter"}});u({name:"kendoTimePicker",defaultOption:f,events:{change:f},watch:{max:p,min:w,value:f,enabled:e,isOpen:[c,s]}});u({name:"kendoTreeMap",watch:{data:function(t){n.kendo.setDataSource(this,t)}}});u({name:"kendoTreeView",watch:{data:function(t,i){n.kendo.setDataSource(this,t,i)}},events:{change:function(t,i){if(n.isWriteableObservable(t.value)){var r=i.sender;t.value(r.dataItem(r.select()))}}},async:!0});u({name:"kendoTreeItem",parent:"kendoTreeView",watch:{enabled:e,expanded:[g,d],selected:function(n,t){t?this.select(n):this.select()[0]==n&&this.select(null)}},childProp:"node",events:{collapse:{writeTo:v,value:!1},expand:{writeTo:v,value:!0},select:{writeTo:ut,value:!0}},async:!0});u({name:"kendoUpload",watch:{enabled:e}});u({name:"kendoWindow",events:{open:{writeTo:o,value:!0},close:{writeTo:o,value:!1}},watch:{content:"content",title:et,isOpen:[c,s]},async:!0});u({name:"kendoBarcode",watch:{value:f}});u({name:"kendoChart",watch:{data:function(t){n.kendo.setDataSource(this,t)}}});u({name:"kendoLinearGauge",defaultOption:f,watch:{value:f,gaugeArea:l("gaugeArea"),pointer:l("pointer"),scale:l("scale")}});u({name:"kendoQRCode",watch:{value:f}});u({name:"kendoRadialGauge",defaultOption:f,watch:{value:f,gaugeArea:l("gaugeArea"),pointer:l("pointer"),scale:l("scale")}});u({name:"kendoSparkline",watch:{data:function(t){n.kendo.setDataSource(this,t)}}});u({name:"kendoStockChart",watch:{data:function(t){n.kendo.setDataSource(this,t)}}})})