resourse_site_path = "./resourse/site/"

function load_catalog(catalog){
    //insert_js_file(resourse_site_path + "catalog.js");
    //while(typeof catalog === 'undefined'){};
    catalog.forEach(function(item,index) {
        console.log(typeof item);
        insert_selection(item);
    });
}

function insert_js_file(path){
    var new_js = document.createElement("script");
    new_js.type = "text/javascript";
    new_js.src = path;
    document.body.appendChild(new_js);
}