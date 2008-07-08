(module terminfo scheme
  (require (lib "1.ss"  "srfi")
           (lib "6.ss"  "srfi")
           (lib "9.ss"  "srfi")
           (lib "11.ss" "srfi")
           (rename-in (lib "13.ss" "srfi") (string-hash s:string-hash))
           (lib "14.ss" "srfi")
           (lib "23.ss" "srfi")
           (lib "60.ss" "srfi")
           (lib "69.ss" "srfi")
           (lib "optional.ss" "srfi"))

  (define-syntax let-optionals
    (syntax-rules ()
      ((let-optionals body ...)
       (let-optionals* body ...))))

  (define ignore void)
  (define (tty-info port) ignore)
  (define (uname) ignore)

  ;; Modify as necessary
  (define (uname:os-name uname)
    (let ((type (system-type 'os)))
      (case type
        ((macosx) "Darwin")
        (else (symbol->string type)))))

  (define (tty-info:output-speed ttyinfo) 'extb)

  (define (path-list->file-name path-list)
    (string-join path-list "/"))

  (define (infix-splitter delimiter)
    (lambda (input-string)
      (string-tokenize input-string
                       (char-set-complement (string->char-set delimiter)))))

  (define (file-readable? filename)
    (member 'read (file-or-directory-permissions filename)))

  (define (file-not-exists? filename)
    (not (file-exists? filename)))

  (define-syntax with-current-input-port
    (syntax-rules ()
      ((with-current-input-port port body ...)
       (parameterize ((current-input-port port)) body ...))))

  (define-syntax with-current-output-port
    (syntax-rules ()
      ((with-current-output-port port body ...)
       (parameterize ((current-output-port port)) body ...))))

  (include "terminfo.scm")
  (include "terminfo-capabilities.scm")
  (include "utilities.scm")

  (provide *current-terminal* *terminfo-directories*
           *capabilities*     capability-available?
           setup-terminal
           console-input-port  console-output-port
           terminal:baud-rate  terminal:port
           terminal:capability terminal:names
           terminal:x-size     terminal:y-size
           tparm tputs

           ;; capabilities
           auto-left-margin
           auto-right-margin
           no-esc-ctlc
           ceol-standout-glitch
           eat-newline-glitch
           erase-overstrike
           generic-type
           hard-copy
           has-meta-key
           has-status-line
           insert-null-glitch
           memory-above
           memory-below
           move-insert-mode
           move-standout-mode
           over-strike
           status-line-esc-ok
           dest-tabs-magic-smso
           tilde-glitch
           transparent-underline
           xon-xoff
           needs-xon-xoff
           prtr-silent
           hard-cursor
           non-rev-rmcup
           no-pad-char
           non-dest-scroll-region
           can-change
           back-color-erase
           hue-lightness-saturation
           col-addr-glitch
           cr-cancels-micro-mode
           has-print-wheel
           row-addr-glitch
           semi-auto-right-margin
           cpi-changes-res
           lpi-changes-res
           backspaces-with-bs
           crt-no-scrolling
           no-correctly-working-cr
           gnu-has-meta-key
           linefeed-is-newline
           has-hardware-tabs
           return-does-clr-eol

           columns
           init-tabs
           lines
           lines-of-memory
           magic-cookie-glitch
           padding-baud-rate
           virtual-terminal
           width-status-line
           num-labels
           label-height
           label-width
           max-attributes
           maximum-windows
           max-colors
           max-pairs
           no-color-video
           buffer-capacity
           dot-vert-spacing
           dot-horz-spacing
           max-micro-address
           max-micro-jump
           micro-col-size
           micro-line-size
           number-of-pins
           output-res-char
           output-res-line
           output-res-horz-inch
           output-res-vert-inch
           print-rate
           wide-char-size
           buttons
           bit-image-entwining
           bit-image-type
           magic-cookie-glitch-ul
           carriage-return-delay
           new-line-delay
           backspace-delay
           horizontal-tab-delay
           number-of-function-keys

           back-tab
           bell
           carriage-return
           change-scroll-region
           clear-all-tabs
           clear-screen
           clr-eol
           clr-eos
           column-address
           command-character
           cursor-address
           cursor-down
           cursor-home
           cursor-invisible
           cursor-left
           cursor-mem-address
           cursor-normal
           cursor-right
           cursor-to-ll
           cursor-up
           cursor-visible
           delete-character
           delete-line
           dis-status-line
           down-half-line
           enter-alt-charset-mode
           enter-blink-mode
           enter-bold-mode
           enter-ca-mode
           enter-delete-mode
           enter-dim-mode
           enter-insert-mode
           enter-secure-mode
           enter-protected-mode
           enter-reverse-mode
           enter-standout-mode
           enter-underline-mode
           erase-chars
           exit-alt-charset-mode
           exit-attribute-mode
           exit-ca-mode
           exit-delete-mode
           exit-insert-mode
           exit-standout-mode
           exit-underline-mode
           flash-screen
           form-feed
           from-status-line
           init-1string
           init-2string
           init-3string
           init-file
           insert-character
           insert-line
           insert-padding
           key-backspace
           key-catab
           key-clear
           key-ctab
           key-dc
           key-dl
           key-down
           key-eic
           key-eol
           key-eos
           key-f0
           key-f1
           key-f10
           key-f2
           key-f3
           key-f4
           key-f5
           key-f6
           key-f7
           key-f8
           key-f9
           key-home
           key-ic
           key-il
           key-left
           key-ll
           key-npage
           key-ppage
           key-right
           key-sf
           key-sr
           key-stab
           key-up
           keypad-local
           keypad-xmit
           lab-f0
           lab-f1
           lab-f10
           lab-f2
           lab-f3
           lab-f4
           lab-f5
           lab-f6
           lab-f7
           lab-f8
           lab-f9
           meta-off
           meta-on
           new-line
           pad-char
           parm-dch
           parm-delete-line
           parm-down-cursor
           parm-ich
           parm-index
           parm-insert-line
           parm-left-cursor
           parm-right-cursor
           parm-rindex
           parm-up-cursor
           pkey-key
           pkey-local
           pkey-xmit
           print-screen
           prtr-off
           prtr-on
           repeat-char
           reset-1string
           reset-2string
           reset-3string
           reset-file
           restore-cursor
           row-address
           save-cursor
           scroll-forward
           scroll-reverse
           set-attributes
           set-tab
           set-window
           tab
           to-status-line
           underline-char
           up-half-line
           init-prog
           key-a1
           key-a3
           key-b2
           key-c1
           key-c3
           prtr-non
           char-padding
           acs-chars
           plab-norm
           key-btab
           enter-xon-mode
           exit-xon-mode
           enter-am-mode
           exit-am-mode
           xon-character
           xoff-character
           ena-acs
           label-on
           label-off
           key-beg
           key-cancel
           key-close
           key-command
           key-copy
           key-create
           key-end
           key-enter
           key-exit
           key-find
           key-help
           key-mark
           key-message
           key-move
           key-next
           key-open
           key-options
           key-previous
           key-print
           key-redo
           key-reference
           key-refresh
           key-replace
           key-restart
           key-resume
           key-save
           key-suspend
           key-undo
           key-sbeg
           key-scancel
           key-scommand
           key-scopy
           key-screate
           key-sdc
           key-sdl
           key-select
           key-send
           key-seol
           key-sexit
           key-sfind
           key-shelp
           key-shome
           key-sic
           key-sleft
           key-smessage
           key-smove
           key-snext
           key-soptions
           key-sprevious
           key-sprint
           key-sredo
           key-sreplace
           key-sright
           key-srsume
           key-ssave
           key-ssuspend
           key-sundo
           req-for-input
           key-f11
           key-f12
           key-f13
           key-f14
           key-f15
           key-f16
           key-f17
           key-f18
           key-f19
           key-f20
           key-f21
           key-f22
           key-f23
           key-f24
           key-f25
           key-f26
           key-f27
           key-f28
           key-f29
           key-f30
           key-f31
           key-f32
           key-f33
           key-f34
           key-f35
           key-f36
           key-f37
           key-f38
           key-f39
           key-f40
           key-f41
           key-f42
           key-f43
           key-f44
           key-f45
           key-f46
           key-f47
           key-f48
           key-f49
           key-f50
           key-f51
           key-f52
           key-f53
           key-f54
           key-f55
           key-f56
           key-f57
           key-f58
           key-f59
           key-f60
           key-f61
           key-f62
           key-f63
           clr-bol
           clear-margins
           set-left-margin
           set-right-margin
           label-format
           set-clock
           display-clock
           remove-clock
           create-window
           goto-window
           hangup
           dial-phone
           quick-dial
           tone
           pulse
           flash-hook
           fixed-pause
           wait-tone
           user0
           user1
           user2
           user3
           user4
           user5
           user6
           user7
           user8
           user9
           orig-pair
           orig-colors
           initialize-color
           initialize-pair
           set-color-pair
           set-foreground
           set-background
           change-char-pitch
           change-line-pitch
           change-res-horz
           change-res-vert
           define-char
           enter-doublewide-mode
           enter-draft-quality
           enter-italics-mode
           enter-leftward-mode
           enter-micro-mode
           enter-near-letter-quality
           enter-normal-quality
           enter-shadow-mode
           enter-subscript-mode
           enter-superscript-mode
           enter-upward-mode
           exit-doublewide-mode
           exit-italics-mode
           exit-leftward-mode
           exit-micro-mode
           exit-shadow-mode
           exit-subscript-mode
           exit-superscript-mode
           exit-upward-mode
           micro-column-address
           micro-down
           micro-left
           micro-right
           micro-row-address
           micro-up
           order-of-pins
           parm-down-micro
           parm-left-micro
           parm-right-micro
           parm-up-micro
           select-char-set
           set-bottom-margin
           set-bottom-margin-parm
           set-left-margin-parm
           set-right-margin-parm
           set-top-margin
           set-top-margin-parm
           start-bit-image
           start-char-set-def
           stop-bit-image
           stop-char-set-def
           subscript-characters
           superscript-characters
           these-cause-cr
           zero-motion
           char-set-names
           key-mouse
           mouse-info
           req-mouse-pos
           get-mouse
           set-a-foreground
           set-a-background
           pkey-plab
           device-type
           code-set-init
           set0-des-seq
           set1-des-seq
           set2-des-seq
           set3-des-seq
           set-lr-margin
           set-tb-margin
           bit-image-repeat
           bit-image-newline
           bit-image-carriage-return
           color-names
           define-bit-image-region
           end-bit-image-region
           set-color-band
           set-page-length
           display-pc-char
           enter-pc-charset-mode
           exit-pc-charset-mode
           enter-scancode-mode
           exit-scancode-mode
           pc-term-options
           scancode-escape
           alt-scancode-esc
           enter-horizontal-hl-mode
           enter-left-hl-mode
           enter-low-hl-mode
           enter-right-hl-mode
           enter-top-hl-mode
           enter-vertical-hl-mode
           set-a-attributes
           set-pglen-inch
           termcap-init2
           termcap-reset
           linefeed-if-not-lf
           backspace-if-not-bs
           other-non-function-keys
           arrow-key-map
           acs-ulcorner
           acs-llcorner
           acs-urcorner
           acs-lrcorner
           acs-ltee
           acs-rtee
           acs-btee
           acs-ttee
           acs-hline
           acs-vline
           acs-plus
           memory-lock
           memory-unlock
           box-chars-1
           )
  )

;;
;; Local Variables:
;; eval: (put 'module 'scheme-indent-function 2)
;; End:
;;