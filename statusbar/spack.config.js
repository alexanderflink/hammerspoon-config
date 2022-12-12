const { config } = require("@swc/core/spack");

module.exports = config({
  entry: {
    main: __dirname + "/src/index.js",
  },
  output: {
    path: __dirname + "/public/lib",
  },
  module: {},
});
