;; break-gap.lsp - Break a symmetric gap around a picked point
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
