function hideToolbar() {
  $('#toolbar').animate({
    opacity: 0.25,
    left: "-=1000"
  }, 500);
}

function showToolbar() {
  $('#toolbar').animate({
    opacity: 1,
    left: "0"
  }, 500);
}

function hideInfo() {
  $('#info-container').animate({
    opacity: 0.25,
    right: "-=1000"
  }, 500);
}

function showInfo() {
  hideMeasurebar();
  if (measure) {
    measures();
  }
  $('#info-container').animate({
    opacity: 1,
    right: "0"
  }, 500);
}

function hideMeasurebar() {
  $('#measure').animate({
    opacity: 0.25,
    bottom: "-=1000"
  }, 500);
}

function showMeasurebar() {
  hideInfo();
  $('#measure').animate({
    opacity: 1,
    bottom: "0"
  }, 500);
}


//var arrow          = null;
var nearbyPiecesMode = false;
var selection        = null;
var wireframeMode    = false;
var torchMode        = false;
var rotationMode     = false;
var measure          = false;
var spotLight        = null;
var delayTime        = 0;
var strDownloadMime  = "image/octet-stream";
var mouse            = new THREE.Vector2();

var globalPlaneX = new THREE.Plane( new THREE.Vector3( -1,  0,  0 ),10000 );
var globalPlaneY = new THREE.Plane( new THREE.Vector3(  0, -1,  0 ),10000 );
var globalPlaneZ = new THREE.Plane( new THREE.Vector3(  0,  0, -1 ),10000 );

var clippingPlanes = [ globalPlaneX, globalPlaneY, globalPlaneZ ], Empty = Object.freeze( [] );

var clipping = [false, false, false];

var inputs = $('input[type=range]');

$('#clipX').on('input', function() { clip(0) });
$('#clipY').on('input', function() { clip(1) });
$('#clipZ').on('input', function() { clip(2) });

function clip(coord) {
  if (clipping[coord]) clippingPlanes[coord].constant = inputs[coord].value;
}

function unclip(coord) {
  clippingPlanes[coord].constant = 10000;
}

function setClip(coord) {
  clipping[coord] = !clipping[coord];
  if (clipping[coord]) clip(coord);
  else unclip(coord);
}

var bBoxes    = [];
var bbObjects = [];

var object  = new THREE.Object3D();
var pieces  = [];

var objectF   = new THREE.Object3D();
var faltants  = [];

var mesurePoints   = new THREE.Object3D();
var mesurePointsList = [];

var camera  = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

var renderer = new THREE.WebGLRenderer({
  preserveDrawingBuffer: true,
  antialias: true,
  alpha: true,
  localClippingEnabled : true
});

renderer.clippingPlanes = clippingPlanes;

// Spheres of light, world and measure
var geometry = new THREE.SphereGeometry( 5, 32, 32 );
var material = materialFactory(true, 0xffff00, THREE.DoubleSide, clippingPlanes, true, false, 1, false);

var sphere = new THREE.Mesh( geometry, material );

var geometryWorld = new THREE.SphereGeometry( 100, 32, 32 );
materialWorld = materialFactory(true, 0xffffff, THREE.DoubleSide, clippingPlanes, true, true, 0.0, true);

var sphereWorld = new THREE.Mesh( geometryWorld, materialWorld );

var geometryMesure = new THREE.SphereGeometry( 0.2, 32, 32 );

var scene = new THREE.Scene();
scene.add(object);
scene.add(objectF);
scene.add(sphereWorld);

// render
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.autoClear = true;
renderer.setClearColor(0xffffff, 0.0);
renderer.shadowMap.enabled = false;
renderer.shadowMap.type = THREE.PCFSoftShadowMap;

$('#editor').append(renderer.domElement);

// raycaster
raycaster = new THREE.Raycaster();

// Selection material
selectionMaterial  = materialFactory(false, 0x40e0d0, THREE.DoubleSide, clippingPlanes, true, false, 1, false);

// Normal material
unselectedMAterial = materialFactory(false, 0xcdb380, THREE.DoubleSide, clippingPlanes, true, false, 1, false);

// Wireframe material
wireframeMaterial  = materialFactory(true, 0xe8ddcb, THREE.DoubleSide, clippingPlanes, true, false, 1, true);

