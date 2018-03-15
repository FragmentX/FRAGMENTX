importScripts( '../js/three.min.js' );
importScripts( '../js/PLYLoader.js' );

onmessage = function (oEvent) {
  var loader = new THREE.PLYLoader();
  //console.log(oEvent.data);
  loader.load( oEvent.data, function ( geometry ) {
    geometry.computeVertexNormals();
    const buffer = geometry.getAttribute('position').array.buffer;
    self.postMessage({buffer: buffer}, [buffer]);
  } );
};
