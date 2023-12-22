class Theme {
    static light = new Theme("light")
    static dark = new Theme("dark")
    static auto = new Theme("auto")
    
    constructor(theme_name) {
        this.theme_name = theme_name
    }

    toString() {
        return this.theme_name
    }
}

const themes = [Theme.light, Theme.dark]
if (window.matchMedia) { themes.unshift(Theme.auto) }

const fallback_theme = document.documentElement.getAttribute("data-bs-theme") ?? Theme.dark
const default_theme = Theme.auto
let current_theme // can only be light or dark but not auto as the auto theme is handled here in JS

function get_preferred_theme() {
    return localStorage.getItem("preferred_theme") ?? default_theme
}
function set_preferred_theme(theme) {
    localStorage.setItem("preferred_theme", theme)
}

function setTheme(theme) {
    if (theme == Theme.auto) {
        if (window.matchMedia) {
            document.getElementById("toggle-theme-button-auto-text").classList.remove("d-none")
            theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? Theme.dark : Theme.light
        } else {
            document.getElementById("toggle-theme-button-auto-text").classList.add("d-none")
            theme = fallback_theme
        }
    } else {
        document.getElementById("toggle-theme-button-auto-text").classList.add("d-none")
    }
    document.documentElement.setAttribute("data-bs-theme", theme)
    current_theme = theme
}

function cycleThemes() {
    i = 0
    while (i < themes.length && themes[i] != get_preferred_theme()) {
        i++
    }

    const next_item_index = (i + 1) % themes.length
    const next_theme = themes[next_item_index]

    set_preferred_theme(next_theme)
    setTheme(next_theme)
}

setTheme(get_preferred_theme() ?? default_theme)

document.getElementById("toggle-theme-button").addEventListener("click", e => {
    cycleThemes()
})

if (window.matchMedia) {
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
        if (get_preferred_theme() == Theme.auto) {
            setTheme(Theme.auto)
        }
    });
}
