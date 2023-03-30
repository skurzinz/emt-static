/* function trigger when static html image was loaded */

function loadImage(container_id, lbs) {
    // get container holding the image and set height and padding
    var container = document.getElementById(container_id);
    container.style.height = "700px";
    container.style.padding ="2em";

    var lb = container_id.replace("os-id-", "facs_");
    var lb = document.querySelector(`p[data-id^="#${lb}"]`);
    var overlays = [];
    for (let child of lb.children) {
        if (child.tagName == "A") {
            var zone = child.getAttribute("zone");
            var child_id = child.getAttribute("id");
            
            if (zone !== null) {
                var xys = zone.split(" ");
                for (let i of xys) {
                    var xy = i.split(",");
                    var id = `${child_id}_${xy[0]}_${xy[1]}`;
                    overlays.push(
                        {
                            id: id,
                            x: xy[0],
                            y: xy[1],
                            className: 'highlight'

                        }
                    )
                }
                
            }
        }
    }

    /* get image src (url) */
    var image = document.getElementById(`${container_id}-img`);
    var imageURL = {
        type: 'image',
        url: image.getAttribute("src")
    };

    console.log(overlays);

    // OpenSeaDragon Image Viewer
    var viewer = OpenSeadragon({
        id: container_id,
        prefixUrl: "https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.0.0/images/",
        defaultZoomLevel: 0,
        fitHorizontally: true,
        tileSources: imageURL,
        // Initial rotation angle
        degrees: 0,
        // Show rotation buttons
        showRotationControl: true,
        // Enable touch rotation on tactile devices
        gestureSettingsTouch: {
            pinchRotate: true
        },
        overlays: [{
            id: 'right-arrow-overlay',
            x: 0.33,
            y: 0.75,
            width: 0.2,
            height: 0.25
        }],
        
    });

    viewer.addHandler('open', function() {

        var tracker = new OpenSeadragon.MouseTracker({
            element: viewer.container,
            moveHandler: function(event) {
                var webPoint = event.position;
                var viewportPoint = viewer.viewport.pointFromPixel(webPoint);
                var imagePoint = viewer.viewport.viewportToImageCoordinates(viewportPoint);
                
                // console.log("Webpoint: ", webPoint);
                // console.log("viewpoert: ", viewportPoint);
                // console.log("imagePoint: ", imagePoint);
            }
        });  

        tracker.setTracking(true);  

    });   
    

    /* remove static html image element */
    image.remove();
}