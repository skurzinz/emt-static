/* function trigger when static html img was loaded */

function loadImage(container_id) {

    /* get container holding the image and set height and padding */
    var container = document.getElementById(container_id);
    container.style.height = "700px";
    container.style.padding ="2em";

    /* get image src (url) */
    var image = document.getElementById(`${container_id}-img`);
    var imageURL = {
        type: 'image',
        url: image.getAttribute("src")
    };

    // OpenSeaDragon Image Viewer
    var viewer = OpenSeadragon({
        id: container_id,
        prefixUrl: "https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.0.0/images/",
        defaultZoomLevel: 0,
        fitHorizontally: true,
        tileSources: imageURL,
        degrees: 0, // Initial rotation angle
        showRotationControl: true, // Show rotation buttons
        gestureSettingsTouch: {
            pinchRotate: true // Enable touch rotation on tactile devices
        }
    });
    /* remove static html image element */
    image.remove();
}


/* 
    set timeout to wait till osd viewer was loaded
    createOverlays is a click event that creates point coords 
    based one linenumber zones.
    Depending on wheter the linenubmers link was already clicked
    the class active stores the state (maybe re-write to urlparam)
*/
setTimeout(createOverlays, 1000);

function createOverlays() {

    /* attach click event on linenumbers */
    var linenumbers = document.getElementsByClassName("linenumbers");
    [].forEach.call(linenumbers, function(opt) {
        opt.addEventListener("click", function(event) {
            event.preventDefault();

            /* 
                since more than one viewer is open get a viewer id
                and open relevant viewer
            */
            var opt_id = opt.getAttribute("id").replace("#", "");
            var viewerID = `${opt_id.split("_")[0]}_${opt_id.split("_")[1]}`;
            var viewerID = viewerID.replace("facs_", "os-id-");
            var openViewer = OpenSeadragon.getViewer(viewerID);

            /*
                size attribute contains the width,height of facsimile
            */
            var wh = opt.getAttribute("size").split(",");

             /* 
                create overlays array based on clicked linenumbers
                attribute zone
            */
            var overlays = [];
            var zone = opt.getAttribute("zone");
            
            if (zone !== null) {

                /* 
                    create list split by whitespace and
                    pair every two elements
                 */
                var xys = zone.split(" ");
                for (let i of xys) {
                    var xy = i.split(",");
                    var id = `${opt_id}_${xy[0]}_${xy[1]}`;
                    overlays.push(
                        {
                            id: id,
                            x: parseInt(xy[0]),
                            y: parseInt(xy[1]),
                            className: 'overlay'
                        }
                    )
                }
            }

            /* 
                check if linenumbers is active or not
                if active: remove class and remove overlays
                else: add class and add overlays
            */
            if (opt.classList.contains("active")) {

                /* remove active state from linenumbers click event */
                opt.classList.remove("active");

                /* remove overlay div's */
                for (let el of overlays) {
                    var el_id = el.id;
                    
                    openViewer.removeOverlay(el_id);
                }

            } else {

                /* add active state for linenumbers click event */
                opt.classList.add("active");

                /* create overlay, turn pixel to viewport and add overlays */
                for (let el of overlays) {

                    /* get lrx and lry from overlays list */
                    let lowerRightX = el.x;
                    let lowerRightY = el.y;

                    /* create div element as overlay */
                    let overlayElement = document.createElement("div");
                    let idOfOverlay = document.createAttribute("id");
                    let classOfOverlay = document.createAttribute("class");
                    idOfOverlay.value = el.id;
                    classOfOverlay.value = el.className;
                    overlayElement.setAttributeNode(idOfOverlay);
                    overlayElement.setAttributeNode(classOfOverlay);

                    /* parse xry and xrx as integer and convert to viewport coords */
                    let widthOfPicture = parseInt(wh[0]);
                    let heightOfPicture = parseInt(wh[1]);
                    let lowerRightXScaled = lowerRightX / widthOfPicture;
                    let lowerRightYScaled = lowerRightY / heightOfPicture * heightOfPicture/widthOfPicture;

                    /* add div el on pointLayer coords */
                    openViewer.addOverlay(overlayElement, 
                                          new OpenSeadragon.Point(
                                                                  lowerRightXScaled, 
                                                                  lowerRightYScaled));
                }
            }
        });
    });
}