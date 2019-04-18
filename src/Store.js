var selectable = new Array();
var tags = new Array();
var stores = new Array();

// class store
var Store = {
    creatNew : function(id,tag,desc){
        var store = {};
        store.id = id;
        store.tag = tag;
        store.desc = desc;
        store.has_tag = function(single_tag){
            for(let i in tag){
                if(i === single_tag){
                    return true;
                }
            }
            return false;
        }
        return store;      
    },
}

// add unique tag into tags
function add_tag(tag){
    for(let i in tag){
        if(function(i){
            for(let j of tags){
                if(j === i){
                    return false;
                }
            }
            return true;
        }){
            tags.push(i);
        }
    }
}