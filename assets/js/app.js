import "phoenix_html"
import "unpoly/dist/unpoly.js"
import "unpoly/dist/unpoly.min.css"
import "../css/app.css"
import "./globalSearch"
import feather from "feather-icons"
import Chart from 'chart.js'

up.compiler('.student-graph', (e) => {
  const lg = document.getElementById('last-grades')
  // const data = JSON.parse(lg.dataset.data)
  // const c = new Chart(lg, data)
})



up.compiler('.grade', (e) => {
  const input = e.children[1]
  const popup = e.children[2]

  input.onfocus = () => {
    // write function to close all other popups on the page
    const allGrades = document.getElementsByClassName('grade')
    for (const g of allGrades) {
      const popup = g.children[2]
      popup.classList.add('hidden')
    }

    popup.classList.remove('hidden')
  }

  //input.onblur = () => {
    //up.submit(e)
  //}

  feather.replace()
})


up.compiler('.container', (e) => {
  feather.replace()
})

