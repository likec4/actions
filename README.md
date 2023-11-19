# LikeC4 Export

Export LikeC4 views to png.
 
## Usage

```yaml
...
    steps:
      - uses: actions/checkout@v3

      - name: export
        uses: likec4/actions-export@v1
        with:
          out: out/likec4

      - name: upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: likec4
          path: out/likec4
```

## Inputs

|  INPUT  |  TYPE  | REQUIRED |  DEFAULT  |        DESCRIPTION               |
|---------|--------|----------|-----------|----------------------------------|
|   src   | string |  false   |   '.'     |   directory with likec4 sources  |
|   out   | string |  false   |   '.'     |   directory for generated png    |


## Report Bugs

Report bugs at https://github.com/likec4/actions-export/issues.

If you are reporting a bug, please include:

*   Your operating system name and version.
*   Any details about your workflow that might be helpful in troubleshooting.
*   Detailed steps to reproduce the bug.