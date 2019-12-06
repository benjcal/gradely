import "phoenix_html"
import "unpoly/dist/unpoly.js"
import "unpoly/dist/unpoly.min.css"
import "../css/app.css"
import "./globalSearch"
import feather from "feather-icons"

up.compiler('.grade', (e) => {
  const input = e.children[0]
  const popup = e.children[1]

  input.onfocus = () => {
    // write function to close all other popups on the page
    const allGrades = document.getElementsByClassName('grade')
    for (const g of allGrades) {
      const popup = g.children[1]
      popup.classList.add('hidden')
    }

    popup.classList.remove('hidden')
  }

  input.onblur = () => {
    //up.submit(e)
  }

})


up.compiler('.container', (e) => {
  feather.replace()
})


