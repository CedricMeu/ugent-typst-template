# UGent Master Thesis Template

This Typst template is made for a master thesis at UGent.
The authors of this template are not affiliated with UGent.

## Usage

Run the following command in your terminal. The font path needs to be supplied as an argument if 
the UGent fonts are not installed system-wide. This command will create the output at `main.pdf`.

```shell
typst watch main.typ --font-path fonts
```

## Dependencies

- The library [acrostiche](https://typst.app/universe/package/acrostiche) is used to manage acronyms.
    These are maintained under `src/acronyms.typ`.

## Other remarks

The `front-page` function is really only a placeholder for the eventual front page which you will have to export
from Plato yourself.

## License
This template is licensed under the GPL-3.0 license. See the LICENSE file for more information.
