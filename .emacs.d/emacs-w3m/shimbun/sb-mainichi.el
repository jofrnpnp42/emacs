;;; sb-mainichi.el --- shimbun backend for Mainichi jp -*- coding: iso-2022-7bit; -*-

;; Copyright (C) 2001-2009, 2011-2013, 2015-2017
;; Koichiro Ohba <koichiro@meadowy.org>

;; Author: Koichiro Ohba <koichiro@meadowy.org>
;;         Katsumi Yamaoka <yamaoka@jpl.org>
;; Keywords: news

;; This file is a part of shimbun.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Original code was sb-yomiuri.el which is written by
;; TSUCHIYA Masatoshi <tsuchiya@namazu.org> and
;; Yuuichi Teranishi <teranisi@gohome.org>

;;; Code:

(require 'sb-rss)
(require 'sb-multi)

(luna-define-class shimbun-mainichi (shimbun-japanese-newspaper
				     shimbun-multi shimbun-rss) ())

(defvar shimbun-mainichi-url "http://mainichi.jp/")

(defvar shimbun-mainichi-top-level-domain "mainichi.jp")

(defvar shimbun-mainichi-server-name "$BKhF|?7J9(B")

(defvar shimbun-mainichi-prefer-text-plain nil
  "*Non-nil means prefer text/plain articles rather than html articles.")

(defvar shimbun-mainichi-ignored-subject "\\`PR: ")

(luna-define-method initialize-instance :after ((shimbun shimbun-mainichi)
						&rest init-args)
  (shimbun-rss-initialize-ignored-subject shimbun))

(defvar shimbun-mainichi-group-table
  '(("flash" "$B%K%e!<%9B.Js(B"
     "http://mainichi.jp/rss/etc/flash.rss")
    ("sports" "$B%9%]!<%D(B"
     "http://mainichi.jp/rss/etc/sports.rss")
    ("entertainment" "$B%(%s%?!<%F%$%s%a%s%H(B"
     "http://mainichi.jp/rss/etc/enta.rss")
    ("mantan" "$B%"%K%a!&%^%s%,!&%2!<%`(B"
     "http://mainichi.jp/rss/etc/mantan.rss")
    ("electronics" "$B#I#T!&2HEE(B"
     "http://mainichi.jp/rss/etc/electronics.rss")
    ("weekly" "$B1Q8l$r3X$V(B"
     "http://mainichi.jp/rss/etc/weekly.rss")
    ;; Non-RSS groups.
    ("opinion.editorial" "$B<R@b(B"
     "http://mainichi.jp/select/opinion/editorial/archive/")
    ("opinion.yoroku" "$BM>O?(B"
     "http://mainichi.jp/select/opinion/yoroku/archive/")
    ("opinion.hasshinbako" "$BH/?.H"(B"
     "http://mainichi.jp/select/opinion/hasshinbako/archive/")
    ("opinion.eye" "$B5-<T$NL\(B"
     "http://mainichi.jp/select/opinion/eye/archive/")
    ("opinion.hito" "$B$R$H(B"
     "http://mainichi.jp/select/opinion/hito/archive/")
    ("opinion.kinji" "$B6a;vJR!9(B"
     "http://mainichi.jp/select/opinion/kinji/archive/")
    ("opinion.yuraku" "$BM+3ZD"(B"
     "http://mainichi.jp/select/opinion/yuraku/archive/")
    ("opinion.closeup" "$B%/%m!<%:%"%C%W(B"
     "http://mainichi.jp/select/opinion/closeup/archive/")
    ("opinion.kaisetsu" "$BEZMK2r@b(B"
     "http://mainichi.jp/select/opinion/kaisetsu/")
    ("opinion.newsup" "$B%K%e!<%9#U#P(B"
     "http://mainichi.jp/select/opinion/newsup/")
    ("opinion.jidainokaze" "$B;~Be$NIw(B"
     "http://mainichi.jp/select/opinion/jidainokaze/")
    ("entertainment.art" "$B7]=Q!&J82=(B"
     "http://mainichi.jp/enta/art/archive/")
    ("fuchisou" "$BIwCNAp(B"
     "http://mainichi.jp/fuchisou/")))

(defvar shimbun-mainichi-x-face-alist
  '(("default" . "\
Face: iVBORw0KGgoAAAANSUhEUgAAABwAAAAcBAMAAACAI8KnAAAABGdBTUEAALGPC/xhBQAAABh
 QTFRFC2zfDGzfEnDgJn3iU5fnj7vvzuH4+vz++nlsOQAAAC90RVh0U29mdHdhcmUAWFYgVmVyc2l
 vbiAzLjEwYStGTG1hc2sgIFJldjogMTIvMjkvOTQbx6p8AAABA0lEQVR4nGWRPW+DMBiED5vuqK0
 60yppVwQ0rFTYZo348poSA3uDzd/vCxNNT14en1/5zgZYEoCF69rk2zhWPR6GADwCl864tsaHFUJ
 dweTJuMcQZZ0kRQxkqnaHik2DbBwdVuPgtPG7WTcuhPdshdM5f7lp4SpyXUPoazu1i6HZpbY6R3a
 ZhAW8ztmZsDxPqf0Cb6zsVzQjJQA/2GNE2OWHbqaQvEggI7wFfOmxk1esLUL2GrJg2yBkrTSDqvB
 eJKmhqtNpttk3sllICskmdbXlGdkPNcd/TIuuvOxcM65IsxvSa2Q79w7V8AfL2u1nY9ZquuiWfK7
 1BSVNQzxF9B+40y/ui1KdNxt0ugAAAAd0SU1FB9QEDQAjJMA7GTQAAAAASUVORK5CYII=")))

(defvar shimbun-mainichi-expiration-days 7)

(luna-define-method shimbun-groups ((shimbun shimbun-mainichi))
  (mapcar 'car shimbun-mainichi-group-table))

(luna-define-method shimbun-current-group-name ((shimbun shimbun-mainichi))
  (nth 1 (assoc (shimbun-current-group-internal shimbun)
		shimbun-mainichi-group-table)))

(luna-define-method shimbun-index-url ((shimbun shimbun-mainichi))
  (nth 2 (assoc (shimbun-current-group-internal shimbun)
		shimbun-mainichi-group-table)))

(luna-define-method shimbun-headers :around ((shimbun shimbun-mainichi)
					     &optional range)
  (if (string-match "\\.rss\\'" (shimbun-index-url shimbun))
      ;; Use the function defined in sb-rss.el.
      (luna-call-next-method)
    ;; Use the default function defined in shimbun.el.
    (funcall (intern "shimbun-headers"
		     (luna-class-obarray (luna-find-class 'shimbun)))
	     shimbun range)))

(luna-define-method shimbun-get-headers :around ((shimbun shimbun-mainichi)
						 &optional range)
  (let ((from (concat shimbun-mainichi-server-name " ("
		      (shimbun-current-group-name shimbun) ")"))
	(group (shimbun-current-group-internal shimbun))
	headers)
    (cond ((string-match "\\.rss\\'" (shimbun-index-url shimbun))
	   (shimbun-strip-cr)
	   (goto-char (point-min))
	   (while (and (search-forward "<title><![CDATA[AD:" nil t)
		       (re-search-backward "<item[\t\n ]*" nil t)
		       (shimbun-end-of-tag "item" t))
	     (replace-match "\n"))
	   (dolist (header (setq headers (luna-call-next-method)) headers)
	     (shimbun-header-set-from header from)))
	  ((string-equal group "fuchisou")
	   (shimbun-mainichi-get-headers-fuchisou shimbun range from))
	  (t
	   (shimbun-mainichi-get-headers shimbun range from)))))

(luna-define-method shimbun-rss-build-message-id :around ((shimbun
							   shimbun-mainichi)
							  url &optional date)
  ;; Don't strip string following "?" or "#" in url.  See sb-rss.el.
  (concat "<" (md5 url) "%" (shimbun-current-group shimbun)
	  "@" (shimbun-server shimbun) ".shimbun.namazu.org>"))

(defun shimbun-mainichi-get-headers-fuchisou (shimbun range from)
  "Get headers for the fuchisou groups."
  (let ((rgrp (mapconcat 'identity
			 (nreverse (split-string
				    (shimbun-current-group-internal shimbun)
				    "\\."))
			 "."))
	(count 0)
	(index (shimbun-index-url shimbun))
	(pages (shimbun-header-index-pages range))
	end id headers indices idx)
    (catch 'stop
      (while t
	(shimbun-strip-cr)
	(goto-char (point-min))
	(when (and (or (search-forward "<!--<h2>$B:G?7$N5-;v(B</h2>-->" nil t)
		       (search-forward "<!--| main-box BGN |-->" nil t))
		   (re-search-forward "\
<ul[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"list-typeD\""
				      nil t)
		   (shimbun-end-of-tag "ul"))
	  (goto-char (match-beginning 0))
	  (setq end (match-end 0))
	  (while (re-search-forward
		  (eval-when-compile
		    (concat
		     "<a[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*href=\""
		     ;; 1. url
		     "\\(/articles/"
		     ;; 2. serial number
		     "\\("
		     ;; 3. year
		     "m?\\(20[0-9][0-9]\\)"
		     ;; 4. month
		     "\\([01][0-9]\\)"
		     ;; 5. day
		     "\\([0-3][0-9]\\)"
		     "[^\".]+\\)\\)\""
		     "[^>]*>\\(?:[\t\n ]*<[^>]+>\\)*[\t\n ]*"
		     ;; 6. subject
		     "\\([^<]+\\)"))
		  end t)
	    (setq id (concat "<"
			     (mapconcat
			      'identity
			      (save-match-data
				(nreverse
				 (split-string (match-string 2) "/")))
			      ".")
			     "." rgrp
			     "%" shimbun-mainichi-top-level-domain ">"))
	    (if (shimbun-search-id shimbun id)
		(unless (zerop count)
		  (throw 'stop nil))
	      (push (shimbun-create-header
		     0 (match-string 6) from
		     (shimbun-make-date-string
		      (string-to-number (match-string 3))
		      (string-to-number (match-string 4))
		      (string-to-number (match-string 5)))
		     id "" 0 0
		     (shimbun-expand-url (match-string 1) index))
		    headers))))
	(push index indices)
	(if (and (or (not pages)
		     (< (setq count (1+ count)) pages))
		 (progn
		   (goto-char (point-min))
		   (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"pager\""
				      nil t))
		 (shimbun-end-of-tag "div")
		 (progn
		   (setq end (match-beginning 0)
			 idx nil)
		   (while (and (not idx)
			       (re-search-backward "\
<a[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*href=\"\\([^\"]+/[0-9]+\\)\""
						   end t))
		     (when (member (setq idx (shimbun-expand-url
					      (match-string 1) index))
				   indices)
		       (setq idx nil)))
		   idx))
	    (progn
	      (setq index idx)
	      (erase-buffer)
	      (shimbun-fetch-url shimbun index t)
	      (goto-char (point-min)))
	  (throw 'stop nil))))
    headers))

(defun shimbun-mainichi-get-headers (shimbun range from)
  "Get headers for non-RSS groups."
  (let ((rgrp (mapconcat 'identity
			 (nreverse (split-string
				    (shimbun-current-group-internal shimbun)
				    "\\."))
			 "."))
	(count 0)
	(index (shimbun-index-url shimbun))
	(pages (shimbun-header-index-pages range))
	end id headers indices idx)
    (catch 'stop
      (while t
	(shimbun-strip-cr)
	(goto-char (point-min))
	(when (and (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"NewsArticle\""
				      nil t)
		   (shimbun-end-of-tag "div"))
	  (goto-char (match-beginning 0))
	  (setq end (match-end 0))
	  (while (re-search-forward
		  (eval-when-compile
		    (concat
		     "<a[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*href=\""
		     ;; 1. url
		     "\\([^\"]+/"
		     ;; 2. serial number
		     "\\("
		     ;; 3. year
		     "m?\\(20[0-9][0-9]\\)"
		     ;; 4. month
		     "\\([01][0-9]\\)"
		     ;; 5. day
		     "\\([0-3][0-9]\\)"
		     "[^\".]+\\)\\.html\\)\""
		     "\\(?:[\t\n ]+[^\t\n >]+\\)*[\t\n ]*>[\t\n ]*"
		     ;; 6. subject
		     "\\([^<]+\\)"))
		  end t)
	    (setq id (concat "<" (match-string 2) "." rgrp
			     "%" shimbun-mainichi-top-level-domain ">"))
	    (if (shimbun-search-id shimbun id)
		(unless (zerop count)
		  (throw 'stop nil))
	      (push (shimbun-create-header
		     0 (match-string 6) from
		     (shimbun-make-date-string
		      (string-to-number (match-string 3))
		      (string-to-number (match-string 4))
		      (string-to-number (match-string 5)))
		     id "" 0 0
		     (shimbun-expand-url (match-string 1) index))
		    headers))))
	(push index indices)
	(if (and (or (not pages)
		     (< (setq count (1+ count)) pages))
		 (progn
		   (goto-char (point-min))
		   (re-search-forward "\
<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"CalendarBar\""
				      nil t))
		 (shimbun-end-of-tag "div")
		 (progn
		   (setq end (match-beginning 0)
			 idx nil)
		   (while (and (not idx)
			       (re-search-backward "\
<a[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*href=\"\\([^\"]+\\)\""
						   end t))
		     (when (member (setq idx (shimbun-expand-url
					      (match-string 1) index))
				   indices)
		       (setq idx nil)))
		   idx))
	    (progn
	      (setq index idx)
	      (erase-buffer)
	      (shimbun-fetch-url shimbun index t)
	      (goto-char (point-min)))
	  (throw 'stop nil))))
    headers))

(luna-define-method shimbun-multi-next-url ((shimbun shimbun-mainichi)
					    header url)
  (shimbun-mainichi-multi-next-url shimbun header url))

(defun shimbun-mainichi-multi-next-url (shimbun header url)
  (goto-char (point-min))
  ;; Replace this article with the full one.
  (when (re-search-forward "\
<span[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"More\"[^<]+\
<a[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*href=\"\\([^\"]+\\)\"[^>]*>\
\[\t\n ]*$BB3$-$rFI$`(B[\t\n ]*</a>[\t\n ]*</span>" nil t)
    (let ((orig (buffer-string)))
      (unless (shimbun-fetch-url shimbun (prog1
					     (match-string 1)
					   (erase-buffer)))
	(erase-buffer)
	(insert orig)))
    (goto-char (point-min)))
  (let (end)
    (when (and (or (and (re-search-forward "\
<nav[\t\n ]\\(?:[^\t\n >]+[\t\n ]+\\)*id=\"SearchPageAutoWrap\"" nil t)
			(shimbun-end-of-tag "nav"))
		   (progn
		     (goto-char (point-min))
		     (and (re-search-forward "\
<ul[\t\n ]\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"SearchPageWrap clr\"" nil t)
			  (shimbun-end-of-tag "ul"))))
	       (progn
		 (goto-char (match-beginning 0))
		 (setq end (match-end 0))
		 (re-search-forward "\
<li[\t\n ]\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"PageSelect\"" end t))
	       (re-search-forward "\
<a[\t\n ]\\(?:[^\t\n >]+[\t\n ]+\\)*href=\"\\([^\"]+\\)" end t))
      (shimbun-expand-url (match-string 1) url))))

(luna-define-method shimbun-clear-contents :around ((shimbun shimbun-mainichi)
						    header)
  (shimbun-mainichi-clear-contents shimbun header))

(defun shimbun-mainichi-clear-contents (shimbun header)
  (shimbun-strip-cr)
  (goto-char (point-min))
  (if (and (re-search-forward
	    "<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*class=\"main-text\"" nil t)
	   (shimbun-end-of-tag "div"))
      (let ((hankaku (shimbun-japanese-hankaku shimbun))
	    regexp)
	(delete-region (match-end 2) (point-max))
	(delete-region (point-min) (match-beginning 2))
	(dolist (rm '("class=\"img-left[\t\n ]+ad\""
		      "class=\"txtad\"" "id=\"tools\""))
	  (setq regexp (concat "<div[\t\n ]+\\(?:[^\t\n >]+[\t\n ]+\\)*" rm))
	  (goto-char (point-min))
	  (while (re-search-forward regexp nil t)
	    (when (shimbun-end-of-tag "div" t)
	      (delete-region (goto-char (match-beginning 0)) (match-end 0))
	      (insert "\n"))))
	;; Convert Japanese zenkaku ASCII chars into hankaku.
	(when (and hankaku (not (memq hankaku '(header subject))))
	  (shimbun-japanese-hankaku-buffer t))
	(if (shimbun-prefer-text-plain-internal shimbun)
	    (progn
	      ;; Replace image tags with text.
	      (goto-char (point-min))
	      (while (and (re-search-forward "\\(<img[\t\n ]+\
\\(?:[^\t\n >]+[\t\n ]+\\)*alt=\"\\)[^\"]+"
					     nil t)
			  (shimbun-end-of-tag nil t))
		(replace-match "\n&lt;$B<L??(B&gt;\n"))))
	t)
;;    (erase-buffer)
;;    (insert "<html><body>\
;;$B$3$N5-;v$O$b$&$"$j$^$;$s!#(B<br>\n\
;;\($B$5$b$J$1$l$PDL>o$H$O0[$J$k7A<0$r;H$C$F$$$k$+!"(B<br>\n\
;;&nbsp;$B$^$?$O<hF@$K<:GT$7$?$N$+$b$7$l$^$;$s!#(B)</body></html>\n")
    nil))

(luna-define-method shimbun-multi-clear-contents :around ((shimbun
							   shimbun-mainichi)
							  header
							  has-previous-page
							  has-next-page)
  (shimbun-mainichi-multi-clear-contents shimbun header
					 has-previous-page has-next-page))

(defun shimbun-mainichi-multi-clear-contents (shimbun header
						      has-previous-page
						      has-next-page)
  (when (luna-call-next-method)
    (when has-previous-page
      (goto-char (point-min))
      (insert "&#012;\n"))
    t))

(provide 'sb-mainichi)

;;; sb-mainichi.el ends here
