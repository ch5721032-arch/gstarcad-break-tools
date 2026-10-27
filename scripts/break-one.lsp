;; break-one.lsp - Break an object at a single picked point
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
