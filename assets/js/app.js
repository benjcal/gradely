import "phoenix_html"
import "unpoly/dist/unpoly.js"
import "unpoly/dist/unpoly.min.css"
import "../css/app.css"
import "./globalSearch"
import feather from "feather-icons"

up.compiler('.grades', (e) => {
  e.children[0].onblur = (x) => up.submit(e)
})


up.compiler('.container', (e) => {
  feather.replace()
})

