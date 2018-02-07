var object = []

var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

var renderer = new THREE.WebGLRenderer({
    antialias: true,
    alpha: true
});

var scene = new THREE.Scene();

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
controls.autoRotate = true;
controls.addEventListener('change', function() {
    return render;
});

// lightning
directionalLight = new THREE.DirectionalLight(0xffaa44, 0.6, 100);
directionalLight.position.set(10, 5, 10);
directionalLight.castShadow = true;
scene.add(directionalLight);

light = new THREE.AmbientLight(0xffffff, 1.2);
light.position.set(5, 1, 1);
light.castShadow = true;
scene.add(light);

this.onWindowResize = function(event) {
  camera.aspect = window.innerWidth / window.innerHeight;
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
    controls.update(delta);
    renderer.render(scene, camera);
};

var rotate_m = new THREE.Matrix4();
rotate_m.set(
              1,  0, 0, 0,
              0,  0, 1, 0,
              0, -1, 0, 0,
              0,  0, 0, 1
            );

var matrixs_object = [
            [0.455, -0.890, 0, 1.094,
            0.890, 0.455, 0, 0.423,
            0, 0, 1, 0.203,
            0, 0, 0, 1],
            [0.297, 0.954, 0, 0.227,
            -0.954, 0.297, 0, -0.980,
             0, 0, 1, 0.319,
             0, 0, 0, 1],
            [0.896, -0.443, 0, 1.043,
             0.443, 0.896, 0, -0.477,
             0, 0, 1, 0.093,
             0, 0, 0, 1],
            [-0.162, -0.986, 0, 0.834,
            0.986, -0.162, 0, 0.790,
            0, 0, 1, -0.130,
            0, 0, 0, 1
            ],
            [-0.344, 0.938, 0, 0.489,
            -0.938, -0.344, 0, 1.029,
            0, 0, 1, 0.247,
            0, 0, 0, 1
            ],
            [-0.982, 0.188, 0, -0.506,
            -0.188, -0.982, 0, 1.147,
            0, 0, 1, 0.054,
            0, 0, 0, 1
            ],
            [-0.065, 0.997, 0, -1.010,
            -0.997, -0.065, 0, 0.518,
            0, 0, 1, 0.050,
            0, 0, 0, 1
            ],
            [-0.998, -0.054, 0, -1.133,
            0.054, -0.998, 0, -0.306,
            0, 0, 1, 0.087,
            0, 0, 0, 1
            ],
            [0.999, 0.030, 0, -0.428,
            -0.030, 0.999, 0, -1.085,
            0, 0, 1, -0.061,
            0, 0, 0, 1
            ],
            [0.998, -0.059, 0, -0.592,
            0.059, 0.998, 0, -0.827,
            0, 0, 1, 0.342,
            0, 0, 0, 1
            ],
            [-0.991, -0.130, 0, 0.820,
            0.130, -0.991, 0, -1.07,
            0, 0, 1, 0.026,
            0, 0, 0, 1
            ]
];

render();

var names = ['01','02','03','04','05','06','07','08','09','10','11']

function loadp1(index){
    loader = new THREE.PLYLoader();
    loader.load( '../models/cake_part'+names[index]+'.ply', function ( geometry ) {
        var g = new THREE.Geometry();
        g.fromBufferGeometry(geometry);

        g.mergeVertices();
        g.computeFaceNormals();
        g.computeVertexNormals();

        var buffer_g = new THREE.BufferGeometry();
        buffer_g.fromGeometry(g);

        var material = new THREE.MeshLambertMaterial( { color: 0xffffff*Math.random(), shading: THREE.SmoothShading } );
        var mesh = new THREE.Mesh(buffer_g, material);

        mesh.scale.multiplyScalar( 0.01 );
        mesh.rotation.y += Math.PI;
        mesh.castShadow = true;
        mesh.receiveShadow = true;
        mesh.scale.multiplyScalar( 1000 );
        var scaleMatrix = new THREE.Matrix4();
        scaleMatrix.fromArray(matrixs_object[index]).transpose();
        scaleMatrix.multiplyMatrices ( rotate_m, scaleMatrix );
        mesh.geometry.applyMatrix(scaleMatrix);
        mesh.geometry.verticesNeedUpdate = true;
        return mesh
    } );
}

for (i = 0; i < 11; i++) {
  loadp1(i);
}
