import hotkeys from 'hotkeys-js'

function toggleGlobalSearch() {
  console.log('aa')
  const e = document.getElementById('globalSearch')
  const input = document.getElementById('globalSearchInput')

  const isHidden = e.classList.contains('hidden')

  const show = () => {
    e.classList.remove('hidden')
  }

  const hide = () => {
    e.classList.add('hidden')
  }

  const closeOnEsc = (e) => {
    if (e.key === "Escape" || (e.key == '\\' && e.ctrlKey)) {
      hide()
    }
  }

  if (isHidden) {
    show()

    input.value = ''
    input.focus()

    e.addEventListener('keydown', closeOnEsc)

  } else {
    hide()

    e.removeEventListener('keydown', closeOnEsc)
  }

}

hotkeys('ctrl+\\', () => {
  toggleGlobalSearch()
})
