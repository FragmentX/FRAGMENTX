importScripts( '../js/three.min.js' );
importScripts( '../js/STLLoader.js' );

onmessage = function (oEvent) {
  var loader = new THREE.STLLoader();
  loader.load( oEvent.data, function ( geometry ) {
    geometry.computeVertexNormals();
    const buffer = geometry.getAttribute('position').array.buffer;
    self.postMessage({buffer: buffer}, [buffer]);
  } );
};
