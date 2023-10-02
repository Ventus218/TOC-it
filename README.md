# TOC it

**TOC it** permette di generare la *table of contents* (l'indice) di un file scritto in Markdown.

E' possibile fruire del servizio sia attraverso una pagina web che attraverso una web API.

![TOC it frontend](./doc/img/frontend.png)

<!-- toc -->

- [Utilizzo](#utilizzo)
  * [Pagina web](#pagina-web)

<!-- tocstop -->

## Utilizzo

### Pagina web
Inserendo del testo in Markdown nella textarea di sinistra e cliccando il tasto *Generate* verrà generata sulla destra la table of contents (l'indice) del documento.
![Esempio di utilizzo](./doc/gifs/example_main.gif)

Sono anche disponibili diverse opzioni:
- Impostazione del livello di profondità da raggiungere.
- Esclusione del primo H1 (spesso non si vuole che la table of contents includa il titolo della pagina).
- Inserire automaticamente la table of contents all'interno del documento.

  Inserendo in qualsiasi parte del documento il commento `<!-- toc -->` la table of contents verrà automaticamente inserita dove indicato.
  ![Esempio dell'inserimento automatico della toc](./doc/gifs/example_toc_here.gif)
