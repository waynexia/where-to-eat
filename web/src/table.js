// generate table by using resource json
function generate_table(site){
    var map = document.getElementById("map");
    // init
    clear_table(map);
    store_clear_all();

    var length = site["length"];
    var width = site["width"];
    var id = 0;
    for(var i=0;i<length;i++){
        var row = map.insertRow(i);
        var top_pointer = 0;
        for(var j=0;j<width;j++){
            if(site["detail"][i][j] === undefined){
                break;
            }
            var cell = row.insertCell(top_pointer);
            // use "endline" to avoid lots of nulllllllll
            /*if(site["detail"][i][j].endline != undefined){
                if (site["detail"][i][j].endline === true){
                    for(;j<width;j++){
                        var cell = row.insertCell(j);
                        cell.innerHTML = "<div class='empty'></div>";
                    }
                    continue;
                }
            }*/
            if(site["detail"][i][j].endline != undefined){
                j = width;
                continue;
            }

            if(site["detail"][i][j].name === null){
                // use width
                if(site["detail"][i][j].width != undefined){
                    skip_width = site["detail"][i][j].width
                    for(var k = 0;k<skip_width;k++){
                        row.insertCell(top_pointer).innerHTML = "<div class='empty'></div>";
                        ++top_pointer;
                    }
                    --top_pointer;
                }
                else{
                    cell.innerHTML = "<div class='empty'></div>";
                }
            }
            else{
                // use width
                if(site["detail"][i][j].width != undefined){
                    skip_width = site["detail"][i][j].width;
                    add_tag(site["detail"][i][j].tag);
                    stores.push(Store.creatNew(id, site["detail"][i][j].tag, site["detail"][i][j].desc))
                    for(var k = 0;k<skip_width;k++){
                        cell = row.insertCell(top_pointer);
                        cell.innerHTML = "<div class='not_empty' id=" +id+ ">" + site["detail"][i][j].name + "</div>";
                        //row.insertCell(top_pointer).innerHTML = "<div class='empty'></div>";
                        ++top_pointer;
                    }
                    ++id;
                    --top_pointer;
                }
                else{
                    cell.innerHTML = "<div class='not_empty' id=" +id+ ">" + site["detail"][i][j].name + "</div>";
                    add_tag(site["detail"][i][j].tag);
                    stores.push(Store.creatNew(id, site["detail"][i][j].tag, site["detail"][i][j].desc))
                    selectable.push(id);    
                    ++id;
                }
                
            }
            ++top_pointer;
        }
    }
}

function clear_table(map){
    //twice for clear all(once sometimes will cause error)
    for(var i=0;i<map.rows.length;i++){
        map.deleteRow(0);
    }
    for(var i=0;i<map.rows.length;i++){
        map.deleteRow(0);
    }
}

function insert_selection(site_name){
    var site_selector = document.getElementById("select_site");
    var option = document.createElement("option");
    option.text = site_name.display_name;
    option.value = site_name.file_name;
    site_selector.add(option);
}

function roll_start(){
    var times = Math.floor((Math.random() * 10) + 50);
    var highlighted = 0;
    var handle = setInterval(function(){
        lowlight(highlighted);
        highlighted = Math.floor(Math.random() * (selectable.length + 1));
        highlight(highlighted);
    },100);
    setTimeout(function(){
        clearInterval(handle);
    },times * 100);
}

function lowlight(id){
    grid = document.getElementById(id);
    if(grid != null){
        grid.style = "background-color : whitesmoke";
    }
}

function highlight(id){
    grid = document.getElementById(id);
    if(grid != null){
        grid.style = "background-color : #99ff66"
    }
}