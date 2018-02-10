var object = new THREE.Object3D();

var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

var renderer = new THREE.WebGLRenderer({
    antialias: true,
    alpha: true
});

var scene = new THREE.Scene();
scene.add(object);

renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.autoClear = false;
renderer.setClearColor(0xffffff, 0.0);

$('#editor').append(renderer.domElement);

// camera
camera.position.z = 15;
camera.lookAt(new THREE.Vector3(0, 0, 0));
scene.add(camera);

var clock = new THREE.Clock();

// orbit, pan, zoom controls
controls = new THREE.OrbitControls(camera, renderer.domElement);
controls.enableZoom = true;
controls.addEventListener('change', function() {
    return render;
});

// lightning
directionalLight = new THREE.DirectionalLight(0xffaa44, 0.8, 100);
directionalLight.position.set(10, 5, 10);
directionalLight.castShadow = true;
scene.add(directionalLight);

light = new THREE.AmbientLight(0xffffff, 0.5);
light.position.set(5, 1, 1);
light.castShadow = true;
scene.add(light);

this.onWindowResize = function(event) {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.fov = (360 / Math.PI) * Math.atan(tanFOV * (window.innerHeight / windowHeight));
  camera.updateProjectionMatrix();
  camera.lookAt(scene.position);
  renderer.setSize(window.innerWidth, window.innerHeight);
  return renderer.render(scene, camera);
};

this.onMouseMove = function(event) {
  mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
  return mouse.y = -(event.clientY / window.innerHeight) * 2 + 1.15;
};

var render = function() {
    requestAnimationFrame(render);
    var delta = clock.getDelta();
    object.rotation.y += delta/4;
    renderer.render(scene, camera);
};

render();

var loader = new THREE.PLYLoader();
var files = ['./models/cake_part01.ply', './models/cake_part02.ply', './models/cake_part03.ply',
             './models/cake_part04.ply', './models/cake_part05.ply', './models/cake_part06.ply',
             './models/cake_part07.ply', './models/cake_part08.ply', './models/cake_part09.ply',
             './models/cake_part10.ply', './models/cake_part11.ply'];
var matrices = [[ 0.4557367861270905, -0.890114426612854, 0, 1.094243168830872,
                  0.8901145458221436, 0.4557368457317352, 0, 0.4239174425601959,
                  0, 0, 1, 0.2033785432577133,
                  0, 0, 0, 1],
                [ 0.2977617383003235, 0.9546400904655457, 0, 0.2279564142227173,
                    -0.9546402096748352, 0.2977617979049683, 0, -0.9803194999694824,
                    0, 0, 1, 0.3194349706172943,
                    0, 0, 0, 1 ],
                [ 0.8964703679084778, -0.4431034326553345, 0, 1.043796300888062,
                    0.4431034922599792, 0.8964704871177673, 0, -0.4771430492401123,
                    0, 0, 1, 0.09334299713373184,
                    0, 0, 0, 1 ],
                [ -0.1623168736696243, -0.9867385625839233, 0, 0.8348643183708191,
                    0.9867386817932129, -0.1623169034719467, 0, 0.7903349995613098,
                    0, 0, 1, -0.1304199695587158,
                    0, 0, 0, 1 ],
                [ -0.3446964025497437, 0.9387140870094299, 0, 0.4891934096813202,
                    -0.9387142062187195, -0.3446964621543884, 0, 1.029379844665527,
                    0, 0, 1, 0.2478030771017075,
                    0, 0, 0, 1  ],
                [ -0.9820892810821533, 0.1884153783321381, 0, -0.5069563388824463,
                    -0.1884154081344604, -0.9820894002914429, 0, 1.14728581905365,
                    0, 0, 1, 0.05478202179074287,
                    0, 0, 0, 1  ],
                [-0.06558050215244293, 0.9978471398353577, 0, -1.010628581047058,
                    -0.9978472590446472, -0.06558051705360413, 0, 0.5184153914451599,
                    0, 0, 1, 0.05047854036092758,
                    0, 0, 0, 1],
                [-0.9985226392745972, -0.05433512851595879, 0, -1.133195757865906,
                    0.05433513596653938, -0.9985227584838867, 0, -0.3063634932041168,
                    0, 0, 1, 0.08770053088665009,
                    0, 0, 0, 1],
                [0.9995351433753967, 0.03048407100141048, 0, -0.4286804497241974,
                    -0.03048407472670078, 0.9995352625846863, 0, -1.085983991622925,
                    0, 0, 1, -0.06134604290127754,
                    0, 0, 0, 1],
                [0.9982107877731323, -0.05979146063327789, 0, -0.5925528407096863,
                    0.05979146808385849, 0.9982109069824219, 0, -0.8273280262947083,
                    0, 0, 1, 0.342631459236145,
                    0, 0, 0, 1],
                [-0.9914983510971069, -0.1301182210445404, 0, 0.8207853436470032,
                    0.1301182508468628, -0.9914984703063965, 0, -1.07775604724884,
                    0, 0, 1, 0.02644695155322552,
                    0, 0, 0, 1]];

var rotate_m = new THREE.Matrix4();
rotate_m.set(
              1,  0, 0, 0,
              0,  0, 1, 0,
              0, -1, 0, 0,
              0,  0, 0, 1
);

var w = [null, null, null, null, null, null, null, null, null, null];

function startWorker() {
    var index = 0;
    while(index <11){
      set_worker(index);
      index = index + 1;
    }
}

function set_worker(index){
    if(typeof(Worker) !== "undefined") {
        w[index] = new Worker("/js/parseModel.js");

        w[index].addEventListener("message", function (event) {
          var abuffer = event.data.buffer;
          var vertices = new Float32Array(abuffer);
          var buffer = new THREE.BufferAttribute(vertices, 3);

          var material = new THREE.MeshLambertMaterial( { color: 0xffffff*Math.random() } );
          var geo = new THREE.BufferGeometry();
          geo.addAttribute('position',  buffer);

          geo.computeVertexNormals();
          var child = new THREE.Mesh(geo, material);
          child.scale.multiplyScalar( 0.01 );
          child.rotation.y += Math.PI;
          child.castShadow = true;
          child.receiveShadow = true;
          child.scale.multiplyScalar( 1000 );

          var scaleMatrix = new THREE.Matrix4();
          scaleMatrix.fromArray(matrices[index]).transpose();
          scaleMatrix.multiplyMatrices ( rotate_m, scaleMatrix );

          child.geometry.applyMatrix(scaleMatrix);
          child.geometry.verticesNeedUpdate = true;

          object.add(child);
        }, false);

        w[index].postMessage(index);

    } else {
        console.log("Sorry, your browser does not support Web Workers...");
    }
}

startWorker();