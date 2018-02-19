importScripts( '../js/three.min.js' );
importScripts( '../js/PLYLoader.js' );

var names = ['01','02','03','04','05','06','07','08','09','10','11'];

onmessage = function (oEvent) {
  var loader = new THREE.PLYLoader();

  loader.load( oEvent.data, function ( geometry ) {
    geometry.computeVertexNormals();
    const buffer = geometry.getAttribute('position').array.buffer;
    self.postMessage({buffer: buffer}, [buffer]);
  } );
};
