#lang scribble/manual
@(require racket/runtime-path
         racket/dict
         racket/path
         racket/match
         quickscript/base)

@;TODO: How to have video links in script-help-string? Use scribble/manual too?

@(define-runtime-path scripts-path "scripts")

@;; If calling this function is slow, compile the scripts first.
@(define (get-script-help-strings scripts-path)
  (filter
   values
   (for/list ([filename (in-list (directory-list scripts-path #:build? #f))])
     (define filepath (build-path scripts-path filename))
     (and (script-file? filepath)
          (cons (path->string (path-replace-extension filename #""))
                (get-script-help-string filepath))))))
@(define help-strings (get-script-help-strings scripts-path))


@title{Quickscript Extra}

Some scripts for @(hyperlink "https://github.com/Metaxal/quickscript" "Quickscript"), which must be installed first.

@section{Installation}

In DrRacket, in @code{File|Package manager|Source}, type @code{https://github.com/Metaxal/quickscript-extra.git}.

Or, on the command line, type: @codeblock{raco pkg install quickscript-extra}.

If DrRacket is already running, click on @code{Scripts|Manage scripts|Compile scripts and reload menu}.

@section{Scripts}


@(itemlist
  (for/list ([(name str) (in-dict help-strings)])
     (item @(bold name) ": "
           (let loop ([str str])
             (match str
               ;; link
               [(regexp #px"^(.*)\\[([^]]+)\\]\\(([^)]+)\\)(.*)$" (list _ pre txt link post))
                (list (loop pre)
                      (hyperlink link txt)
                      (loop post))]
               [else str])))))


@section{Uninstall}

Before removing the package, first evaluate @(racket (require quickscript-extra/unregister)), 
or on the command line with @code{$ racket -l quickscript-extra/unregister}.

Then remove the package, either from DrRacket's @code{File} menu, or on the command line with
@code{$ raco pkg remove quickscript-extra}.