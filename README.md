# dissertation

## Research questions

Under `src/lib` is a small library to manage research questions.
These RQs are maintained under `src/rqs.typ`.

## Other libraries

The library [acrostiche](https://typst.app/universe/package/acrostiche) is used to manage acronyms.
These are maintained under `src/acronyms.typ`.

## Other remarks

The template for the front page is not quite there, better to add the generated pdf after compiling and removing `src/front-page.typ` all together

## Nix flake

A nix flake is supplied that will install _typst_ and _just_.

## Justfile

`just watch` to watch the files.
`just build` to only build once.
Default (`just`) is `just watch`.
