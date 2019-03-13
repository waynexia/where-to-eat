var example = {
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

site = example;
function generate_table(){
    var map = document.getElementById("map");
    var length = site["length"];
    var width = site["width"];
    for(var i=0;i<length;i++){
        var row = map.insertRow(i);
        for(var j=0;j<width;j++){
            var cell = row.insertCell(j);
            if(site["detail"][i][j].name === null){
                cell.innerHTML = "nullll";
            }
            else{
                cell.innerHTML = site["detail"][i][j].name;
            }
        }
    }
}