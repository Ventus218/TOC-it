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
    const input_text = input_text_area.value.trim()

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

function outputToc(toc) {
    output_text_area.value = toc
}

submit_button = document.querySelector("button")
submit_button.addEventListener("click", (e) => {
    e.preventDefault()
    if (form.reportValidity()){
        let toc = generateToc()
        outputToc(toc)
    }
})


// ***** SETTING EVENTS IN ORDER TO TOGGLE THE AUTOMATIC TOC GENERATION FEATURE *****

const generate_button_div = document.getElementById("generate-button-div")
const auto_generate_toc_checkbox = document.getElementById("auto-generate-toc-input")

auto_generate_toc_checkbox.addEventListener("change", (e) => {
    if (auto_generate_toc_checkbox.checked) {
        generate_button_div.setAttribute("hidden", "true")
        if (form.reportValidity()) {
            let toc = generateToc()
            outputToc(toc)
        }
    } else {
        generate_button_div.removeAttribute("hidden")
    }
})


// ***** SETTING EVENTS IN ORDER TO AUTOMATICALLY GENERATE THE TOC *****
input_text_area.addEventListener("input", (e) => {
    if (auto_generate_toc_checkbox.checked && form.reportValidity()) {
        let toc = generateToc()
        outputToc(toc)
    }
})

max_depth_input.addEventListener("input", (e) => {
    if (auto_generate_toc_checkbox.checked && form.reportValidity()) {
        let toc = generateToc()
        outputToc(toc)
    }
})

no_first_h1_input.addEventListener("input", (e) => {
    if (auto_generate_toc_checkbox.checked && form.reportValidity()) {
        let toc = generateToc()
        outputToc(toc)
    }
})
