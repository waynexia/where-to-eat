resourse_site_path = "./resourse/site/"

function load_catalog(catalog){
    catalog.forEach(function(item,index) {
        insert_selection(item);
    });
}

function load_site(site){
    generate_table(site);
}

function jsonp_manager(){
    var new_js = null;
    return function(src){
        if(new_js != null){
            document.body.removeChild(new_js);
        }
        new_js = document.createElement("script");
        new_js.src = src;
        document.body.appendChild(new_js);
    }
}

var a_handle_about_upper_code = null;
function to_generate_map(site_name){
    var postfix = ".json?callback=load_catalog";
    if(a_handle_about_upper_code == null){
        a_handle_about_upper_code = jsonp_manager();
    }
    if(site_name != "null"){
        a_handle_about_upper_code(resourse_site_path + site_name + postfix);
    }
}