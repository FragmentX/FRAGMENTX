importScripts('../js/three.min.js');
importScripts('../js/LoaderSupport.js');
importScripts('../js/OBJLoader2.js');

onmessage = function (oEvent) {
  var loader = new THREE.OBJLoader2();
  loader.load(oEvent.data,
    function (event) {
      detail.loaderRootNode.children[0].geometry.center();
      const buffer = detail.loaderRootNode.children[0].geometry.getAttribute('position');
      self.postMessage({ buffer: buffer }, [buffer]);
    },
    function (xhr) {
    },
    function (error) {
    }
  );
};