// Wireframe material
wireframeMaterialSelected = materialFactory(true, 0x40e0d0, THREE.DoubleSide, clippingPlanes, true, false, 1, true);

// Translucid material
var materialTranslucid = materialFactory(true, 0xffffff, THREE.DoubleSide, clippingPlanes, true, true, 0.1, false);

// Measure material
materialOne = materialFactory(true, 0x4e8064, THREE.DoubleSide, clippingPlanes, true, false, 1, false);


// mousemove
window.addEventListener( 'mousemove', onmousemove, false );
function onmousemove(event) {
  mouse.x =  (event.clientX / window.innerWidth) * 2 - 1;
  mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
};

// Set up camera
camera.position.z = 30;
camera.lookAt(new THREE.Vector3(0, 0, 0));
scene.add(camera);

var clock = new THREE.Clock();

// Set up orbit, pan, zoom controls
controls = new THREE.OrbitControls(camera, renderer.domElement);
controls.enableZoom = true;
controls.addEventListener('change', function() {
  return render;
});

// Set up Lights
directionalLight = new THREE.DirectionalLight(0xffaa44, 0.8, 100);
directionalLight.position.set(10, 5, 10);
directionalLight.castShadow = true;
scene.add(directionalLight);

light = new THREE.AmbientLight(0xffffff, 0.5);
light.position.set(5, 1, 1);
light.castShadow = true;
scene.add(light);

window.addEventListener( 'resize', onWindowResize, false );

function onWindowResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  camera.lookAt(scene.position);
  renderer.setSize(window.innerWidth, window.innerHeight);
  raycaster.setFromCamera(mouse, camera);
  renderer.render(scene, camera);
};

var render = function() {
  requestAnimationFrame(render);
  var delta = clock.getDelta();
  if(rotationMode) {
    object.rotation.y  += delta/4;
    objectF.rotation.y += delta/4;
  }
  renderer.render(scene, camera);
};

render();

var rotateM = new THREE.Matrix4();
rotateM.set(
        1,  0, 0, 0,
        0,  0, 1, 0,
        0, -1, 0, 0,
        0,  0, 0, 1
);

var w = new Array(gon.pieces.length);
var loaded = gon.pieces.length;
function startWorker() {
  for(let index = 0; index < gon.pieces.length; index++) {
    setWorker(index);
  }
}

function setWorker(index) {
  if (typeof(Worker) !== "undefined") {
    if (gon.type == 'ply') {
      w[index] = new Worker('/js/PLYparseModel.js');
    } else if (gon.type == 'stl') {
      w[index] = new Worker('/js/STLparseModel.js');
    }
    w[index].addEventListener("message", function (event) {
      var abuffer = event.data.buffer;
      var vertices = new Float32Array(abuffer);
      var buffer = new THREE.BufferAttribute(vertices, 3);
      var geo = new THREE.BufferGeometry();
      geo.addAttribute('position',  buffer);
      geo.computeVertexNormals();
      var child = new THREE.Mesh(geo, unselectedMAterial);
      child.scale.multiplyScalar( 0.01 );
      child.rotation.y += Math.PI;
      child.castShadow = true;
      child.receiveShadow = true;
      child.scale.multiplyScalar( 1000 );
      var scaleMatrix = new THREE.Matrix4();

      var matrix = new THREE.Matrix4();
      scaleMatrix.fromArray(gon.matrices[index].trim().split(' ').filter(function(val) { return val.length != 0; })).transpose();
      scaleMatrix.multiplyMatrices ( rotateM, scaleMatrix );

      child.geometry.applyMatrix(scaleMatrix);
      child.geometry.verticesNeedUpdate = true;

      if( gon.missings[index] ) {
        pieces.push(child);
        object.add(child);
      } else {
        faltants.push(child);
        objectF.add(child);
      }

      var boundingBox = new THREE.Box3();
      bbObjects.push(child);
      var helperboundingBox = new THREE.BoxHelper( child, 0xffff00 );
      boundingBox.setFromObject( helperboundingBox );
      bBoxes.push(boundingBox);
      loaded--;
      if (loaded == 0) {
        $('#loader').hide();
      }
    }, false);
    w[index].postMessage(gon.pieces[index]);

  } else {
    console.log("Sorry, your browser does not support Web Workers...");
  }
}

renderer.domElement.addEventListener('mousedown', function(event) {
  var d = new Date();
  delayTime = d.getTime();
})

