;; break-two.lsp - Break an object between two picked points
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
