;;; window-resizer.el --- Resizing window interactively.

;; Copyright (C) 2017 Tomohiro INABA

;; Author: Tomohiro INABA <inaba1115@gmail.com>
;; URL: https://github.com/inazo1115/window-resizer
;; Version: 1.0.0

;;; Commentary:

;; Resizing window interactively.

;;; Code:

(require 'cl-lib)

(defun window-resizer--wait-and-read-key ()
  "Wait keyboard input and read its charactor."
  (let ((prompt (format "size[%dx%d] h/j/k/l" (window-width) (window-height))))
    (aref (read-key-sequence-vector prompt) 0)))

(defun window-resizer--loop (dx dy)
  "Resize window interactively, where DX and DY are delta."
  (cl-loop
   (let ((key (window-resizer--wait-and-read-key)))
     (cond ((= key ?h) (shrink-window-horizontally dx))
           ((= key ?j) (shrink-window dy))
           ((= key ?k) (enlarge-window dy))
           ((= key ?l) (enlarge-window-horizontally dx))
           (t (message "Quit") (cl-return))))))

(defun window-resizer-do ()
  "The entry point of this library."
  (interactive)
  (let ((dx (if (= (nth 0 (window-edges)) 0) 1 -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1 -1)))
    (window-resizer--loop dx dy)))

(provide 'window-resizer)

;;; window-resizer.el ends here
