;;; ** org-jekyll

(setq org-export-async-debug t)
;; (setq org-html-html5-fancy t)

;; (defadvice org-publish-org-sitemap
;;   (around remove-index-from-sitemap (project &optional sitemap-filename) activate)
;;   (let ((project (ad-get-arg 0)))
;;     (ad-set-arg 0 (cons (car project) (plist-put (cdr project) :exclude "index.org")))
;;     (ad-do-it)
;;     (plist-put (cdr project) :exclude nil)))

(defun org-mode-reftex-setup ()
  "Setup for using Reftex in org"
  (require 'reftex)
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
	 ;; enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)
	 ;; add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[notes:%l][%l-notes]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?t . "%t")
	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(defun remove-whitespace-in-chinese (orig-fun &rest args)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let* ((origin-contents (car (cdr args)))
	 (fix-regexp "[[:multibyte:]]"))
    (apply orig-fun (cons (car args)
			  (cons (replace-regexp-in-string
				  (concat
				   "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2"
				   origin-contents)
				 (cdr (cdr args)))))))
(advice-add 'org-html-paragraph :around #'remove-whitespace-in-chinese)

;; (defadvice org-html-template
;;     (after org-html-disable-title-in-content (contents info) activate)
(defun disable-title-in-index (orig-fun &rest args)
  (let ((buf (apply orig-fun args)))
    (if (string-equal (file-name-nondirectory buffer-file-name) "index.org")
	(replace-regexp-in-string "<h1 class=\"title\">.*\n" "" buf)
      buf)))
(advice-add 'org-html-template :around #'disable-title-in-index)

(defun remove-index-from-sitemap (orig-fun &rest args)
  "Actually apply the modification *AFTER* the original call,
but new advice mechanism suggests *AROUND* is more flexible.
Because the original `org-publish-org-sitemap' immediately closes
the sitemap buffer so I have to open it again and do replacement."
  (let ((orig-ret (apply orig-fun args)))
    (when orig-ret
      (with-current-buffer
	  ;; Re-open the sitemap buffer
	  (let* ((project (car args))
		 (project-plist (cdr project))
		 (dir (file-name-as-directory
		       (plist-get project-plist :base-directory)))
		 (sitemap-filename (car (cdr args)))
		 (sitemap-fullpath (concat dir (or sitemap-filename "sitemap.org"))))
	    (setq sitemap-buffer
		  (find-file sitemap-fullpath)))

	;; move cursor to beginning of buffer
	;; (beginning-of-buffer)
	(goto-char (point-min))
	;; search for index and delete it
	(while (search-forward-regexp "^.*\\(index\\|about\\|header\\).*\n" nil t)
	  (replace-match "" t t))

	;; move date to a span outside anchor
	;; (beginning-of-buffer)
	(goto-char (point-min))
	;; (re-search-forward " \\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)\\]\\]" "]]
	;;  #+BEGIN_HTML
	;;    <span class=\"timestamp\">\\1</span>
	;;  #+END_HTML")
	(re-search-forward " \\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)\\]\\]")
	(replace-match "]]
     #+BEGIN_HTML
       <span class=\"timestamp\">\\1</span>
     #+END_HTML")
	(save-buffer)))))

(advice-add 'org-publish-org-sitemap :around #'remove-index-from-sitemap)

(setq org-publish-project-alist
      '(
	("org-blog"
	 :base-directory "~/Notes/org-blog/"
	 :base-extension "org"
	 :publishing-directory "~/p/org-blog/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4               ; Just the default for this project.
	 :auto-preamble nil
	 :auto-sitemap t                  ; Generate sitemap.org automagically...
	 :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	 :sitemap-title ""                ; ... with title 'Sitemap'.
	 :sitemap-file-entry-format "%t %d"
	 :sitemap-sort-files anti-chronologically
	 :export-creator-info nil    ; Disable the inclusion of "Created by Org" in the postamble.
	 :export-author-info nil     ; Disable the inclusion of "Author: Your Name" in the postamble.
	 :auto-postamble nil         ; Disable auto postamble
	 :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
	 :section-numbers nil        ; Set this to "t" if you want headings to have numbers.
	 ;; :html-postamble "    <p class=\"postamble\">Last Updated %d.</p> " ; your personal postamble

	 :html-preamble "<div class=\"header\">
<div class=\"header-menu\">
<ul>
<li><a href=\"about.html\"><b>ABOUT</b></a>
</li>
</ul>
</div>
<section class=\"header-name\"><a href=\"/\"><b>Y</b>ANG<b>H</b>ONG</a></section>
</div>
"
	 :html-postamble "<div id=\"disqus_thread\"></div>
    <script type=\"text/javascript\">
	/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
	var disqus_shortname = 'yanghong'; // required: replace example with your forum shortname

	/* * * DON'T EDIT BELOW THIS LINE * * */
	(function() {
	    var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
	    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
	    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	})();
    </script>
    <noscript>Please enable JavaScript to view the <a href=\"http://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>
    <a href=\"http://disqus.com\" class=\"dsq-brlink\">comments powered by <span class=\"logo-disqus\">Disqus</span></a>"
	 :html-head-include-default-style nil  ;Disable the default css style
	 :html-head-include-scripts nil
	 :html-html5-fancy t
	 :html-doctype "html5"

	 :with-toc nil			; Disable table of contents
	 )))