renderer.domElement.addEventListener('mouseup', function(event) {
  var d = new Date();
  var deldel = d.getTime() - delayTime;
  if( deldel < 300) {
    var intersects, selected;
    event.preventDefault();
    raycaster.setFromCamera(mouse, camera);
    intersects = raycaster.intersectObjects(pieces.concat(faltants));
    if(!wireframeMode) {
      if(selection !== null) {
        selection.material = unselectedMAterial;
      }
    } else {
      if(selection !== null) {
        selection.material = wireframeMaterial;
      }
    }
    if (intersects.length > 0) {
      resetMaterial();
      if (measure) {
        if (event.button == 0) {
          var sphereOne = new THREE.Mesh( geometryMesure, materialOne );
          sphereOne.position.set( intersects[ 0 ].point.x , intersects[ 0 ].point.y, intersects[ 0 ].point.z );
          mesurePointsList.push(sphereOne);
          mesurePoints.add(sphereOne);
          document.getElementById("measureNo").innerHTML = countMesure();
          document.getElementById("measurePo").innerHTML = mesurePointsList.length;
          scene.add(mesurePoints);
        } else {
          intersects = raycaster.intersectObjects(mesurePointsList);
          var indexForRemove = mesurePointsList.indexOf(intersects[0].object);
          if (indexForRemove > -1) {
            mesurePointsList.splice(indexForRemove, 1);
          }
          mesurePoints.remove(intersects[0].object);
          document.getElementById("measurePo").innerHTML = mesurePointsList.length;
          document.getElementById("measureNo").innerHTML = countMesure();
        }
      } else {
        selected = intersects[0].object;
        if(!wireframeMode) {
          selected.material = selectionMaterial;
        } else {
          selected.material = wireframeMaterialSelected;
        }
        selection = selected;
      }
    } else {
      selection = null;
      if(torchMode & (event.button == 1)) {
        intersects = raycaster.intersectObjects([sphereWorld]);
        scene.remove(sphere);
        sphere.position.set( intersects[ 0 ].point.x , intersects[ 0 ].point.y, intersects[ 0 ].point.z );
        scene.add(sphere);
        spotLight.position.set( intersects[ 0 ].point.x, intersects[ 0 ].point.y, intersects[ 0 ].point.z );
      }
    }
  }
});

startWorker();

function resetMaterial() {
  selection = null;
  if( wireframeMode ) {
    for(var i = 0; i < bBoxes.length; i++) {
      bbObjects[i].material = wireframeMaterial;
    }
  } else {
    for(var i = 0; i < bBoxes.length; i++) {
      bbObjects[i].material = unselectedMAterial;
    }
  }
}

function goodParts() {
  allParts();
  scene.remove(objectF);
  resetMaterial();
}

function allParts() {
  scene.add(object);
  scene.add(objectF);
  resetMaterial();
}

function faltantParts() {
  allParts();
  scene.remove(object);
  resetMaterial();
}

function upCamera() {
  camera.position.z = 30;
  camera.position.y = 0;
  camera.position.x = 0;
  camera.lookAt(new THREE.Vector3(0, 0, 0));
}

function downCamera() {
  camera.position.z = 0;
  camera.position.y = 30;
  camera.position.x = 0;
  camera.lookAt(new THREE.Vector3(0, 0, 0));
}

function leftCamera() {
  camera.position.z = 0;
  camera.position.y = 0;
  camera.position.x = 30;
  camera.lookAt(new THREE.Vector3(0, 0, 0));
}

function measures() {
  measure = !measure;
  if(measure){
    showMeasurebar();
  } else {
    hideMeasurebar();
    scene.remove(mesurePoints);
    resetMesures();
  }
}

function resetMesures() {
  scene.remove(mesurePoints);
  mesurePoints = new THREE.Object3D();
  mesurePointsList = [];
  document.getElementById("measurePo").innerHTML = 0;
  document.getElementById("measureNo").innerHTML = 0;
}

function deleteLastMesure() {
  mesurePoints.remove(mesurePointsList.pop());
  document.getElementById("measurePo").innerHTML = mesurePointsList.length;
  document.getElementById("measureNo").innerHTML = countMesure();
}

