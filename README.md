# LikeC4 Github Action

![GitHub release](https://img.shields.io/github/release/likec4/actions.svg)

This action wraps [likec4](https://likec4.dev/docs/tools/cli/) CLI as a GitHub Action.
 
## Usage

Build website:

```yaml
...
    steps:
      - uses: actions/checkout@v4

      - name: build
        uses: likec4/actions@v1
        with:
          action: build
          path: src/likec4
          output: dist
          base: baseurl

      - name: upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: likec4
          path: dist
```

Export diagrams to PNG:

```yaml
...
    steps:
      - name: export diagrams
        uses: likec4/actions@v1
        with:
          export: png
          path: src/likec4
          output: images
```

Code generation:

```yaml
...
    steps:
      - name: code generation
        uses: likec4/actions@v1
        with:
          codegen: react
          output: __generated__/likec4.tsx
```

## Inputs

| Name      | Description                                     |
| --------- | ----------------------------------------------- |
| `action`  | Action to perform (`build` / `export` / `codegen`) |
| `export`  | Can be used instead of `action: export`           |
| `codegen` | Can be used instead of `action: codegen`, same values as in [cli](https://likec4.dev/docs/tools/cli/)  |
| `path`    | Path in repository to likec4 sources, root otherwise   |
| `output`  | Output directory/file                            |
| `base`    | Custom baseUrl for website                        |

> All inputs are optional.  
> By default builds a website to `dist` directory.

## Report Bugs

Report bugs at https://github.com/likec4/actions/issues.

If you are reporting a bug, please include:

*   Your operating system name and version.
*   Any details about your workflow that might be helpful in troubleshooting.
*   Detailed steps to reproduce the bug.