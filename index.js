const toc = require('markdown-toc');

const input_text_area = document.getElementById("md-text")
const output_text_area = document.getElementById("toc")
const max_depth_input = document.getElementById("max-depth-input")
const no_first_h1_input = document.getElementById("no-first-h1-input")
const form = document.querySelector("form")

// if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
//     // dark mode
// }

// window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
//     const newColorScheme = event.matches ? "dark" : "light";
// });

function generateToc() {
    const input_text = input_text_area.value

    const options = {}
    options.maxdepth = max_depth_input.value
    options.firsth1 = !no_first_h1_input.checked
    const toc_insert_result = toc.insert(input_text, options)
    if (toc_insert_result === input_text) {
        return toc(input_text, options).content.trim()
    } else {
        return toc_insert_result.trim()
    }
}

submit_button = document.querySelector("button")
submit_button.addEventListener("click", (e) => {
    e.preventDefault()
    if (form.reportValidity()){
        output = generateToc()
        output_text_area.value = output
    }
})
