# GstarCAD Break Tools

Break an object at one picked point, between two picked points, or with a symmetric gap around a point.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Break is one of those commands you reach for constantly, yet it always asks for points you have to hunt down. These commands break an object at a single picked point, between two picked points, or with a symmetric gap around a point, which covers most cleanup and split work.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/break-one.lsp` | ;; break-one.lsp - Break an object at a single picked point
;; Command: BRK1
(defun c:BRK1 ( / en pt )
  (setq en (car (entsel "\nSelect object to break: ")))
  (if en
    (progn
      (setq pt (getpoint "\nBreak point: "))
      (if pt (command "_.BREAK" en pt "@"))
    )
  )
  (princ)
)
 |
| `scripts/break-two.lsp` | ;; break-two.lsp - Break an object between two picked points
;; Command: BRK2
(defun c:BRK2 ( / en p1 p2 )
  (setq en (car (entsel "\nSelect object to break: ")))
  (if en
    (progn
      (setq p1 (getpoint "\nFirst break point: "))
      (setq p2 (getpoint p1 "\nSecond break point: "))
      (if (and p1 p2) (command "_.BREAK" en p1 p2))
    )
  )
  (princ)
)
 |
| `scripts/break-gap.lsp` | ;; break-gap.lsp - Break a symmetric gap around a picked point
;; Command: BRKGAP
(defun c:BRKGAP ( / en pt gap d len lo hi p1 p2 )
  (vl-load-com)
  (setq en (car (entsel "\nSelect object: ")))
  (if en
    (progn
      (setq pt (getpoint "\nPoint on object: "))
      (setq gap (getreal "\nGap length <10>: "))
      (if (null gap) (setq gap 10.0))
      (if pt
        (progn
          (setq pt (vlax-curve-getClosestPointTo en pt))
          (setq d (vlax-curve-getDistAtPoint en pt))
          (setq len (vlax-curve-getDistAtParam en (vlax-curve-getEndParam en)))
          (setq lo (max 0.0 (- d (/ gap 2.0))))
          (setq hi (min len (+ d (/ gap 2.0))))
          (setq p1 (vlax-curve-getPointAtDist en lo))
          (setq p2 (vlax-curve-getPointAtDist en hi))
          (if (and p1 p2)
            (progn
              (command "_.BREAK" en p1 p2)
              (princ "\nGap created.")
            )
          )
        )
      )
    )
  )
  (princ)
)
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
