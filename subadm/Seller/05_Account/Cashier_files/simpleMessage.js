var TeG=TeG||{};TeG.SimpleMessage=function(){return{Show:function(){localStorage.getItem(TeG.SimpleMessage().getKey())?localStorage.getItem(TeG.SimpleMessage().getKey())!="null"&&($("#simpleMessageText").text(localStorage.getItem(TeG.SimpleMessage().getKey())),$("#simpleMessage").slideDown("slow",function(){splitterResize()})):$.ajax({type:"POST",url:tegUrlHelper.getSystemMessage,success:function(n){if($.trim(n.Message)==""){localStorage.setItem(TeG.SimpleMessage().getKey(),"null");return}localStorage.setItem(TeG.SimpleMessage().getKey(),n.Message);$("#simpleMessageText").text(n.Message);$("#simpleMessage").slideDown("slow",function(){splitterResize()})}});$("#simpleMessageClose").on("click",{that:this},function(n){n.data.that.Close()})},Close:function(){splitterResize();localStorage.setItem(TeG.SimpleMessage().getKey(),"null");$("#simpleMessage").slideUp("slow",function(){splitterResize()})},getKey:function(){return culture+"_systemMessage"}}}