function countMesure() {
  var result = 0;
  for (var i=0; i<(mesurePointsList.length-1); i++) {
    var positionPointAnterior  = mesurePointsList[i].getWorldPosition();
    var positionPointNow = mesurePointsList[i+1].getWorldPosition();
    var distanceX = positionPointAnterior.x - positionPointNow.x;
    var distanceY = positionPointAnterior.y - positionPointNow.y;
    var distanceZ = positionPointAnterior.z - positionPointNow.z;
    var distance  = Math.sqrt(distanceX*distanceX+distanceY*distanceY+distanceZ*distanceZ);
    result += distance;
  }
  return precisionRound(result,1);
}

function precisionRound(number, precision) {
  var factor = Math.pow(10, precision);
  return Math.round(number * factor) / factor;
}

function addTorch() {
  if(!torchMode) {
  renderer.shadowMap.enabled = true;
  spotLight = new THREE.SpotLight( 0xffffff, 1 );
  spotLight.position.set( 15, 40, 35 );
  spotLight.angle = Math.PI / 4;
  spotLight.penumbra = 0.05;
  spotLight.decay = 2;
  spotLight.distance = 200;
  spotLight.castShadow = true;
  spotLight.shadow.mapSize.width = 1024;
  spotLight.shadow.mapSize.height = 1024;
  spotLight.shadow.camera.near = 10;
  spotLight.shadow.camera.far = 200;
  scene.add( spotLight );
  } else{
    renderer.shadowMap.enabled = false;
    scene.remove( spotLight );
    scene.remove( sphere );
  }
  torchMode = !torchMode;
}

function nearbyPieces() {
  if (selection !== null) {
    var box3 = new THREE.Box3();
    var box = new THREE.BoxHelper( selection, 0xffff00 );
    box3.setFromObject( box );
    var counter = 0;
    for(var i = 0; i < bBoxes.length; i++) {
      var checker = box3.intersectsBox( bBoxes[i] );
      if(checker){
        counter = counter + 1;
        if( wireframeMode ) {
          bbObjects[i].material = wireframeMaterial;
        } else {
          bbObjects[i].material = unselectedMAterial;
        }
      }
      else {
        bbObjects[i].material = materialTranslucid;
      }
    }
    if( wireframeMode ) {
      selection.material = wireframeMaterialSelected;
    } else {
      selection.material = selectionMaterial;
    }
    console.log(counter);
  }
}

function changeRotationMode() {
  rotationMode = !rotationMode;
  if ($('#pauseButton').html().indexOf("Pause") >= 0) {
    $('#pauseButton').html('<i class="fas fa-play"></i> Play');
  } else {
     $('#pauseButton').html('<i class="fas fa-pause"></i> Pause');
  }
}

function materialFactory(basic, colorF, sideF, clippingPlanesF, clipShadowsF, transparentF, opacityF, wireframeF) {
  var materialServed;
  if (basic) {
    materialServed = new THREE.MeshBasicMaterial( {
      color: colorF,
      side: sideF,
      clippingPlanes: clippingPlanesF,
      clipShadows: clipShadowsF,
      transparent: transparentF,
      wireframe: wireframeF,
      opacity: opacityF} );
  } else {
    materialServed = new THREE.MeshLambertMaterial({
      color: colorF,
      side: sideF,
      clippingPlanes: clippingPlanesF,
      clipShadows: clipShadowsF,
      transparent: transparentF,
      wireframe: wireframeF,
      opacity: opacityF});
  }
  return materialServed;
}

function saveAsImage() {
  var imgData, imgNode;
  try {
    var strMime = "image/jpeg";
    imgData = renderer.domElement.toDataURL(strMime);
    saveFile(imgData.replace(strMime, strDownloadMime), "test.jpg");
  } catch (e) {
    console.log(e);
    return;
  }

}

function wireframeSet() {
  var index;
  var allpieces =  pieces.concat(faltants);
  for(index = 0; index < allpieces.length; index++) {
    if(!wireframeMode) {
      allpieces[index].material = wireframeMaterial;
    } else {
      allpieces[index].material = unselectedMAterial;
    }
  }
  wireframeMode = !wireframeMode;
}

var saveFile = function (strData, filename) {
  var link = document.createElement('a');
  if (typeof link.download === 'string') {
    document.body.appendChild(link);
    link.download = filename;
    link.href = strData;
    link.click();
    document.body.removeChild(link);
  } else {
    location.replace(uri);
  }
}