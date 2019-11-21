import "phoenix_html"
import "unpoly/dist/unpoly.js"
import "unpoly/dist/unpoly.min.css"
import "../css/app.css"

up.compiler('.grades', (e) => {
  e.children[0].onblur = (x) => up.submit(e)
})
