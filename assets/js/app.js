// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

import "unpoly/dist/unpoly.min.js"
import "unpoly/dist/unpoly.min.css"
// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

up.compiler('.gradess', (e) => {
  console.log('a')
})
