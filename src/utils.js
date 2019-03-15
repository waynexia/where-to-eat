/*var example = {
    "width": 4,
    "length": 3,
    "detail":[
        [
            {
                "name": "A",
                "desc": ["辣"]
            },
            {
                "name": null
            },
            {
                "name": "F",
                "desc": []
            },
            {
                "name": null
            }
        ],
        [
            {
                "name": "B",
                "desc": []
            },
            {
                "name": "D",
                "desc": []
            },
            {
                "name": "E",
                "desc": ["大排档","油"]
            },
            {
                "name": "G",
                "desc": []
            }
        ],
        [
            {
                "name": "C",
                "desc": []
            },
            {
                "name": null
            },
            {
                "name": null
            },
            {
                "name": null
            }
        ]

    ]
}

site = example;*/

var selectable = 0;
function generate_table(){
    var map = document.getElementById("map");
    clear_table(map);
    var length = site["length"];
    var width = site["width"];
    var id = 0;
    for(var i=0;i<length;i++){
        var row = map.insertRow(i);
        for(var j=0;j<width;j++){
            var cell = row.insertCell(j);
            if(site["detail"][i][j].name === null){
                cell.innerHTML = "<div class='empty'></div>";
                
            }
            else{
                cell.innerHTML = "<div class='not_empty' id=" +id+ ">" + site["detail"][i][j].name + "</div>";
                ++id;
            }
        }
    }
    selectable = id;
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
    option.text = site_name;
    option.value = site_name;
    site_selector.add(option);
}

function roll_start(){
    var times = Math.floor((Math.random() * 10) + 50);
    var highlighted = 0;
    var handle = setInterval(function(){
        lowlight(highlighted);
        highlighted = Math.floor(Math.random() * (selectable+1));
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