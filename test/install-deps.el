;;  -*- lexical-binding: t -*-

(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(progn
  (setq package-user-dir (getenv "DEPS_DIR"))
  (package-refresh-contents)
  (if-let ((reqs (package-desc-reqs (package-buffer-info)))
           (transaction (package-compute-transaction nil reqs)))
      (progn
        (message "Installing %s..."
                 (mapconcat (quote package-desc-full-name) transaction ", "))
        (package-download-transaction transaction))
    (message "Nothing to install")))
